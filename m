Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265025AbSKAOMs>; Fri, 1 Nov 2002 09:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265023AbSKAOMo>; Fri, 1 Nov 2002 09:12:44 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:20908 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265026AbSKAOMn>; Fri, 1 Nov 2002 09:12:43 -0500
Date: Fri, 1 Nov 2002 07:15:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021101141559.GD815@opus.bloom.county>
References: <20021031011002.GB28191@opus.bloom.county> <Pine.LNX.3.96.1021031205920.22444F-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021031205920.22444F-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 09:03:55PM -0500, Bill Davidsen wrote:
> On Wed, 30 Oct 2002, Tom Rini wrote:
> 
> > On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> > > On Wed, 30 Oct 2002, Rasmus Andersen wrote:
> 
> > > >...
> > > > As before, your comments and suggestions will be
> > > > appreciated.
> > > 
> > > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > > when CONFIG_TINY is enabled? Something like the following (completely
> > > untested) patch:
> > 
> > -Os can produce larger binaries, keep in mind.  If we're going to go
> > this route, how about something generally useful, and allow for general
> > optimization level / additional CFLAGS to be added.
> 
> Sure, and unrolling loops can cause cache misses and be slower than that
> jmp back in a loop. The point is this is a string, the people who think
> they're able to hand diddle the options can change it. And more to the
> point anyone who can't find a string in a makefile shouldn't be second
> guessing the compiler anyway.

Yes, so why can't those who still need a few more kB after trying some
of the other options go and find '-O2' and replace it with '-Os' ?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
