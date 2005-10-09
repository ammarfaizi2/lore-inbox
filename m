Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVJIPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVJIPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVJIPW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 11:22:26 -0400
Received: from havoc.gtf.org ([69.61.125.42]:15280 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750816AbVJIPWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 11:22:25 -0400
Date: Sun, 9 Oct 2005 11:22:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: libata queue updated
Message-ID: <20051009152221.GA3034@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below is the contents of the current 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

All this will be pushed upstream as soon as 2.6.14 is released.

The SATA status pages should also reflects the latest changes,
	http://linux.yyz.us/sata/


Alan Cox:
  ata: re-order speeds sensibly.
  libata: bitmask based pci init functions for one or two ports

Albert Lee:
  [libata] C/H/S support, for older devices
  libata: indent and whitespace change
  libata: rename host states
  libata: minor whitespace, comment, debug message updates
  [libata scsi] tidy up SCSI lba and xfer len calculations
  [libata scsi] add CHS support to ata_scsi_start_stop_xlat()

Andy Currid:
  Fix sata_nv handling of NVIDIA MCP51/55

Brett Russ:
  libata: Marvell SATA support (DMA mode) (resend: v0.22)
  libata: Marvell spinlock fixes and simplification
  libata: Marvell function headers

Douglas Gilbert:
  [libata scsi] add ata_scsi_set_sense helper
  [libata scsi] improve scsi error handling with ata_scsi_set_sense()

Jeff Garzik:
  libata: move EH docs to separate DocBook chapter
  [libata] improve device scan
  [libata] improve device scan even more
  libata: add ata_ratelimit(), use it in AHCI driver irq handler
  libata: ATAPI command completion tweaks and notes
  libata: move atapi_request_sense() to libata-scsi module
  [libata sata_mv] fix warning
  libata: minor cleanups

Tejun Heo:
  SATA: rewritten sil24 driver
  sil24: add FIXME comment above ata_device_add
  sil24: remove irq disable code on spurious interrupt
  sil24: add testing for PCI fault
  sil24: move error handling out of hot interrupt path
  sil24: remove PORT_TF
  sil24: replace pp->port w/ ap->ioaddr.cmd_addr
  sil24: fix PORT_CTRL_STAT constants
  sil24: add more comments for constants
  sil24: initialization fix
  libata EH document update
  libata: add ATA exceptions chapter to doc
  sil24: ignore non-error exception irqs
  sil24: remove CMDERR clearing
  sil24: implement proper TF register reading & caching
  sil24: implement tf_read callback
  [libata sata_sil24] nit pickings
  [libata sata_sil24] add support for 3131/3531

