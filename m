Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314082AbSDQOAs>; Wed, 17 Apr 2002 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSDQOAr>; Wed, 17 Apr 2002 10:00:47 -0400
Received: from dark.x.dtu.dk ([130.225.92.246]:29089 "HELO dark.x.dtu.dk")
	by vger.kernel.org with SMTP id <S314082AbSDQOAr>;
	Wed, 17 Apr 2002 10:00:47 -0400
Date: Wed, 17 Apr 2002 16:00:45 +0200
From: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
To: Mike Dresser <mdresser_l@windsormachine.com>
Cc: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
Message-ID: <20020417140045.GC27648@dark.x.dtu.dk>
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk> <Pine.LNX.4.33.0204170940310.29775-100000@router.windsormachine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Dresser (mdresser_l@windsormachine.com):
> On Wed, 17 Apr 2002, Baldur Norddahl wrote:
> 
> > Hi,
> >
> > I have been doing some simple benchmarks on my IDE system. It got 12 disks
> > and a system disk. The 12 disks are organized in two raids like this:
> 
> What is the exact hardware configuration of the system, besides the disk?
> CPU/Motherboard/etc?

Motherboard: Tyan Tiger MPX S2466N
Chipset: AMD 760MPX
CPU: Dual Athlon MP 1800+ 1.53 GHz                                              
Two Promise Technology UltraDMA133 TX2 controllers
Two Promise Technology UltraDMA100 TX2 controllers
Matrox G200 AGP video card.
1 GB registered DDR RAM

> > hdq: dma_intr: bad DMA status (dma_stat=35)
> > hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> > hdq: dma_intr: bad DMA status (dma_stat=35)
> > hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> > hdt: dma_intr: bad DMA status (dma_stat=75)
> > hdt: dma_intr: status=0x50 { DriveReady SeekComplete }
> 
> I'd take a look at the cable on hdq and hdt.  Try replacing it, and see
> what happens.

It happens randomly for all disks on the promise controllers. Never for the
system disk on hda (on the motherboard buildin controller). The above was
just a random snippet from dmesg, there is alot more of the same spam.

> Also, with 12 hd's, dual cpu's, etc, what kind of power supply are you
> using?

It is a 350W powersupply. I wanted something bigger, but couldn't get it for
sane prices. I can't rule out that it is overloaded of course. If it is, I
haven't seen any other symptoms, the system is rock stable so far.

Baldur
