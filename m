Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbUJ0G4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbUJ0G4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUJ0Gx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:53:59 -0400
Received: from havoc.gtf.org ([69.28.190.101]:22747 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262306AbUJ0GwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:52:10 -0400
Date: Wed, 27 Oct 2004 02:52:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [SATA] libata-dev queue updated
Message-ID: <20041027065208.GA16230@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing new, just updating for recent kernels.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-rc1-bk5-libata1-dev1.patch.bz2

The libata-dev-2.6 patch requires the libata-2.6 patch, which is
available at:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.10-rc1-bk5-libata1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |    8 
 drivers/scsi/Makefile        |    1 
 drivers/scsi/libata-core.c   |   38 +-
 drivers/scsi/libata-scsi.c   |  395 +++++++++++++++++++++-
 drivers/scsi/libata.h        |    2 
 drivers/scsi/pata_pdc2027x.c |  758 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_promise.c  |   56 +++
 include/linux/ata.h          |    1 
 include/linux/libata.h       |    2 
 include/scsi/scsi.h          |    3 
 10 files changed, 1249 insertions(+), 15 deletions(-)

through these ChangeSets:

<albertcc:tw.ibm.com>:
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
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] use kunmap_atomic() correctly
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

