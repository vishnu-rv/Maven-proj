# Use an image that includes Maven and Java
FROM maven:3.8.5-openjdk-17-slim AS build

# Set working directory inside the container
WORKDIR /app

# Copy the application code into the container
COPY . .

# Build the application with Maven
RUN mvn clean package -DskipTests

# Use a lightweight Java runtime for the final image
FROM openjdk:17-jdk-slim

# Set working directory for the runtime
WORKDIR /opt/app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

