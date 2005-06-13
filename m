Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFMTpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFMTpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVFMTn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:43:26 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:36553 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261236AbVFMTjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:39:43 -0400
Date: Mon, 13 Jun 2005 12:27:51 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: patrick.boettcher@desy.de, akpm <akpm@osdl.org>
Subject: [PATCH -mm] dvb: dibusb needs license
Message-Id: <20050613122751.4e7820b4.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Module needs a license to prevent kernel tainting.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 drivers/media/dvb/dvb-usb/dibusb-common.c |    2 +-
 drivers/media/dvb/dvb-usb/dvb-usb.h       |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/media/dvb/dvb-usb/dibusb-common.c~taint_dvb ./drivers/media/dvb/dvb-usb/dibusb-common.c
--- ./drivers/media/dvb/dvb-usb/dibusb-common.c~taint_dvb	2005-06-10 18:42:28.000000000 -0700
+++ ./drivers/media/dvb/dvb-usb/dibusb-common.c	2005-06-13 11:07:17.000000000 -0700
@@ -13,6 +13,7 @@
 static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info (|-able))." DVB_USB_DEBUG_STATUS);
+MODULE_LICENSE("GPL");
 
 #define deb_info(args...) dprintk(debug,0x01,args)
 
@@ -269,4 +270,3 @@ int dibusb_rc_query(struct dvb_usb_devic
 	return 0;
 }
 EXPORT_SYMBOL(dibusb_rc_query);
-
diff -Naurp ./drivers/media/dvb/dvb-usb/dvb-usb.h~taint_dvb ./drivers/media/dvb/dvb-usb/dvb-usb.h
--- ./drivers/media/dvb/dvb-usb/dvb-usb.h~taint_dvb	2005-06-10 18:42:28.000000000 -0700
+++ ./drivers/media/dvb/dvb-usb/dvb-usb.h	2005-06-13 10:42:18.000000000 -0700
@@ -10,6 +10,7 @@
 
 #include <linux/config.h>
 #include <linux/input.h>
+#include <linux/module.h>
 #include <linux/usb.h>
 
 #include "dvb_frontend.h"


---
