Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbSLKPtO>; Wed, 11 Dec 2002 10:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSLKPtO>; Wed, 11 Dec 2002 10:49:14 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:44683 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S267180AbSLKPtM>; Wed, 11 Dec 2002 10:49:12 -0500
Date: Wed, 11 Dec 2002 16:56:50 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: Linux 2.4.21-pre1
Message-ID: <20021211155650.GU8741@charite.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
References: <Pine.LNX.4.50L.0212101834240.23096-100000@freak.distro.conectiva> <20021211090829.GD8741@charite.de> <1039622867.17709.31.camel@irongate.swansea.linux.org.uk> <20021211153414.GQ8741@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211153414.GQ8741@charite.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> According to the 2.4.20 kernel (see
> http://www.stahl.bau.tu-bs.de/~hildeb/kernel/2.4.20.jpg for a snapshot
> of the boot process!) the drives are:  
> 
> hda: TOSHIBA MK4019GAX, ATA DISK drive
> hdc: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
> 
> And the controller:
> ICH3M: chipset revision 2

More details (lspci -vv):

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Toshiba America Info Systems: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at cff8 [size=8]
        Region 1: I/O ports at cff4 [size=4]
        Region 2: I/O ports at cfe8 [size=8]
        Region 3: I/O ports at cfe4 [size=4]
        Region 4: I/O ports at cfa0 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Why you can't find your system administrators:
The Cray's Chiller decided to go on vacation, and (S)he got stuck to one of the vents on the Y-MP after switching to air-cooled mode. 
--Jeff Wolfe wolfe@ems.psu.edu

