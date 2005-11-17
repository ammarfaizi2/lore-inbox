Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVKQSEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVKQSEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVKQSEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 13:04:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:3746 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932457AbVKQSEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 13:04:01 -0500
Date: Thu, 17 Nov 2005 09:47:32 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       lcapitulino@mandriva.com.br
Subject: [patch 12/22] USB: pl2303: adds new IDs.
Message-ID: <20051117174732.GM11174@kroah.com>
References: <20051117174227.007572000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-pl2303-adds-new-ids.patch"
In-Reply-To: <20051117174609.GA11174@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>


This patch adds two new Siemens mobiles IDs for the pl2303 driver.

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/usb/serial/pl2303.c |    2 ++
 drivers/usb/serial/pl2303.h |    2 ++
 2 files changed, 4 insertions(+)

--- usb-2.6.orig/drivers/usb/serial/pl2303.c
+++ usb-2.6/drivers/usb/serial/pl2303.c
@@ -71,7 +71,9 @@ static struct usb_device_id id_table [] 
 	{ USB_DEVICE(SITECOM_VENDOR_ID, SITECOM_PRODUCT_ID) },
 	{ USB_DEVICE(ALCATEL_VENDOR_ID, ALCATEL_PRODUCT_ID) },
 	{ USB_DEVICE(SAMSUNG_VENDOR_ID, SAMSUNG_PRODUCT_ID) },
+	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_SX1) },
 	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_X65) },
+	{ USB_DEVICE(SIEMENS_VENDOR_ID, SIEMENS_PRODUCT_ID_X75) },
 	{ USB_DEVICE(SYNTECH_VENDOR_ID, SYNTECH_PRODUCT_ID) },
 	{ USB_DEVICE( NOKIA_CA42_VENDOR_ID, NOKIA_CA42_PRODUCT_ID ) },
 	{ }					/* Terminating entry */
--- usb-2.6.orig/drivers/usb/serial/pl2303.h
+++ usb-2.6/drivers/usb/serial/pl2303.h
@@ -54,7 +54,9 @@
 #define SAMSUNG_PRODUCT_ID	0x8001
 
 #define SIEMENS_VENDOR_ID	0x11f5
+#define SIEMENS_PRODUCT_ID_SX1	0x0001
 #define SIEMENS_PRODUCT_ID_X65	0x0003
+#define SIEMENS_PRODUCT_ID_X75	0x0004
 
 #define SYNTECH_VENDOR_ID	0x0745
 #define SYNTECH_PRODUCT_ID	0x0001

--
