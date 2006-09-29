Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161653AbWI2RCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161653AbWI2RCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161651AbWI2RCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:02:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44249 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161649AbWI2RCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:02:23 -0400
Subject: [PATCH] libata: pata_pcmcia new PCMCIA identifiers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 29 Sep 2006 18:25:27 +0100
Message-Id: <1159550727.13029.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/ata/pata_pcmcia.c linux-2.6.18-mm2/drivers/ata/pata_pcmcia.c
--- linux.vanilla-2.6.18-mm2/drivers/ata/pata_pcmcia.c	2006-09-28 14:33:46.000000000 +0100
+++ linux-2.6.18-mm2/drivers/ata/pata_pcmcia.c	2006-09-28 15:24:37.000000000 +0100
@@ -42,7 +42,7 @@
 
 
 #define DRV_NAME "pata_pcmcia"
-#define DRV_VERSION "0.2.9"
+#define DRV_VERSION "0.2.11"
 
 /*
  *	Private data structure to glue stuff together
@@ -355,6 +355,8 @@
 	PCMCIA_DEVICE_PROD_ID12("SAMSUNG", "04/05/06", 0x43d74cb4, 0x6a22777d),
 	PCMCIA_DEVICE_PROD_ID12("SMI VENDOR", "SMI PRODUCT", 0x30896c92, 0x703cc5f6),
 	PCMCIA_DEVICE_PROD_ID12("TOSHIBA", "MK2001MPL", 0xb4585a1a, 0x3489e003),
+	PCMCIA_DEVICE_PROD_ID1("TRANSCEND    512M   ", 0xd0909443),
+	PCMCIA_DEVICE_PROD_ID12("TRANSCEND", "TS4GCF120", 0x709b1bf1, 0xf54a91c8),
 	PCMCIA_DEVICE_PROD_ID12("WIT", "IDE16", 0x244e5994, 0x3e232852),
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),

