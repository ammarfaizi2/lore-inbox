Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267662AbSLSWvV>; Thu, 19 Dec 2002 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267663AbSLSWvV>; Thu, 19 Dec 2002 17:51:21 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17680 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267662AbSLSWvT>; Thu, 19 Dec 2002 17:51:19 -0500
Date: Thu, 19 Dec 2002 17:57:35 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modutils for both redhat kernels and 2.5.x
In-Reply-To: <20021126021100.GB29814@bjl1.asuk.net>
Message-ID: <Pine.LNX.3.96.1021219175407.29958B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Jamie Lokier wrote:

> Rusty Russell wrote:
> > > Depmod no longer exists.
> > 
> > This is true.  It doesn't need to for 0.7, but it's being reintroduced
> > in 0.8 for speed.
> 
> Doesn't it?  When I upgraded from 2.5.45 to 2.5.48, and installed
> module-init-tools-0.7, a whole bunch of modules failed to load
> automatically, and I ended up with no pcmcia, no network, no
> af_packet, no loopback device...

Having the driver for the root device not load from the initrd kind of
sucks as well. Actually I always build the loopback and ramdisk in, I
don't want to find out if initrd boot would work without them ;-)

But trying to build a single kernel for multiple configs of hardware is
much harder if you can't just roll multiple initrd files from the single
compile. I guess you can build every possible driver in, but I'd rather
not.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

