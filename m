Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWGNHAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWGNHAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 03:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWGNHAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 03:00:24 -0400
Received: from tornado.reub.net ([202.89.145.182]:48775 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030338AbWGNHAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 03:00:24 -0400
Message-ID: <44B74109.6040205@reub.net>
Date: Fri, 14 Jul 2006 19:00:25 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060713)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc1-mm2
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2006 5:48 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/
> 
> - Patches were merged, added, dropped and fixed.  Nothing particularly exciting.
> 
> - Added the avr32 architecture.  Review is sought, please.

Still seeing problems with this ATA CD-RW device (same one as I had problems 
with in -mm1).

Alan - is there anything else I can do to help with this one or is it just a 
case of it being a "Work in progress" ?


ata4: SATA link down (SStatus 0 SControl 300)
   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST380817AS        Rev: 3.42
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: ST3300622AS       Rev: 3.AA
   Type:   Direct-Access                      ANSI SCSI revision: 05
ata_piix 0000:00:1f.1: version 2.00ac6
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
scsi4 : ata_piix
ata5.00: ATAPI, max UDMA/66
ata5.00: configured for UDMA/66
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
Losing some ticks... checking if CPU frequency changed.
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/66
ata5: EH complete
ata5.00: limiting speed to UDMA/44
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: (BMDMA stat 0x24)
ata5.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata5: soft resetting port
ata5.00: configured for UDMA/44
ata5: EH complete
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30B8 irq 15
scsi5 : ata_piix
ata6: port disabled. ignoring.
ATA: abnormal status 0xFF on port 0x177
SCSI device sda: 586072368 512-byte hdwr sectors (300069 MB)

Thanks,
Reuben
