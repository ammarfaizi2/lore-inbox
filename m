Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUDMJUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDMJTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:19:35 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:58539 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263370AbUDMJTa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:19:30 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [PATCH 3/3] USB speedtouch: bump the version number
Date: Tue, 13 Apr 2004 11:19:26 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131119.26807.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, this patch bumps the speedtouch driver's version number.
It also adds the version number to the module description, so people
can see it with modinfo.  I also added a MODULE_VERSION line (why?
because it was there...)  The patch is against your 2.6 kernel tree.

 speedtch.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:51 2004
+++ b/drivers/usb/misc/speedtch.c	Tue Apr 13 10:57:51 2004
@@ -106,8 +106,8 @@
 #endif
 
 #define DRIVER_AUTHOR	"Johan Verrept, Duncan Sands <duncan.sands@free.fr>"
-#define DRIVER_DESC	"Alcatel SpeedTouch USB driver"
-#define DRIVER_VERSION	"1.7"
+#define DRIVER_VERSION	"1.8"
+#define DRIVER_DESC	"Alcatel SpeedTouch USB driver version " DRIVER_VERSION
 
 static const char udsl_driver_name [] = "speedtch";
 
@@ -1347,6 +1347,7 @@
 MODULE_AUTHOR (DRIVER_AUTHOR);
 MODULE_DESCRIPTION (DRIVER_DESC);
 MODULE_LICENSE ("GPL");
+MODULE_VERSION (DRIVER_VERSION);
 
 
 /************
