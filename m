Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263877AbTCUTjP>; Fri, 21 Mar 2003 14:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263878AbTCUTiT>; Fri, 21 Mar 2003 14:38:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:901
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263869AbTCUTf3>; Fri, 21 Mar 2003 14:35:29 -0500
Date: Fri, 21 Mar 2003 20:50:45 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212050.h2LKojNB026545@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from bttv
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/bttv-cards.c linux-2.5.65-ac2/drivers/media/video/bttv-cards.c
--- linux-2.5.65/drivers/media/video/bttv-cards.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/bttv-cards.c	2003-03-18 17:00:00.000000000 +0000
@@ -24,8 +24,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/delay.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/bttv-if.c linux-2.5.65-ac2/drivers/media/video/bttv-if.c
--- linux-2.5.65/drivers/media/video/bttv-if.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/bttv-if.c	2003-03-18 17:00:00.000000000 +0000
@@ -25,8 +25,6 @@
     
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/bttv-risc.c linux-2.5.65-ac2/drivers/media/video/bttv-risc.c
--- linux-2.5.65/drivers/media/video/bttv-risc.c	2003-02-10 18:38:37.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/bttv-risc.c	2003-03-14 00:52:15.000000000 +0000
@@ -23,8 +23,6 @@
 
 */
 
-#define __NO_VERSION__ 1
-
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
