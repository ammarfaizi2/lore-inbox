Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282472AbRKZUWl>; Mon, 26 Nov 2001 15:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282467AbRKZUWd>; Mon, 26 Nov 2001 15:22:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52999 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282472AbRKZUWY>; Mon, 26 Nov 2001 15:22:24 -0500
Date: Mon, 26 Nov 2001 15:15:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andi Kleen <ak@muc.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <m3lmgug4vl.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.3.96.1011126150917.27112F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001, Andi Kleen wrote:

> "Peter T. Breuer" <ptb@it.uc3m.es> writes:
> 
> > "A month of sundays ago Chris Chabot wrote:"
> > > The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
> > > 2.4.9 upto 2.4.15, in all situations the same problem appeared.
> > > 
> > > The problem is that when the box boots up, it uses about 60Mb of memory.
> > > However after only 1 1/2 days, the memory usage is already around 430Mb
> > > (!!). (this is ofcource used - buffers - cache, as displayed by 'free').
> > 
> > I also have this problem. Unknown circumstances provoke it. Kernel
> > 2.4.9 to 2.4.13.  When it occurs I lose about 30MB a day.
> 
> Compare snapshots of /proc/slabinfo before and after.

This may be useful, but I've never seen anything like that magnitude of
usage, either on dns servers (some of mine are up ~150 days), or usenet
servers (several about to hit the 497 day problem). It will be
insteresting to see what's reported, though.
 
> It may be completely harmless; e.g. a slab cache. free is unfortunately 
> quite misleading with newer kernels; it doesn't give information about
> many important caches (e.g. not about the slab caches) 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

