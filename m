Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264425AbTLQOre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbTLQOq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:46:26 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:30156 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S264422AbTLQOpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:45:04 -0500
Subject: [PATCH 2.4] Wolfson AC97 touch screen driver - documentation
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-TsBnJXCF2M3TXNOGTE94"
Message-Id: <1071672300.23686.2638.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 17 Dec 2003 14:45:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TsBnJXCF2M3TXNOGTE94
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch updates the driver documentation to reflect the use of the
kernel input event interface.

Patch is against 2.4.24-pre1

Liam

--=-TsBnJXCF2M3TXNOGTE94
Content-Disposition: attachment; filename=wm97xx-docs.diff
Content-Type: text/x-patch; name=wm97xx-docs.diff; charset=
Content-Transfer-Encoding: 7bit

diff -urN a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2003-12-17 11:59:19.000000000 +0000
+++ b/Documentation/Configure.help	2003-12-17 14:04:13.000000000 +0000
@@ -28651,13 +28651,6 @@
   Please see Documentation/wolfson-touchscreen.txt for
   a complete list of parameters.
   
-  In order to use this driver, a char device called wm97xx with a major
-  number of 10 and minor number 16 will have to be created under 
-  /dev/touchscreen.
-  
-  e.g.
-  mknod /dev/touchscreen/wm97xx c 10 16
-
   If you want to compile this as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
   say M here.  The module will be called ac97_plugin_wm97xx.o.
diff -urN a/Documentation/wolfson-touchscreen.txt b/Documentation/wolfson-touchscreen.txt
--- a/Documentation/wolfson-touchscreen.txt	2003-11-28 18:26:19.000000000 +0000
+++ b/Documentation/wolfson-touchscreen.txt	2003-12-17 14:00:03.000000000 +0000
@@ -37,12 +37,8 @@
 Driver Usage
 ============
 
-In order to use this driver, a char device called wm97xx with a major
-number of 10 and minor number 16 will have to be created under 
-/dev/touchscreen.
-  
-e.g.
-mknod /dev/touchscreen/wm97xx c 10 16
+This driver uses the kernel input event interface. Please see 
+Documentation/input/input.txt section 3.2.4 for details.
 
 
 Driver Parameters

--=-TsBnJXCF2M3TXNOGTE94--

