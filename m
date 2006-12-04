Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936413AbWLDMqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936413AbWLDMqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936311AbWLDMfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:35:01 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51166 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936275AbWLDMet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:34:49 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: Unionfs: Stackable namespace unification filesystem
Date: Mon,  4 Dec 2006 07:30:33 -0500
Message-Id: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are in a git repo at:

git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/unionfs.git

(master.kernel.org:/pub/scm/linux/kernel/git/jsipek/unionfs.git)

The repository contains the following 35 commits (also available as patches
in replies to this email).

Commits 1..9 (already in -mm):
	These patches are already in Andrew Morton's -mm tree.

	fsstack: Introduce fsstack_copy_{attr,inode}_*
	fsstack: Remove unneeded wrapper
	eCryptfs: Use fsstack's generic copy inode attr functions
	fsstack: Fix up eCryptfs compilation
	struct path: Rename Reiserfs's struct path
	struct path: Rename DM's struct path
	struct path: Move struct path from fs/namei.c into include/linux
	struct path: make eCryptfs a user of struct path
	fs/stack.c should #include <linux/fs_stack.h>

Commits 10..11 (additional fixes to the above)
	These patches are not yet in -mm, and they fix two things the above
	patches missed.

	fsstack: Make fsstack_copy_attr_all copy inode size
	fsstack: Fix up ecryptfs's fsstack usage

Commits 12..35 (Unionfs):
	These patches make up stripped down version of Unionfs. They depend
	on fsstack (see above patches).

	Unionfs: Documentation
	lookup_one_len_nd - lookup_one_len with nameidata argument
	Unionfs: Branch management functionality
	Unionfs: Common file operations
	Unionfs: Copyup Functionality
	Unionfs: Dentry operations
	Unionfs: File operations
	Unionfs: Directory file operations
	Unionfs: Directory manipulation helper functions
	Unionfs: Inode operations
	Unionfs: Lookup helper functions
	Unionfs: Main module functions
	Unionfs: Readdir state
	Unionfs: Rename
	Unionfs: Privileged operations workqueue
	Unionfs: Handling of stale inodes
	Unionfs: Miscellaneous helper functions
	Unionfs: Superblock operations
	Unionfs: Helper macros/inlines
	Unionfs: Internal include file
	Unionfs: Include file
	Unionfs: Unlink
	Unionfs: Kconfig and Makefile
	Unionfs: Extended Attributes support


As always, comments are welcomed.

Thanks,

Josef "Jeff" Sipek.
jsipek@cs.sunysb.edu
