Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRDKFqx>; Wed, 11 Apr 2001 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131289AbRDKFqn>; Wed, 11 Apr 2001 01:46:43 -0400
Received: from [216.18.81.161] ([216.18.81.161]:44808 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S131275AbRDKFq3>; Wed, 11 Apr 2001 01:46:29 -0400
Date: Wed, 11 Apr 2001 01:46:40 -0400
From: William Park <parkw@better.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide.2.2.19.04092001.patch
Message-ID: <20010411014640.A4929@better.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104091720030.1878-100000@master.linux-ide.org> <20010410223554.A938@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010410223554.A938@cm.nu>; from shane@cm.nu on Tue, Apr 10, 2001 at 10:35:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 10:35:54PM -0700, Shane Wegner wrote:
> Hi,
> 
> This isn't working here on my Abit VP6 board.  The
> ide.2.2.18.1221 works fine but this latest patch as well as
> ide.2.2.19.0325 fails.
> 
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
>     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
> HPT370: IDE controller on PCI bus 00 dev 70
> HPT370: chipset revision 3
> HPT370: not 100% native mode: will probe irqs later
>     ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:DMA, hdh:pio
> hda: Maxtor 92720U8, ATA DISK drive
> hdg: Maxtor 96147U8, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide3 at 0xe400-0xe407,0xe802 on irq 10
> 
> That's where it stops.  Locks solid, not even sysrq-b
> works.

Same here with my VP6.  ide-2.2.18 worked, but ide-2.2.19 doesn't.  

--William Park, Open Geometry Consulting, Linux/Python/LaTeX/vim, 8 CPUs.
