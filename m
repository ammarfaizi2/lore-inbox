Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKXVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTKXVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:39:59 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:38308 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S261733AbTKXVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:39:57 -0500
Message-ID: <34020.209.251.159.140.1069710815.squirrel@mail.mainstreetsoftworks.com>
Date: Mon, 24 Nov 2003 16:53:35 -0500 (EST)
Subject: [PATCH 2.6.0-test10] libata sata_promise pci id pdc20376
From: "Brad House" <brad_mssw@gentoo.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
Cc: <jgarzik@pobox.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason I thought the pdc20376 PCI ID was already
added, but none of the ones that existed worked for this
user, but this addition did:

(the patch can also be found at
http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-0.6/225_sata_promise_pdc20376_pciid.patch
if it doesn't inline correctly)

Please CC me on any replies
-Brad House
brad_mssw@gentoo.org

Patch:

diff -urN linux-2.6.0-test10-gentoo-r1.orig/drivers/scsi/sata_promise.c
linux-2.6.0-test10-gentoo-r1/drivers/scsi/sata_promise.c
---
linux-2.6.0-test10-gentoo-r1.orig/drivers/scsi/sata_promise.c	2003-11-24
14:23:41.687209888 -0500
+++ linux-2.6.0-test10-gentoo-r1/drivers/scsi/sata_promise.c	2003-11-24
14:16:15.000000000 -0500
@@ -213,6 +213,8 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3376, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,



