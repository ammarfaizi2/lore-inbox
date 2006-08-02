Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWHBVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWHBVJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWHBVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:09:13 -0400
Received: from v813.rev.tld.pl ([195.149.226.213]:30181 "EHLO
	smtp.host4.kei.pl") by vger.kernel.org with ESMTP id S932142AbWHBVJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:09:12 -0400
X-clamdmail: clamdmail 0.18a
From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
To: linux-pcmcia@lists.infradead.org
Subject: [PATCH] PCMCIA: Add few IDs into ide-cs
Date: Wed, 2 Aug 2006 23:10:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200608022310.03388.openembedded@hrw.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Juszkiewicz <openembedded@hrw.one.pl>

Few cards informations submitted by OpenZaurus users.

Seagate 8GB microdrive:
 product info: "SEAGATE", "ST1"
 manfid 0x0111, 0x0000

One CF card:
 product info: "SAMSUNG", "04/05/06", "", ""
 manfid : 0x0000, 0x0000

Ridata 8GB Pro 150X Compact Flash Card:
 product info: "SMI VENDOR", "SMI PRODUCT", ""
 manfid: 0x000a, 0x0000

 product info: "M-Systems", "CF500", ""
 manfid: 0x000a, 0x0000

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>

---
Patch follow kernel version 2.6.17

Please Cc: me - I'm not subscribed to linux-pcmcia or linux-kernel

 ide-cs.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux/drivers/ide/legacy/ide-cs.c
===================================================================
--- linux.orig/drivers/ide/legacy/ide-cs.c	2006-07-10 23:25:59.479162976 +0200
+++ linux/drivers/ide/legacy/ide-cs.c	2006-08-02 23:02:22.997684384 +0200
@@ -398,10 +398,14 @@
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDE", 0x547e66dc, 0x5c5ab149),
 	PCMCIA_DEVICE_PROD_ID12("IO DATA", "PCIDEII", 0x547e66dc, 0xb3662674),
 	PCMCIA_DEVICE_PROD_ID12("LOOKMEET", "CBIDE2      ", 0xe37be2b5, 0x8671043b),
+	PCMCIA_DEVICE_PROD_ID12("M-Systems", "CF500", 0x7ed2ad87, 0x7a13045c),
 	PCMCIA_DEVICE_PROD_ID2("NinjaATA-", 0xebe0bd79),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "CD-ROM", 0x281f1c5d, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("PCMCIA", "PnPIDE", 0x281f1c5d, 0x0c694728),
 	PCMCIA_DEVICE_PROD_ID12("SHUTTLE TECHNOLOGY LTD.", "PCCARD-IDE/ATAPI Adapter", 0x4a3f0ba0, 0x322560e1),
+	PCMCIA_DEVICE_PROD_ID12("SEAGATE", "ST1", 0x87c1b330, 0xe1f30883),
+	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "04/05/06", 0x43d74cb4, 0x6a22777d),
+	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
 	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),


-- 
JID: hrw-jabber.org
Palmtop: Sharp Zaurus C760
OpenEmbedded/OpenZaurus developer

                 change your mind. it's starting to smell.
