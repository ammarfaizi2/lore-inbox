Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbUJZTcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUJZTcP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbUJZTcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:32:15 -0400
Received: from mail.dif.dk ([193.138.115.101]:49064 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261540AbUJZTcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:32:07 -0400
Date: Tue, 26 Oct 2004 21:40:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][Doc][Trivial] Small fixups to the EHCI Kconfig help text
Message-ID: <Pine.LNX.4.61.0410262137060.3277@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a small patch with a few tiny fixups for the EHCI Kconfig help 
text. Please consider applying.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc1-bk5-orig/drivers/usb/host/Kconfig linux-2.6.10-rc1-bk5/drivers/usb/host/Kconfig
--- linux-2.6.10-rc1-bk5-orig/drivers/usb/host/Kconfig	2004-10-26 20:02:04.000000000 +0200
+++ linux-2.6.10-rc1-bk5/drivers/usb/host/Kconfig	2004-10-26 21:27:00.000000000 +0200
@@ -29,14 +29,14 @@
 	  The Enhanced Host Controller Interface (EHCI) is standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host controller hardware.
 	  If your USB host controller supports USB 2.0, you will likely want to
-	  configure this Host Controller Driver.  At this writing, the primary
-	  implementation of EHCI is a chip from NEC, widely available in add-on
-	  PCI cards, but implementations are in the works from other vendors
-	  including Intel and Philips.  Motherboard support is appearing.
+	  configure this Host Controller Driver.  At the time of this writing, 
+	  the primary implementation of EHCI is a chip from NEC, widely available
+	  in add-on PCI cards, but implementations are in the works from other 
+	  vendors including Intel and Philips.  Motherboard support is appearing.
 
 	  EHCI controllers are packaged with "companion" host controllers (OHCI
 	  or UHCI) to handle USB 1.1 devices connected to root hub ports.  Ports
-	  will connect to EHCI if it the device is high speed, otherwise they
+	  will connect to EHCI if the device is high speed, otherwise they
 	  connect to a companion controller.  If you configure EHCI, you should
 	  probably configure the OHCI (for NEC and some other vendors) USB Host
 	  Controller Driver or UHCI (for Via motherboards) Host Controller


