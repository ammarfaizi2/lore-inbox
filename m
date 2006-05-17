Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWEQCIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWEQCIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWEQCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 22:08:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30363 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750811AbWEQCIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 22:08:43 -0400
Date: Tue, 16 May 2006 19:05:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Message-Id: <20060516190507.35c1260f.akpm@osdl.org>
In-Reply-To: <20060515170006.GA29555@havoc.gtf.org>
References: <20060515170006.GA29555@havoc.gtf.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> wrote:
>
>  	git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

This adds a minute and a half to my bootup times :(


[   43.275044] SCSI subsystem initialized
[   43.335092] libata version 1.30 loaded.
[   43.336142] ata_piix 0000:00:1f.2: version 1.10
[   43.336146] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[   43.426691] ACPI (acpi_bus-0191): Device is not power manageable [20060310]
[   43.559872] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 19
[   43.681530] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   43.681564] ata1: SATA max UDMA/133 cmd 0x2148 ctl 0x217E bmdma 0x2110 irq 19
[   43.777123] ata2: SATA max UDMA/133 cmd 0x2140 ctl 0x217A bmdma 0x2118 irq 19
[   44.123919] ata1.00: cfg 49:2f00 82:346b 83:7fe9 84:4773 85:3469 86:3c01 87:4763 88:407f
[   44.123924] ata1.00: ATA-7, max UDMA/133, 321672960 sectors: LBA48 NCQ (depth 0/32)
[   44.216325] ata1.00: configured for UDMA/133
[   44.267296] scsi0 : ata_piix
[   44.301660] PM: Adding info for No Bus:host0
[   44.719422] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
[   44.719425] ata2.00: ATAPI, max UDMA/66
[   44.765263] ata2.00: applying bridge limits
[   74.928836] ata2.01: qc timeout (cmd 0xa1)
[   74.977811] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[   75.468853] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
[   75.468856] ata2.00: ATAPI, max UDMA/66
[   75.514678] ata2.00: applying bridge limits
[  105.674130] ata2.01: qc timeout (cmd 0xa1)
[  105.723044] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[  106.210113] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
[  106.210117] ata2.00: ATAPI, max UDMA/66
[  106.255906] ata2.00: applying bridge limits
[  136.415532] ata2.01: qc timeout (cmd 0xa1)
[  136.464452] ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[  136.537214] ata2.01: limiting speed to PIO0
[  136.587141] ata2.01: disabled
[  137.039723] ata2.00: cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:101f
[  137.039726] ata2.00: ATAPI, max UDMA/66
[  137.085492] ata2.00: applying bridge limits
[  137.292543] ata2.00: configured for UDMA/66
[  137.342488] scsi1 : ata_piix
[  137.376847] PM: Adding info for No Bus:host1
[  137.376892] PM: Adding info for No Bus:target0:0:0
[  137.376948]   Vendor: ATA       Model: HDT722516DLA380   Rev: V43O
[  137.453962]   Type:   Direct-Access                      ANSI SCSI revision: 05
[  137.541468] PM: Adding info for scsi:0:0:0:0
[  137.541547] SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
[  137.621598] sda: Write Protect is off
[  137.665289] sda: Mode Sense: 00 3a 00 00
[  137.665306] SCSI device sda: drive cache: write back
[  137.724592] SCSI device sda: 321672960 512-byte hdwr sectors (164697 MB)
[  137.804697] sda: Write Protect is off
[  137.848386] sda: Mode Sense: 00 3a 00 00
[  137.848398] SCSI device sda: drive cache: write back
[  137.907659]  sda: sda1 sda2 sda3
[  137.957184] sd 0:0:0:0: Attached scsi disk sda
[  138.010252] PM: Adding info for No Bus:target1:0:0
[  138.010869]   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.09
[  138.087949]   Type:   CD-ROM                             ANSI SCSI revision: 05
[  138.175466] PM: Adding info for scsi:1:0:0:0
[  138.175531] ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]
[  138.237446] ACPI (acpi_bus-0191): Device is not power manageable [20060310]
[  138.320799] ACPI: PCI Interrupt 0000:00:1f.5[A] -> GSI 19 (level, low) -> IRQ 19
[  138.409254] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[  138.409276] ata3: SATA max UDMA/133 cmd 0x2138 ctl 0x2176 bmdma 0x20F0 irq 19
[  138.494586] ata4: SATA max UDMA/133 cmd 0x2130 ctl 0x2172 bmdma 0x20F8 irq 19
[  139.899612] scsi2 : ata_piix
[  139.933979] PM: Adding info for No Bus:host2
[  141.251424] scsi3 : ata_piix
[  141.285781] PM: Adding info for No Bus:host3
[  141.366280] EXT3-fs: INFO: recovery required on readonly filesystem.

