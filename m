Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULBQFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULBQFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULBQFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:05:20 -0500
Received: from sarvega.com ([161.58.151.164]:27917 "EHLO sarvega.com")
	by vger.kernel.org with ESMTP id S261663AbULBQDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:03:09 -0500
Date: Thu, 2 Dec 2004 10:03:04 -0600
From: John Lash <jkl@sarvega.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] sata_sil.c: blacklist seagate ST380013AS
Message-ID: <20041202100304.4e8a9145@homer.sarvega.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs102 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

here's a patch to add seagate ST380013AS to the sata_sil.c blacklist. and a
pointer to the relevant thread on lkml.

http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0120.html

--john

--- linux-2.6.10-rc2-bk13.orig/drivers/scsi/sata_sil.c  2004-12-01
22:39:34.000000000 -0600+++ linux-2.6.10-rc2-bk13/drivers/scsi/sata_sil.c      
2004-12-01 10:22:59.000000000 -0600@@ -84,6 +84,7 @@ struct sil_drivelist {
        { "ST330013AS",         SIL_QUIRK_MOD15WRITE },
        { "ST340017AS",         SIL_QUIRK_MOD15WRITE },
        { "ST360015AS",         SIL_QUIRK_MOD15WRITE },
+       { "ST380013AS",         SIL_QUIRK_MOD15WRITE },
        { "ST380023AS",         SIL_QUIRK_MOD15WRITE },
        { "ST3120023AS",        SIL_QUIRK_MOD15WRITE },
        { "ST3160023AS",        SIL_QUIRK_MOD15WRITE },
