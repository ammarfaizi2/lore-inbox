Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263680AbTCUWOS>; Fri, 21 Mar 2003 17:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263915AbTCUWND>; Fri, 21 Mar 2003 17:13:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59267
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263680AbTCUS2T>; Fri, 21 Mar 2003 13:28:19 -0500
Date: Fri, 21 Mar 2003 19:43:34 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211943.h2LJhYNK025917@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix pcmcia __NO_VERSION__
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pcmcia/bulkmem.c linux-2.5.65-ac2/drivers/pcmcia/bulkmem.c
--- linux-2.5.65/drivers/pcmcia/bulkmem.c	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pcmcia/bulkmem.c	2003-03-14 00:52:15.000000000 +0000
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pcmcia/cardbus.c linux-2.5.65-ac2/drivers/pcmcia/cardbus.c
--- linux-2.5.65/drivers/pcmcia/cardbus.c	2003-03-06 17:04:28.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pcmcia/cardbus.c	2003-03-14 00:52:15.000000000 +0000
@@ -46,8 +46,6 @@
  */
 
 
-#define __NO_VERSION__
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pcmcia/cistpl.c linux-2.5.65-ac2/drivers/pcmcia/cistpl.c
--- linux-2.5.65/drivers/pcmcia/cistpl.c	2003-03-03 19:20:10.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pcmcia/cistpl.c	2003-03-14 00:52:15.000000000 +0000
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pcmcia/rsrc_mgr.c linux-2.5.65-ac2/drivers/pcmcia/rsrc_mgr.c
--- linux-2.5.65/drivers/pcmcia/rsrc_mgr.c	2003-02-10 18:38:43.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pcmcia/rsrc_mgr.c	2003-03-14 00:52:15.000000000 +0000
@@ -31,8 +31,6 @@
     
 ======================================================================*/
 
-#define __NO_VERSION__
-
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
