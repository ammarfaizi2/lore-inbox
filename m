Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUKOGn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUKOGn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbUKOGny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:43:54 -0500
Received: from havoc.gtf.org ([69.28.190.101]:39897 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261517AbUKOGns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:43:48 -0500
Date: Mon, 15 Nov 2004 01:43:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [SATA] libata-dev-2.6 queue updated
Message-ID: <20041115064346.GA14449@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-rc2-libata1-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |    8 
 drivers/scsi/Makefile        |    1 
 drivers/scsi/libata-core.c   |   38 ++
 drivers/scsi/libata-scsi.c   |  409 +++++++++++++++++++++++++
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_pdc2027x.c |  694 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   56 +++
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    2 
 include/scsi/scsi.h          |    3 
 10 files changed, 1203 insertions(+), 11 deletions(-)

through these ChangeSets:

<albertcc:tw.ibm.com>:
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Jeff Garzik:
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

Tobias Lorenz:
  o libata-scsi: get-identity ioctl support

