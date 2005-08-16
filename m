Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVHPWRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVHPWRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 18:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVHPWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 18:17:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:21137 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751015AbVHPWQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 18:16:59 -0400
Date: Tue, 16 Aug 2005 15:16:46 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: [patch 7/7] USB: usbmon: Copyrights and a typo
Message-ID: <20050816221646.GH28619@kroah.com>
References: <20050816220001.699316000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-usbmon-copyright.patch"
In-Reply-To: <20050816221527.GA28619@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>

Add copyright statements and fix a typo.

Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/mon/mon_main.c |    4 +++-
 drivers/usb/mon/usb_mon.h  |    2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- gregkh-2.6.orig/drivers/usb/mon/mon_main.c	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/drivers/usb/mon/mon_main.c	2005-08-15 23:40:15.000000000 -0700
@@ -2,6 +2,8 @@
  * The USB Monitor, inspired by Dave Harding's USBMon.
  *
  * mon_main.c: Main file, module initiation and exit, registrations, etc.
+ *
+ * Copyright (C) 2005 Pete Zaitcev (zaitcev@redhat.com)
  */
 
 #include <linux/kernel.h>
@@ -311,7 +313,7 @@
 
 	mondir = debugfs_create_dir("usbmon", NULL);
 	if (IS_ERR(mondir)) {
-		printk(KERN_NOTICE TAG ": debugs is not available\n");
+		printk(KERN_NOTICE TAG ": debugfs is not available\n");
 		return -ENODEV;
 	}
 	if (mondir == NULL) {
--- gregkh-2.6.orig/drivers/usb/mon/usb_mon.h	2005-08-15 23:40:08.000000000 -0700
+++ gregkh-2.6/drivers/usb/mon/usb_mon.h	2005-08-15 23:40:15.000000000 -0700
@@ -1,5 +1,7 @@
 /*
  * The USB Monitor, inspired by Dave Harding's USBMon.
+ *
+ * Copyright (C) 2005 Pete Zaitcev (zaitcev@redhat.com)
  */
 
 #ifndef __USB_MON_H

--
