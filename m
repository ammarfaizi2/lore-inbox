Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUCDNmc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCDNlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:41:12 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:13518 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261898AbUCDNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:56 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add missing "GPL"
Date: Thu, 4 Mar 2004 08:44:32 +0100
User-Agent: KMail/1.6
References: <200403040838.31412.eike-kernel@sf-tec.de> <200403040840.13086.eike-kernel@sf-tec.de>
In-Reply-To: <200403040840.13086.eike-kernel@sf-tec.de>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403040844.32687.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this safe_serial taints the kernel, but it is GPL.

Eike

diff -aur linux-2.6.3/drivers/usb/serial/safe_serial.c linux-2.6.3-eike/drivers/usb/serial/safe_serial.c
--- linux-2.6.3/drivers/usb/serial/safe_serial.c	2004-02-18 04:57:20.000000000 +0100
+++ linux-2.6.3-eike/drivers/usb/serial/safe_serial.c	2004-03-02 09:23:11.000000000 +0100
@@ -93,6 +93,7 @@
 
 MODULE_AUTHOR (DRIVER_AUTHOR);
 MODULE_DESCRIPTION (DRIVER_DESC);
+MODULE_LICENSE("GPL");
 
 #if defined(CONFIG_USBD_SAFE_SERIAL_VENDOR) && !defined(CONFIG_USBD_SAFE_SERIAL_PRODUCT)
 #abort "SAFE_SERIAL_VENDOR defined without SAFE_SERIAL_PRODUCT"
