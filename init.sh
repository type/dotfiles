#!/bin/bash

# Exit on error
set -e
cd

# Backup existing files
backup_dir="dotfiles_backup"
mkdir $backup_dir

for i in \
	"bash_profile"\
	"gitmodules"\
	"bashrc"\
	"bash"\
	"vimrc"\
	"vim"\
	"git"
do
	if [ -e ".$i" ]; then
		echo -e "\e[1;31mMoving .$i to $backup_dir/$i\e[m"
		mv ".$i" "$backup_dir/$i"
	fi
done


# Pull down repo
git init
git remote add origin git://github.com/alexdavid/dotfiles.git
git fetch
git branch master origin/master
git checkout master

# Pull git submodules recursively
git submodule update --init --recursive


# Move readme & init.sh to the backup folder
mv readme dotfiles_backup/
mv init.sh dotfiles_backup/


# .gitignore_global file
git config --global core.excludesfile ~/.gitignore_global
