Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLCDV2>; Sat, 2 Dec 2000 22:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbQLCDVJ>; Sat, 2 Dec 2000 22:21:09 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:29961 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129429AbQLCDVA>; Sat, 2 Dec 2000 22:21:00 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14889.46322.183871.564776@wire.cadcamlab.org>
Date: Sat, 2 Dec 2000 20:50:26 -0600 (CST)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [uPATCH] duplicate pci ids
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch hunk got duplicated somewhere, it seems.

--- test12pre3/include/linux/pci_ids.h~	Sat Dec  2 19:23:51 2000
+++ test12pre3/include/linux/pci_ids.h	Sat Dec  2 20:45:53 2000
@@ -406,10 +406,6 @@
 #define PCI_DEVICE_ID_ELSA_MICROLINK	0x1000
 #define PCI_DEVICE_ID_ELSA_QS3000	0x3000
 
-#define PCI_VENDOR_ID_ELSA		0x1048
-#define PCI_DEVICE_ID_ELSA_MICROLINK	0x1000
-#define PCI_DEVICE_ID_ELSA_QS3000	0x3000
-
 #define PCI_VENDOR_ID_SGS		0x104a
 #define PCI_DEVICE_ID_SGS_2000		0x0008
 #define PCI_DEVICE_ID_SGS_1764		0x0009
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
