Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270590AbTGNMdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270591AbTGNMbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:31:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47492
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270590AbTGNMMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:12:42 -0400
Date: Mon, 14 Jul 2003 13:26:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141226.h6ECQfFB030935@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: PATCH: add intellinet to the usb idents
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/drivers/usb/ax8817x.c linux.22-pre5-ac1/drivers/usb/ax8817x.c
--- linux.22-pre5/drivers/usb/ax8817x.c	2003-07-14 12:27:39.000000000 +0100
+++ linux.22-pre5-ac1/drivers/usb/ax8817x.c	2003-07-07 16:14:39.000000000 +0100
@@ -10,6 +10,8 @@
  *
  * History 
  *
+ *	2003-06-28 - Dave Hollis <dhollis@davehollis.com>  1.0.2
+ *		* Added support for Intellinet
  *	2003-06-12 - Dave Hollis <dhollis@davehollis.com>  1.0.1
  *		* use usb_make_path for ethtool info
  *		* Use crc32.h for crc functions
@@ -174,6 +176,8 @@
       {USB_DEVICE(0x0846, 0x1040), driver_info:0x00130103},
 	/* D-Link DUB-E100 */
       {USB_DEVICE(0x2001, 0x1a00), driver_info:0x009f9d9f},
+	/* Intellinet USB Ethernet*/
+      {USB_DEVICE(0x0b95, 0x1720), driver_info:0x00130103},
 
 	{}
 };
