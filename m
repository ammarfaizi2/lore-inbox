Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEYXf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEYXf3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVEYXf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:35:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:55510 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261609AbVEYXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:35:12 -0400
Message-ID: <42950BAC.5010406@pobox.com>
Date: Wed, 25 May 2005 19:35:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches try2] 2.6.x libata new PCI ids
Content-Type: multipart/mixed;
 boundary="------------020203080507060906090703"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020203080507060906090703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


That ghost changeset should be gone now.

Please pull branch 'new-ids' of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

diffstat/changelog/patch attached.


--------------020203080507060906090703
Content-Type: text/plain;
 name="libata-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-2.6.txt"

 drivers/scsi/sata_promise.c |    2 ++
 drivers/scsi/sata_sil.c     |    1 +
 2 files changed, 3 insertions(+)


commit 4c3a53d4108367f639e5e0fe9366dfd7679c5514
tree 0dcafa1f300870aecff4ac45bda16879aa89e61d
parent 525a099771d348a25d12ef9c47aa8680c7317e35
author Francisco Javier <ffelix@sshinf.com> Thu, 26 May 2005 03:29:37 -0400
committer Jeff Garzik <jgarzik@pobox.com> Thu, 26 May 2005 03:29:37 -0400

[PATCH] sata_promise: add PCI ID for FastTrak TX2200 2-ports

--------------------------
commit 525a099771d348a25d12ef9c47aa8680c7317e35
tree 86fe91606c8994f6358c8afeb1c3b9f0f4784bd7
parent 2a24ab628aa7b190be32f63dfb6d96f3fb61580a
author NAKAMURA Kenta <kenta@c.csce.kyushu-u.ac.jp> Thu, 26 May 2005 03:28:38 -0400
committer Jeff Garzik <jgarzik@pobox.com> Thu, 26 May 2005 03:28:38 -0400

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
 

--------------020203080507060906090703--
