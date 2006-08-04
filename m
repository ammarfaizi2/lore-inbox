Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWHDI3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWHDI3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWHDI3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:29:40 -0400
Received: from mx2.go2.pl ([193.17.41.42]:26309 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1161102AbWHDI3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:29:39 -0400
Date: Fri, 4 Aug 2006 10:31:58 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: ATA: abnormal status 0x7F on port 0x142F /2.6.18-rc3
Message-ID: <20060804083157.GA2756@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There is no such message in eg. 2.6.17.7 with similar config.
Some more about the box in my yesterday message with subject:
[ BUG: bad unlock balance detected! ]

Jarek P.

from dmesg:
...
SCSI subsystem initialized
libata version 2.00 loaded.
sata_via 0000:00:0f.0: version 2.0
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 9
sata_via 0000:00:0f.0: enabling SATA channels (0x32)
ata1: SATA max UDMA/133 cmd 0x1430 ctl 0x1426 bmdma 0x1400 irq 17
ata2: SATA max UDMA/133 cmd 0x1428 ctl 0x1422 bmdma 0x1408 irq 17
scsi0 : sata_via
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
input: AT Translated Set 2 keyboard as /class/input/input0
ata1.00: ATA-7, max UDMA/100, 78140160 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0x142F
  Vendor: ATA       Model: FUJITSU MHV2040B  Rev: 0000
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 >
sd 0:0:0:0: Attached scsi disk sda
...
