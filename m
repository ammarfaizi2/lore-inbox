Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUBXEYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 23:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUBXEYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 23:24:35 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:50836 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262153AbUBXEYb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 23:24:31 -0500
Subject: [BK PATCH] SCSI update for 2.6.3
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 Feb 2004 22:24:27 -0600
Message-Id: <1077596668.1983.282.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current crop of accumulated patches are mainly driver updates and
bug fixes.

It is available at

bk://linux-scsi.bkbits.net/scsi-for-linus

The short changelog is:

<brking:us.ibm.com>:
  o SCSI: Make retries obey host_self_blocked flag

Andrew Vasquez:
  o qla2xxx -- FCP_RSP IU check during command completion
  o qla2xxx -- Properly schedule mailbox command timeouts

Christoph Hellwig:
  o move remaining definitions from drivers/scsi/scsi.h to include/scsi
  o fix up NCR5380 private data
  o fix up ini9100 interrupt handling
  o Remove CONFIG_SCSI_DC390T_NOGENSUPP
  o remove flush_cache_all() from qla1280

David S. Miller:
  o qla2xxx: remove flush_cache_all

Geert Uytterhoeven:
  o Sun-3x ESP SCSI clean up
  o NCR53C9x slave_{alloc,destroy}()

James Bottomley:
  o SCSI: 53c700: reduce default tag depth to 4
  o MPT Fusion driver 3.00.03 update

Kai Mäkisara:
  o Sysfs class support for SCSI tapes

Mark Haverkamp:
  o aacraid reset handler
  o add card types to aacraid driver

Patrick Mansfield:
  o have CONFIG_SCSI_PROC_FS depend on CONFIG_PROC_FS

James


