Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSKDTsd>; Mon, 4 Nov 2002 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262636AbSKDTsd>; Mon, 4 Nov 2002 14:48:33 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:26293 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S262648AbSKDTsc>; Mon, 4 Nov 2002 14:48:32 -0500
Date: Mon, 4 Nov 2002 12:51:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rob Landley <landley@trommello.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021104195144.GC27298@opus.bloom.county>
References: <20021031011002.GB28191@opus.bloom.county> <Pine.LNX.3.96.1021031205920.22444F-100000@gatekeeper.tmr.com> <20021101141559.GD815@opus.bloom.county> <200211012059.32304.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211012059.32304.landley@trommello.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:13:48AM +0000, Rob Landley wrote:
> On Friday 01 November 2002 14:15, Tom Rini wrote:
> 
> > > Sure, and unrolling loops can cause cache misses and be slower than that
> > > jmp back in a loop. The point is this is a string, the people who think
> > > they're able to hand diddle the options can change it. And more to the
> > > point anyone who can't find a string in a makefile shouldn't be second
> > > guessing the compiler anyway.
> >
> > Yes, so why can't those who still need a few more kB after trying some
> > of the other options go and find '-O2' and replace it with '-Os' ?
> 
> Because the point of CONFIG_TINY is to make the kernel smaller and this is 
> something that makes the kernel smaller?  (In fact telling the compiler 
> "optimize for size" is one of the most OBVIOUS things to do?)
> 
> I've used -Os.  I've compiled dozens and dozens of packages with -Os.  It has 
> always saved at least a few bytes, I have yet to see it make something 
> larger.  And in the benchmarks I've done, the smaller code actually runs 
> slightly faster.  More of it fits in cache, you know.

Then we don't we always use -Os?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
