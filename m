Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSDORcd>; Mon, 15 Apr 2002 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSDORcc>; Mon, 15 Apr 2002 13:32:32 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24588 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313012AbSDORcb>;
	Mon, 15 Apr 2002 13:32:31 -0400
Date: Mon, 15 Apr 2002 19:32:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
Message-ID: <20020415173231.GX12608@suse.de>
In-Reply-To: <20020415070728.GB12608@suse.de> <Pine.LNX.4.21.0204151334350.26237-100000@serv> <20020415115131.GN12608@suse.de> <3CBB0E39.F226E585@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Roman Zippel wrote:
> Hi,
> 
> Jens Axboe wrote:
> 
> > > That's not enough, some archs don't define pci_alloc_consistent/
> > > pci_free_consistent, because they have neither PCI nor ISA.
> > 
> > Please, then those archs need to provide similar functionality. This is
> > the established api, unless you want to change the documentation and xxx
> > number of drivers?
> 
> Anyway, could this part be moved to ide-dma.c or disabled with
> CONFIG_BLK_DEV_IDEDMA_PCI, as it only seems to be used in ide-dma.c. Why
> allocating this memory, when it's never used in PIO mode?

Sure, we'll get it shoe horned in there, no need to change the rules
right now.

-- 
Jens Axboe

