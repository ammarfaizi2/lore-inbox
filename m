Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318895AbSH1TCe>; Wed, 28 Aug 2002 15:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318905AbSH1TCe>; Wed, 28 Aug 2002 15:02:34 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:11527 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318895AbSH1TCd>; Wed, 28 Aug 2002 15:02:33 -0400
Date: Wed, 28 Aug 2002 21:06:50 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ECS K7S5A: IDE performance
Message-ID: <20020828190650.GC16018@louise.pinerecords.com>
References: <Pine.LNX.4.44.0208281552190.213-100000@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208281552190.213-100000@pervalidus.dyndns.org>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 3 days, 10:28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have an ECS K7S5A 3.1A. It works fine with 2.4.19. No
> corruption. Now I tested it with hdparm and:
> 
> hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
>  Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec
> 
> Only 38.10 ?

How do you mean, only 38.10?

> hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=MAXTOR 6L060J3, FwRev=A93.0500, SerialNo=663200252994
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
>  BuffType=DualPortCache, BuffSize=1819kB, MaxMultSect=16, MultSect=off
>  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=117266688
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma6
>  AdvancedPM=no WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  1 2 3 4 5

Looks ok to me.

T.
