Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSEDOJM>; Sat, 4 May 2002 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSEDOJL>; Sat, 4 May 2002 10:09:11 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:28938 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S313019AbSEDOJK>; Sat, 4 May 2002 10:09:10 -0400
Date: Sat, 4 May 2002 16:09:03 +0200
From: tomas szepe <kala@pinerecords.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] hpt374 support
Message-ID: <20020504140903.GC20335@louise.pinerecords.com>
In-Reply-To: <20020504050112.1B44989BC9@cx518206-b.irvn1.occa.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 12 days, 6:39)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It has a problem with my 80 gigabyte Seagates - in UDMA133
> > mode, writes are inexplicably slow.  I manually set UDMA100
> > and it flies.
> Hmmm... do 80GB Seagates even support UDMA133? I could be mistaken, but
> as an owner of one, I'm pretty sure the answer is "no". In fact, I think
> Maxtor's the only company making UDMA133 drives at this point in time.

Right.

hda: ST380021A, ATA DISK drive (i.e., Seagate Barracuda IV)
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, UDMA(100)

 Model=ST380021A, FwRev=3.75, SerialNo=3HV16GXT
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5

ATA-5 would be ATA100 AFAIK?


T.
