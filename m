Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263726AbTCUSXo>; Fri, 21 Mar 2003 13:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263714AbTCUSXg>; Fri, 21 Mar 2003 13:23:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50563
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263723AbTCUSXJ>; Fri, 21 Mar 2003 13:23:09 -0500
Date: Fri, 21 Mar 2003 19:38:24 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211938.h2LJcOKt025851@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: remove __NO_VERSION__ from saa7134 driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-i2c.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-i2c.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-i2c.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-i2c.c	2003-03-18 17:00:14.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-oss.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-oss.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-oss.c	2003-02-10 18:38:31.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-oss.c	2003-03-14 00:52:15.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-ts.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-ts.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-ts.c	2003-02-10 18:37:56.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-ts.c	2003-03-14 00:52:15.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-tvaudio.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-tvaudio.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-02-15 03:39:30.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-tvaudio.c	2003-03-14 00:52:15.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-vbi.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-vbi.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-vbi.c	2003-02-10 18:38:54.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-vbi.c	2003-03-14 00:52:15.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/media/video/saa7134/saa7134-video.c linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-video.c
--- linux-2.5.65/drivers/media/video/saa7134/saa7134-video.c	2003-03-18 16:46:48.000000000 +0000
+++ linux-2.5.65-ac2/drivers/media/video/saa7134/saa7134-video.c	2003-03-18 17:00:14.000000000 +0000
@@ -19,8 +19,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define __NO_VERSION__ 1
-
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/module.h>
