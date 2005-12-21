Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVLUBWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVLUBWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 20:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVLUBWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 20:22:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9745 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932229AbVLUBWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 20:22:45 -0500
Date: Wed, 21 Dec 2005 02:22:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: bfennema@falcon.csc.calpoly.edu
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove pointers to the defunct UDF mailing list
Message-ID: <20051221012243.GC5359@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes pointers to the defunct UDF mailing list.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 MAINTAINERS               |    1 -
 fs/udf/balloc.c           |    5 -----
 fs/udf/crc.c              |    5 -----
 fs/udf/dir.c              |    5 -----
 fs/udf/directory.c        |    5 -----
 fs/udf/file.c             |    5 -----
 fs/udf/fsync.c            |    5 -----
 fs/udf/ialloc.c           |    5 -----
 fs/udf/inode.c            |    5 -----
 fs/udf/lowlevel.c         |    5 -----
 fs/udf/misc.c             |    5 -----
 fs/udf/namei.c            |    5 -----
 fs/udf/partition.c        |    5 -----
 fs/udf/super.c            |    5 -----
 fs/udf/symlink.c          |    5 -----
 fs/udf/truncate.c         |    5 -----
 fs/udf/unicode.c          |    5 -----
 include/linux/udf_fs.h    |    5 -----
 include/linux/udf_fs_i.h  |    5 -----
 include/linux/udf_fs_sb.h |    5 -----
 20 files changed, 96 deletions(-)

--- linux-2.6.15-rc5-mm3-full/MAINTAINERS.old	2005-12-20 23:32:26.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/MAINTAINERS	2005-12-20 23:32:37.000000000 +0100
@@ -2619,7 +2619,6 @@
 UDF FILESYSTEM
 P:	Ben Fennema
 M:	bfennema@falcon.csc.calpoly.edu
-L:	linux_udf@hpesjro.fc.hp.com
 W:	http://linux-udf.sourceforge.net
 S:	Maintained
 
--- linux-2.6.15-rc5-mm3-full/include/linux/udf_fs.h.old	2005-12-20 23:32:45.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/udf_fs.h	2005-12-20 23:32:53.000000000 +0100
@@ -13,11 +13,6 @@
  *    http://www.osta.org/ *    http://www.ecma.ch/
  *    http://www.iso.org/
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/include/linux/udf_fs_i.h.old	2005-12-20 23:33:00.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/udf_fs_i.h	2005-12-20 23:33:06.000000000 +0100
@@ -3,11 +3,6 @@
  *
  * This file is intended for the Linux kernel/module. 
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/include/linux/udf_fs_sb.h.old	2005-12-20 23:33:23.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/include/linux/udf_fs_sb.h	2005-12-20 23:33:30.000000000 +0100
@@ -3,11 +3,6 @@
  * 
  * This include file is for the Linux kernel/module.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/balloc.c.old	2005-12-20 23:33:38.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/balloc.c	2005-12-20 23:33:43.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Block allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/crc.c.old	2005-12-20 23:33:51.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/crc.c	2005-12-20 23:33:59.000000000 +0100
@@ -14,11 +14,6 @@
  *
  *	AT&T gives permission for the free use of the CRC source code.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/dir.c.old	2005-12-20 23:34:16.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/dir.c	2005-12-20 23:34:21.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Directory handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/directory.c.old	2005-12-20 23:34:29.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/directory.c	2005-12-20 23:34:34.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Directory related functions
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/file.c.old	2005-12-20 23:34:42.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/file.c	2005-12-20 23:34:47.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *  File handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *    linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/fsync.c.old	2005-12-20 23:34:56.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/fsync.c	2005-12-20 23:35:01.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Fsync handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *      linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/ialloc.c.old	2005-12-20 23:35:16.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/ialloc.c	2005-12-20 23:35:22.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Inode allocation handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/inode.c.old	2005-12-20 23:35:41.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/inode.c	2005-12-20 23:35:46.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Inode handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *    linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/lowlevel.c.old	2005-12-20 23:35:55.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/lowlevel.c	2005-12-20 23:36:00.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *  Low Level Device Routines for the UDF filesystem
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/misc.c.old	2005-12-20 23:36:07.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/misc.c	2005-12-20 23:36:13.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Miscellaneous routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/namei.c.old	2005-12-20 23:36:21.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/namei.c	2005-12-20 23:36:25.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *      Inode name handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *      E-mail regarding any portion of the Linux UDF file system should be
- *      directed to the development team mailing list (run by majordomo):
- *              linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *      This file is distributed under the terms of the GNU General Public
  *      License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/partition.c.old	2005-12-20 23:36:33.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/partition.c	2005-12-20 23:36:38.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *      Partition handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *      E-mail regarding any portion of the Linux UDF file system should be
- *      directed to the development team mailing list (run by majordomo):
- *              linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *      This file is distributed under the terms of the GNU General Public
  *      License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/super.c.old	2005-12-20 23:36:46.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/super.c	2005-12-20 23:36:51.000000000 +0100
@@ -14,11 +14,6 @@
  *    http://www.ecma.ch/
  *    http://www.iso.org/
  *
- * CONTACTS
- *  E-mail regarding any portion of the Linux UDF file system should be
- *  directed to the development team mailing list (run by majordomo):
- *	  linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *  This file is distributed under the terms of the GNU General Public
  *  License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/symlink.c.old	2005-12-20 23:36:59.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/symlink.c	2005-12-20 23:37:04.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Symlink handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/truncate.c.old	2005-12-20 23:37:12.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/truncate.c	2005-12-20 23:37:17.000000000 +0100
@@ -4,11 +4,6 @@
  * PURPOSE
  *	Truncate handling routines for the OSTA-UDF(tm) filesystem.
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:
--- linux-2.6.15-rc5-mm3-full/fs/udf/unicode.c.old	2005-12-20 23:37:24.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/fs/udf/unicode.c	2005-12-20 23:37:31.000000000 +0100
@@ -11,11 +11,6 @@
  *	UTF-8 is explained in the IETF RFC XXXX.
  *		ftp://ftp.internic.net/rfc/rfcxxxx.txt
  *
- * CONTACTS
- *	E-mail regarding any portion of the Linux UDF file system should be
- *	directed to the development team's mailing list (run by majordomo):
- *		linux_udf@hpesjro.fc.hp.com
- *
  * COPYRIGHT
  *	This file is distributed under the terms of the GNU General Public
  *	License (GPL). Copies of the GPL can be obtained from:

