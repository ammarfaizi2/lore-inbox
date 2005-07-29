Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVG3CKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVG3CKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 22:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbVG3CIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 22:08:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262765AbVG2TRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:52 -0400
Date: Fri, 29 Jul 2005 12:17:29 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, matt@minas-morgul.org
Subject: [patch 25/29] USB: drivers/net/usb/zd1201.c: Gigabyte GN-WLBZ201 dongle usbid
Message-ID: <20050729191729.GA5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mathieu" <matt@minas-morgul.org>

Gigabyte GN-WLBZ201 wifi usb dongle works very well, using the zd1201
driver. the only missing part is that the corresponding usbid is not
declared. The following patch should fix this.

From: "Mathieu" <matt@minas-morgul.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/net/zd1201.c |    1 +
 1 files changed, 1 insertion(+)

--- gregkh-2.6.orig/drivers/usb/net/zd1201.c	2005-07-29 11:29:47.000000000 -0700
+++ gregkh-2.6/drivers/usb/net/zd1201.c	2005-07-29 11:36:32.000000000 -0700
@@ -29,6 +29,7 @@
 	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 Wireless USB Adapter */
 	{USB_DEVICE(0x050d, 0x6051)}, /* Belkin F5D6051 usb  adapter */
 	{USB_DEVICE(0x0db0, 0x6823)}, /* MSI UB11B usb  adapter */
+	{USB_DEVICE(0x1044, 0x8005)}, /* GIGABYTE GN-WLBZ201 usb adapter */
 	{}
 };
 

--
