Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317327AbSHGMT5>; Wed, 7 Aug 2002 08:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHGMT5>; Wed, 7 Aug 2002 08:19:57 -0400
Received: from daimi.au.dk ([130.225.16.1]:49841 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317327AbSHGMTz>;
	Wed, 7 Aug 2002 08:19:55 -0400
Message-ID: <3D511102.405B2AED@daimi.au.dk>
Date: Wed, 07 Aug 2002 14:22:26 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac4
References: <200208051147.g75Blh720012@devserv.devel.redhat.com> 
		<20020805205608.GA24188@galileo> <1028585971.18478.92.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-08-05 at 21:56, James Mayer wrote:
> > > The IDE debugging continues. -ac4 should fix the breakages in ac2/ac3. It
> > > hopefully also fixes the ALi hangs with non ALi north bridges (mostly
> > > Transmeta boxes).
> >
> > This update fixes my Transmeta box's ALi north bridge lockup.
> 
> Ok anyone else still have ALi IDE hangs with 2.4.19-ac4 or can I cross
> ALi off the problem list now ?

It is working just fine for me with this one (hdd is
disabled in CMOS setup to prevent BIOS from crashing):

  Bus  0, device  15, function  0:
    IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 32).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      I/O at 0xf000 [0xf00f].

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Assigned IRQ 11 for device 00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hdb: CREATIVEDVD-ROM DVD2240E 03/18/98, ATAPI CD/DVD-ROM drive
hdc: CR-4802TE, ATAPI CD/DVD-ROM drive
hdd: ST360021A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 66055248 sectors (33820 MB) w/1916KiB Cache, CHS=4111/255/63, (U)DMA
hdd: host protected area => 1
hdd: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
 hdd: hdd1 hdd2 hdd3 hdd4 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 >

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
