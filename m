Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262775AbTCVPiW>; Sat, 22 Mar 2003 10:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262785AbTCVPiV>; Sat, 22 Mar 2003 10:38:21 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36506
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262775AbTCVPiU>; Sat, 22 Mar 2003 10:38:20 -0500
Subject: IDE todo list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 17:01:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Minus some stuff which is NDA'd because it involves unreleased chips
etc)

-	Promise 20376
-	Audit Promise drivers
-	BIOS timing stuff
-	Simplex mode reassignment intelligence
-	IDE-SCSI crashes on 2.5
-	IDE-SCSI/reset race on 2.4/2.5
-	Forward port remaining drivers to 2.5
-	Add ATAPI virtual DMA
-	Add DMA active irq poll trick
-	Clock switching for Highpoint 372N
-	Support for SATA bridge on HPT
-	Intel ICH5 errata audit
-	Intel Centrino idents and errata audit		[Merged for 2.5]
-	Explain rather than just fix the CMD680 mmio collision problem
-	Finish hotplug handling
-	Revert identify hacks now ide-default is present
-	Allow multiple driver binding for ide-cd/ide-scsi etc
-	Locking for unload driver
-	Locking for modular load onto a busy interface
-	ADMA full support
-	Mark Lord/Andre ideas on LBA28/LBA48
-	Finish verifying 256 sector I/O or larger on LBA48
	[How to handle change dynamically on hotplug ?]
-	Clean up ide_unregister paths
-	Finish ide pcmcia code hot unplug interface registers 
-	Finish ide pcmcia unregister path retry logic
-	IRQ detect broken for some setups
-	Check full PCI clocking info on HPT37x
-	Rewrite HPT37x controller type logic
-	Debug TRM290
-	Fix up the hwif based sectors per transfer limit
-	How to handle generic class IDE devices by class only
-	Opti support for the 558 ?
-	Can we resolve NDA's with SiS ?
-	Audit ALi driver use of config register bits on bridge
-	Document the calling properties for each driver function
-	Work out how to fix up all the TCQ crashes
-	Does taskfile I/O now work after the bug fixes ?
		[do we care 8))]
-	Multiple taskfile load support for controllers that have it
		[big performance win]
-	IDE specification issue - mishandling error abort on ATA6
-	20276 with i960 SX6000 mishandling
-	Investigate breakage in ide-floppy on 2.4
-	Merge new ACPI + relax into the -ac tree
-	Get Arjan's info on IDE violations in simulator




-- 
Alan Cox <alan@lxorguk.ukuu.org.uk>
