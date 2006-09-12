Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWILMAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWILMAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWILMAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:00:19 -0400
Received: from server6.greatnet.de ([83.133.96.26]:59369 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932231AbWILMAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:00:18 -0400
Message-ID: <4506A15B.1080006@nachtwindheim.de>
Date: Tue, 12 Sep 2006 14:00:27 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: stern@rowland.harvard.edu, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [MM] fixes kerneldoc errors in usbcore-auto(susp/res)-patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Fixes kerneldoc errors on usb/core/driver.c, which occured in 2.6.18-rc6-mm2 
gregkh-usb-usbcore-add-autosuspend-autoresume-infrastructure.patch
Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

---

--- linux-2.6.18-rc6-mm2/drivers/usb/core/driver.c	2006-09-12 13:31:56.000000000 +0200
+++ devel/drivers/usb/core/driver.c	2006-09-12 13:33:12.000000000 +0200
@@ -1102,8 +1102,8 @@
 
 /**
  * usb_autosuspend_device - delayed autosuspend of a USB device and its interfaces
- * @udev - the usb_device to autosuspend
- * @dec_usage_cnt - flag to decrement @udev's PM-usage counter
+ * @udev: the usb_device to autosuspend
+ * @dec_usage_cnt: flag to decrement @udev's PM-usage counter
  *
  * This routine should be called when a core subsystem is finished using
  * @udev and wants to allow it to autosuspend.  Examples would be when
@@ -1139,8 +1139,8 @@
 
 /**
  * usb_autoresume_device - immediately autoresume a USB device and its interfaces
- * @udev - the usb_device to autoresume
- * @inc_usage_cnt - flag to increment @udev's PM-usage counter
+ * @udev: the usb_device to autoresume
+ * @inc_usage_cnt: flag to increment @udev's PM-usage counter
  *
  * This routine should be called when a core subsystem wants to use @udev
  * and needs to guarantee that it is not suspended.  In addition, the
@@ -1180,7 +1180,7 @@
 
 /**
  * usb_autopm_put_interface - decrement a USB interface's PM-usage counter
- * @intf - the usb_interface whose counter should be decremented
+ * @intf: the usb_interface whose counter should be decremented
  *
  * This routine should be called by an interface driver when it is
  * finished using @intf and wants to allow it to autosuspend.  A typical
@@ -1227,7 +1227,7 @@
 
 /**
  * usb_autopm_get_interface - increment a USB interface's PM-usage counter
- * @intf - the usb_interface whose counter should be incremented
+ * @intf: the usb_interface whose counter should be incremented
  *
  * This routine should be called by an interface driver when it wants to
  * use @intf and needs to guarantee that it is not suspended.  In addition,


