Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTCUVdY>; Fri, 21 Mar 2003 16:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263749AbTCUVc1>; Fri, 21 Mar 2003 16:32:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:8068
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263728AbTCUSg5>; Fri, 21 Mar 2003 13:36:57 -0500
Date: Fri, 21 Mar 2003 19:52:12 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211952.h2LJqCEF026079@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from intermezzo
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/cache.c linux-2.5.65-ac2/fs/intermezzo/cache.c
--- linux-2.5.65/fs/intermezzo/cache.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/cache.c	2003-03-18 17:08:01.000000000 +0000
@@ -20,7 +20,6 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/dcache.c linux-2.5.65-ac2/fs/intermezzo/dcache.c
--- linux-2.5.65/fs/intermezzo/dcache.c	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/dcache.c	2003-03-14 00:52:26.000000000 +0000
@@ -31,7 +31,6 @@
  * with heavy changes by Linus Torvalds
  */
 
-#define __NO_VERSION__
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/dir.c linux-2.5.65-ac2/fs/intermezzo/dir.c
--- linux-2.5.65/fs/intermezzo/dir.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/dir.c	2003-03-18 17:08:01.000000000 +0000
@@ -40,7 +40,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include "intermezzo_fs.h"
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/ext_attr.c linux-2.5.65-ac2/fs/intermezzo/ext_attr.c
--- linux-2.5.65/fs/intermezzo/ext_attr.c	2003-02-10 18:38:44.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/ext_attr.c	2003-03-14 00:52:26.000000000 +0000
@@ -22,7 +22,6 @@
  * Extended attribute handling for presto.
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/file.c linux-2.5.65-ac2/fs/intermezzo/file.c
--- linux-2.5.65/fs/intermezzo/file.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/file.c	2003-03-18 17:08:01.000000000 +0000
@@ -45,7 +45,6 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/fsfilter.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/inode.c linux-2.5.65-ac2/fs/intermezzo/inode.c
--- linux-2.5.65/fs/intermezzo/inode.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/inode.c	2003-03-14 00:52:26.000000000 +0000
@@ -24,7 +24,6 @@
  * Super block/filesystem wide operations
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/kml.c linux-2.5.65-ac2/fs/intermezzo/kml.c
--- linux-2.5.65/fs/intermezzo/kml.c	2003-02-10 18:37:54.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/kml.c	2003-03-14 00:52:26.000000000 +0000
@@ -1,7 +1,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/kml_decode.c linux-2.5.65-ac2/fs/intermezzo/kml_decode.c
--- linux-2.5.65/fs/intermezzo/kml_decode.c	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/kml_decode.c	2003-03-14 00:52:26.000000000 +0000
@@ -5,7 +5,6 @@
  *
  * Copyright (C) 2001 Mountainview Data, Inc.
  */
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/kml_reint.c linux-2.5.65-ac2/fs/intermezzo/kml_reint.c
--- linux-2.5.65/fs/intermezzo/kml_reint.c	2003-02-10 18:38:52.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/kml_reint.c	2003-03-14 00:52:26.000000000 +0000
@@ -22,7 +22,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/kml_setup.c linux-2.5.65-ac2/fs/intermezzo/kml_setup.c
--- linux-2.5.65/fs/intermezzo/kml_setup.c	2003-02-10 18:38:37.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/kml_setup.c	2003-03-14 00:52:26.000000000 +0000
@@ -1,7 +1,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/methods.c linux-2.5.65-ac2/fs/intermezzo/methods.c
--- linux-2.5.65/fs/intermezzo/methods.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/methods.c	2003-03-18 17:08:23.000000000 +0000
@@ -40,7 +40,6 @@
 #include <linux/smp_lock.h>
 #include <linux/blkdev.h>
 #include <linux/init.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/fsfilter.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/replicator.c linux-2.5.65-ac2/fs/intermezzo/replicator.c
--- linux-2.5.65/fs/intermezzo/replicator.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/replicator.c	2003-03-18 17:08:23.000000000 +0000
@@ -23,7 +23,6 @@
  *
  */
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <asm/uaccess.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/fs/intermezzo/super.c linux-2.5.65-ac2/fs/intermezzo/super.c
--- linux-2.5.65/fs/intermezzo/super.c	2003-03-18 16:46:51.000000000 +0000
+++ linux-2.5.65-ac2/fs/intermezzo/super.c	2003-03-18 17:08:23.000000000 +0000
@@ -42,7 +42,6 @@
 #include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include "intermezzo_fs.h"
