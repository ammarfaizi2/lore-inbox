Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263656AbTCUSHj>; Fri, 21 Mar 2003 13:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTCUSGw>; Fri, 21 Mar 2003 13:06:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32899
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263346AbTCUSGF>; Fri, 21 Mar 2003 13:06:05 -0500
Date: Fri, 21 Mar 2003 19:21:20 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211921.h2LJLK6w025705@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION__ for ftape
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/ftape/lowlevel/ftape_syms.c linux-2.5.65-ac2/drivers/char/ftape/lowlevel/ftape_syms.c
--- linux-2.5.65/drivers/char/ftape/lowlevel/ftape_syms.c	2003-03-06 17:04:25.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/ftape/lowlevel/ftape_syms.c	2003-03-14 00:52:15.000000000 +0000
@@ -26,7 +26,6 @@
  */
 
 #include <linux/config.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/ftape.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/ftape/zftape/zftape-ctl.c linux-2.5.65-ac2/drivers/char/ftape/zftape/zftape-ctl.c
--- linux-2.5.65/drivers/char/ftape/zftape/zftape-ctl.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/ftape/zftape/zftape-ctl.c	2003-03-14 00:52:15.000000000 +0000
@@ -27,7 +27,6 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-#define __NO_VERSION__
 #include <linux/module.h>
 #include <linux/fcntl.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/ftape/zftape/zftape_syms.c linux-2.5.65-ac2/drivers/char/ftape/zftape/zftape_syms.c
--- linux-2.5.65/drivers/char/ftape/zftape/zftape_syms.c	2003-02-10 18:37:57.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/ftape/zftape/zftape_syms.c	2003-03-14 00:52:15.000000000 +0000
@@ -24,7 +24,6 @@
  *      the ftape floppy tape driver exports 
  */		 
 
-#define __NO_VERSION__
 #include <linux/module.h>
 
 #include <linux/zftape.h>
