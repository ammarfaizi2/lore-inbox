Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVEXJZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVEXJZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVEXJWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:22:47 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:17092 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261901AbVEXJSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:18:51 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091849.EC2FDFA5B@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:18:49 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 7239DFB6B

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:39 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261307AbVEXFmF (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 01:42:05 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXFmF

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 01:42:05 -0400

Received: from mail.dvmed.net ([216.237.124.58]:52684 "EHLO mail.dvmed.net")

	by vger.kernel.org with ESMTP id S261307AbVEXFYi (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 01:24:38 -0400

Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])

	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))

	id 1DaRu9-0001N8-A4; Tue, 24 May 2005 05:24:37 +0000

Message-ID: <4292BA93.801@pobox.com>

Date:	Tue, 24 May 2005 01:24:35 -0400

From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5

X-Accept-Language: en-us, en

MIME-Version: 1.0

To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x libata new PCI ids

Content-Type: multipart/mixed;

 boundary="------------020908040206020909070108"

X-Spam-Score: 0.0 (/)

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



This is a multi-part message in MIME format.
--------------020908040206020909070108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please pull the 'new-ids' branch from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

This add new PCI ids to some SATA drivers.

diffstat, changelog, and patch attached.



--------------020908040206020909070108
Content-Type: text/plain;
 name="libata-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.txt"


 drivers/scsi/sata_promise.c |    2 ++
 drivers/scsi/sata_sil.c     |    1 +
 2 files changed, 3 insertions(+)


commit 37c15447c565ab458ee3778e198d08f4041caa99
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
author Martin Povolny <martin.povolny@solnet.cz> Mon, 16 May 2005 02:41:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:41:00 -0400

[PATCH] sata_promise: new PCI ID for TX4200

[note - blank changeset]

--------------------------
commit 9422e59ddf6cae68e46d7a2c3afe1ce4e739d3eb
tree 2eda289903e3bf19eebce7d5f9aaed2240a02479
parent eeff84cc026e73d12fbe4484b5fa0d01efa8dc60
author Francisco Javier <ffelix@sshinf.com> Mon, 16 May 2005 02:39:00 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:39:00 -0400

[PATCH] sata_promise: add PCI ID for FastTrak TX2200 2-ports

--------------------------
commit eeff84cc026e73d12fbe4484b5fa0d01efa8dc60
tree 136a26c73b90d0dd1c4088bb9a65409b5a2d806d
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author NAKAMURA Kenta <kenta@c.csce.kyushu-u.ac.jp> Mon, 16 May 2005 02:35:41 -0400
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 02:35:41 -0400

[PATCH] sata_sil: new ID 1002:437A for ATI IXP400

--------------------------
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -151,6 +151,8 @@ static struct ata_port_info pdc_port_inf
 static struct pci_device_id pdc_ata_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, 0x3371, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
+	{ PCI_VENDOR_ID_PROMISE, 0x3571, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3373, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_2037x },
 	{ PCI_VENDOR_ID_PROMISE, 0x3375, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -82,6 +82,7 @@ static struct pci_device_id sil_pci_tbl[
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 

--------------020908040206020909070108--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

