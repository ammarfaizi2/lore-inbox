Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWIFAhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWIFAhF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 20:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWIFAhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 20:37:04 -0400
Received: from reiner-h.de ([83.151.27.91]:10729 "EHLO reiner-h.de")
	by vger.kernel.org with ESMTP id S1751526AbWIFAhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 20:37:01 -0400
From: Reiner Herrmann <reiner@reiner-h.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] usb/input/usbmouse.c: whitespace cleanup
Date: Wed, 6 Sep 2006 02:37:21 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609060237.22058.reiner@reiner-h.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spaces with tab and change comment indention for better readability.

Signed-off-by: Reiner Herrmann <reiner@reiner-h.de>
---

diff -uprN -X linux-2.6.18-rc4/Documentation/dontdiff linux-2.6.18-rc4/drivers/usb/input/usbmouse.c linux-work/drivers/usb/input/usbmouse.c
--- linux-2.6.18-rc4/drivers/usb/input/usbmouse.c	2006-08-13 16:30:20.000000000 +0200
+++ linux-work/drivers/usb/input/usbmouse.c	2006-09-06 02:27:52.000000000 +0200
@@ -218,7 +218,7 @@ static void usb_mouse_disconnect(struct 
 
 static struct usb_device_id usb_mouse_id_table [] = {
 	{ USB_INTERFACE_INFO(3, 1, 2) },
-    { }						/* Terminating entry */
+	{ }	/* Terminating entry */
 };
 
 MODULE_DEVICE_TABLE (usb, usb_mouse_id_table);
