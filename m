Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVGQDjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVGQDjB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 23:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGQDjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 23:39:01 -0400
Received: from sybil.roundthebend.com ([65.98.18.22]:8603 "EHLO
	sybil.roundthebend.com") by vger.kernel.org with ESMTP
	id S261841AbVGQDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 23:37:41 -0400
Subject: [PATCH 2.6.12.3] libata: add support for Promise SATA 300 TX2plus
	PDC40775
From: Ed Kear <ed@kear.net>
Reply-To: ed@kear.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 16 Jul 2005 23:32:19 -0400
Message-Id: <1121571139.20986.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using this card in a RAID1 with 2 new SATA drives with no problems.

Card - SATA 300 TX2plus  PDC40775 (3d73)

Signed-off-by: Ed Kear <ed@kear.net>

diff -urN a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c   2005-07-15 17:18:57.000000000 -0400
+++ b/drivers/scsi/sata_promise.c   2005-07-16 10:03:56.316189832 -0400
@@ -164,6 +164,8 @@
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d75, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d73, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 
 	{ PCI_VENDOR_ID_PROMISE, 0x3318, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },


