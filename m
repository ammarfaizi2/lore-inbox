Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288657AbSAQND0>; Thu, 17 Jan 2002 08:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSAQNDM>; Thu, 17 Jan 2002 08:03:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22694 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288657AbSAQNDD>;
	Thu, 17 Jan 2002 08:03:03 -0500
Date: Thu, 17 Jan 2002 04:42:30 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jeremy Freeman <jfreeman@sporg.com>
cc: linux-kernel@vger.kernel.org
Subject: XP PCI Contamination, GURR (Re: Care?)
In-Reply-To: <000501c1877f$87248b40$10105318@jeremy.bc.ca>
Message-ID: <Pine.LNX.4.10.10201170438020.30663-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears the folks up in redmond have succeeded in having the BIOS
people default disable PCI resources.  Since XP will reject, or assume a
device is in use should the BAR's be allocated, the various archs may need
to have a broader setup table or a more generic ruleset.

Any thoughts on how best to address good hardare, which the BIOS does not
setup per redmond-rules.


On Mon, 17 Dec 2001, Jeremy Freeman wrote:

> Not sure if you care about this or not.. Probably seen it from someone else
> already.. Dual Athlon 1800+ MPs on a Tyain Thunder K7 BIOS 2.09.
> 
> 2.4.16 kernel.
> 
> <snip>
> AMD7411: IDE controller on PCI bus 00 dev 39
> PCI: Device 00:07.1 not available because of resource collisions
> AMD7411: chipset revision 1
> AMD7411: not 100% native mode: will probe irqs later
> AMD7411: IO baseregs (BIOS) are reported as MEM, report to
> <andre@linux-ide.org>.
> AMD7411: simplex device:  DMA disabled
> ide1: AMD7411 Bus-Master DMA disabled (BIOS)
> hda: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ATAPI 48X CD-ROM drive, 128kB Cache
> <snip>
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

