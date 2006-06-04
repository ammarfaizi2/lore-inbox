Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932113AbWFDJkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFDJkG (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 05:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWFDJkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 05:40:06 -0400
Received: from mx01.qsc.de ([213.148.129.14]:151 "EHLO mx01.qsc.de")
	by vger.kernel.org with ESMTP id S1751264AbWFDJkE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 05:40:04 -0400
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCODE
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add Apple MacBook product IDs to usbhid
Date: Sun, 4 Jun 2006 11:39:09 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606041139.09533.rene@exactcode.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This adds the Apple MacBook product IDs for the Fn translation
to the usbhid.

Signed-off-by: René Rebe <rene@exactcode.de>

--- ./drivers/usb/input/hid-core.c.orig	2006-06-01 15:52:13.000000000 +0200
+++ ./drivers/usb/input/hid-core.c	2006-06-01 15:54:09.000000000 +0200
@@ -1602,6 +1602,9 @@
 	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0217, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0218, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0219, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
 

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45
