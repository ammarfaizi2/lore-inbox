Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbTGUMDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbTGUMDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:03:20 -0400
Received: from c-cca870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.204]:5760
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S269935AbTGUMDT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:03:19 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Compile AX8817x driver
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 21 Jul 2003 14:18:10 +0200
Message-ID: <yw1xsmp0f4zh.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This trivial Makefile patch causes the AX8817x driver to actually be
built.  The diff is against 2.6.0-test1.

Index: drivers/usb/Makefile
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/usb/Makefile,v
retrieving revision 1.37
diff -u -r1.37 Makefile
--- drivers/usb/Makefile	3 Jun 2003 01:28:55 -0000	1.37
+++ drivers/usb/Makefile	21 Jul 2003 10:53:22 -0000
@@ -35,6 +35,7 @@
 obj-$(CONFIG_USB_STV680)	+= media/
 obj-$(CONFIG_USB_VICAM)		+= media/
 
+obj-$(CONFIG_USB_AX8817X)       += net/
 obj-$(CONFIG_USB_CATC)		+= net/
 obj-$(CONFIG_USB_KAWETH)	+= net/
 obj-$(CONFIG_USB_PEGASUS)	+= net/


-- 
Måns Rullgård
mru@users.sf.net
