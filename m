Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWIZRpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWIZRpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWIZRpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:45:04 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:40650 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S932190AbWIZRpB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:45:01 -0400
Date: Tue, 26 Sep 2006 19:44:41 +0200
From: Arne Ahrend <aahrend@web.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-git4 crashes in sata_via
Message-Id: <20060926194441.527c83b6.aahrend@web.de>
In-Reply-To: <4518636C.8090802@garzik.org>
References: <20060925225205.a4e0a2d3.aahrend@web.de>
	<4518636C.8090802@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 19:17:00 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Does the attached patch fix your problems?

Yep, it works like a charm. Many thanks!

	Arne



libata version 2.00 loaded.
sata_via 0000:00:0f.0: version 2.0
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 10
ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB000 irq 17
ata2: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xB008 irq 17
scsi0 : sata_via
ata1: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC407
scsi1 : sata_via
ata2: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xB807
pata_via 0000:00:0f.1: version 0.1.13
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 1
ata3: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFC00 irq 14
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFC08 irq 15
scsi2 : pata_via
ata3.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 16
ata3.01: ATAPI, max UDMA/33
ata3.00: configured for UDMA/100
ata3.01: configured for UDMA/33
scsi3 : pata_via
ata4.00: ATAPI, max UDMA/33
ata4.01: ATAPI, max UDMA/33
ata4.00: configured for UDMA/33
ata4.01: configured for UDMA/33
