Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbTCWU6k>; Sun, 23 Mar 2003 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbTCWU6k>; Sun, 23 Mar 2003 15:58:40 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35856
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263210AbTCWU6i>; Sun, 23 Mar 2003 15:58:38 -0500
Date: Sun, 23 Mar 2003 13:07:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE todo list
In-Reply-To: <1048352492.9219.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10303231306490.8000-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Mar 2003, Alan Cox wrote:

> (Minus some stuff which is NDA'd because it involves unreleased chips
> etc)
> 
> -	Promise 20376
> -	Audit Promise drivers
> -	BIOS timing stuff
> -	Simplex mode reassignment intelligence
> -	IDE-SCSI crashes on 2.5
> -	IDE-SCSI/reset race on 2.4/2.5
> -	Forward port remaining drivers to 2.5
> -	Add ATAPI virtual DMA
> -	Add DMA active irq poll trick
> -	Clock switching for Highpoint 372N
> -	Support for SATA bridge on HPT
> -	Intel ICH5 errata audit
> -	Intel Centrino idents and errata audit		[Merged for 2.5]
> -	Explain rather than just fix the CMD680 mmio collision problem
> -	Finish hotplug handling
> -	Revert identify hacks now ide-default is present
> -	Allow multiple driver binding for ide-cd/ide-scsi etc
> -	Locking for unload driver
> -	Locking for modular load onto a busy interface
> -	ADMA full support
> -	Mark Lord/Andre ideas on LBA28/LBA48
> -	Finish verifying 256 sector I/O or larger on LBA48
> 	[How to handle change dynamically on hotplug ?]
> -	Clean up ide_unregister paths
> -	Finish ide pcmcia code hot unplug interface registers 
> -	Finish ide pcmcia unregister path retry logic
> -	IRQ detect broken for some setups
> -	Check full PCI clocking info on HPT37x
> -	Rewrite HPT37x controller type logic
> -	Debug TRM290
> -	Fix up the hwif based sectors per transfer limit
> -	How to handle generic class IDE devices by class only
> -	Opti support for the 558 ?
> -	Can we resolve NDA's with SiS ?
> -	Audit ALi driver use of config register bits on bridge
> -	Document the calling properties for each driver function
> -	Work out how to fix up all the TCQ crashes
> -	Does taskfile I/O now work after the bug fixes ?
> 		[do we care 8))]
> -	Multiple taskfile load support for controllers that have it
> 		[big performance win]
> -	IDE specification issue - mishandling error abort on ATA6
> -	20276 with i960 SX6000 mishandling
> -	Investigate breakage in ide-floppy on 2.4
> -	Merge new ACPI + relax into the -ac tree
> -	Get Arjan's info on IDE violations in simulator

Erm, where is this simulator?


Andre Hedrick
LAD Storage Consulting Group

