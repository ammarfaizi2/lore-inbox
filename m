Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263683AbTCUSKk>; Fri, 21 Mar 2003 13:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263678AbTCUSJg>; Fri, 21 Mar 2003 13:09:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36739
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263675AbTCUSJD>; Fri, 21 Mar 2003 13:09:03 -0500
Date: Fri, 21 Mar 2003 19:24:18 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211924.h2LJOIat025735@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: rio __NO_VERSION__ 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/rioboot.c linux-2.5.65-ac2/drivers/char/rio/rioboot.c
--- linux-2.5.65/drivers/char/rio/rioboot.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/rioboot.c	2003-03-18 16:58:11.000000000 +0000
@@ -34,7 +34,6 @@
 static char *_rioboot_c_sccs_ = "@(#)rioboot.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/riocmd.c linux-2.5.65-ac2/drivers/char/rio/riocmd.c
--- linux-2.5.65/drivers/char/rio/riocmd.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/riocmd.c	2003-03-18 16:58:11.000000000 +0000
@@ -34,7 +34,6 @@
 static char *_riocmd_c_sccs_ = "@(#)riocmd.c	1.2";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/rioctrl.c linux-2.5.65-ac2/drivers/char/rio/rioctrl.c
--- linux-2.5.65/drivers/char/rio/rioctrl.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/rioctrl.c	2003-03-18 16:58:11.000000000 +0000
@@ -34,7 +34,6 @@
 #endif
 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/rioinit.c linux-2.5.65-ac2/drivers/char/rio/rioinit.c
--- linux-2.5.65/drivers/char/rio/rioinit.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/rioinit.c	2003-03-18 16:58:11.000000000 +0000
@@ -33,7 +33,6 @@
 static char *_rioinit_c_sccs_ = "@(#)rioinit.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/riointr.c linux-2.5.65-ac2/drivers/char/rio/riointr.c
--- linux-2.5.65/drivers/char/rio/riointr.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/riointr.c	2003-03-18 16:58:11.000000000 +0000
@@ -34,7 +34,6 @@
 #endif
 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/rioparam.c linux-2.5.65-ac2/drivers/char/rio/rioparam.c
--- linux-2.5.65/drivers/char/rio/rioparam.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/rioparam.c	2003-03-18 16:58:24.000000000 +0000
@@ -34,7 +34,6 @@
 static char *_rioparam_c_sccs_ = "@(#)rioparam.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/rioroute.c linux-2.5.65-ac2/drivers/char/rio/rioroute.c
--- linux-2.5.65/drivers/char/rio/rioroute.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/rioroute.c	2003-03-18 16:58:24.000000000 +0000
@@ -33,7 +33,6 @@
 static char *_rioroute_c_sccs_ = "@(#)rioroute.c	1.3";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/riotable.c linux-2.5.65-ac2/drivers/char/rio/riotable.c
--- linux-2.5.65/drivers/char/rio/riotable.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/riotable.c	2003-03-18 16:58:24.000000000 +0000
@@ -33,7 +33,6 @@
 static char *_riotable_c_sccs_ = "@(#)riotable.c	1.2";
 #endif
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/rio/riotty.c linux-2.5.65-ac2/drivers/char/rio/riotty.c
--- linux-2.5.65/drivers/char/rio/riotty.c	2003-03-18 16:46:47.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/rio/riotty.c	2003-03-18 16:58:24.000000000 +0000
@@ -36,7 +36,6 @@
 
 #define __EXPLICIT_DEF_H__
 
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
