Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSDQNnx>; Wed, 17 Apr 2002 09:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314073AbSDQNnw>; Wed, 17 Apr 2002 09:43:52 -0400
Received: from windsormachine.com ([206.48.122.28]:61190 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S314052AbSDQNnv>; Wed, 17 Apr 2002 09:43:51 -0400
Date: Wed, 17 Apr 2002 09:43:47 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IDE/raid performance
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk>
Message-ID: <Pine.LNX.4.33.0204170940310.29775-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Baldur Norddahl wrote:

> Hi,
>
> I have been doing some simple benchmarks on my IDE system. It got 12 disks
> and a system disk. The 12 disks are organized in two raids like this:

What is the exact hardware configuration of the system, besides the disk?
CPU/Motherboard/etc?

> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdt: dma_intr: bad DMA status (dma_stat=75)
> hdt: dma_intr: status=0x50 { DriveReady SeekComplete }

I'd take a look at the cable on hdq and hdt.  Try replacing it, and see
what happens.

Also, with 12 hd's, dual cpu's, etc, what kind of power supply are you
using?

Mike

