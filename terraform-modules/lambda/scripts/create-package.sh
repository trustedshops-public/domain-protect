#!/bin/bash
set -e

echo "Executing create_package.sh..."

function_list=${function_names//:/ }

for i in $function_list
do
  dir_name=lambda_dist_pkg_$i/
  mkdir -p $path_module/build/$dir_name

  # Installing python dependencies...
  FILE=$path_module/code/$i/requirements.txt

  if [ -f "$FILE" ]; then
    echo "Installing dependencies..."
    echo "From: requirements.txt file exists..."
    pip3 install -r "$FILE" -t $path_module/build/$dir_name/

  else
    echo "Error: requirements.txt does not exist!"
  fi

  # Create deployment package...
  echo "Creating deployment package..."
  cp $path_module/code/$i/$i.py $path_module/build/$dir_name

# Removing virtual environment folder...
echo "Removing virtual environment folder..."
rm -rf $path_cwd/env_$i

done

echo "Finished script execution!"
