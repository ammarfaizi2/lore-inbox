Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265566AbSKAB6t>; Thu, 31 Oct 2002 20:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSKAB6t>; Thu, 31 Oct 2002 20:58:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:26897 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265566AbSKAB6s>; Thu, 31 Oct 2002 20:58:48 -0500
Date: Thu, 31 Oct 2002 21:03:55 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tom Rini <trini@kernel.crashing.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Rasmus Andersen <rasmus@jaquet.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
In-Reply-To: <20021031011002.GB28191@opus.bloom.county>
Message-ID: <Pine.LNX.3.96.1021031205920.22444F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2002, Tom Rini wrote:

> On Thu, Oct 31, 2002 at 01:53:14AM +0100, Adrian Bunk wrote:
> > On Wed, 30 Oct 2002, Rasmus Andersen wrote:

> > >...
> > > As before, your comments and suggestions will be
> > > appreciated.
> > 
> > could you try to use "-Os" instead of "-O2" as gcc optimization option
> > when CONFIG_TINY is enabled? Something like the following (completely
> > untested) patch:
> 
> -Os can produce larger binaries, keep in mind.  If we're going to go
> this route, how about something generally useful, and allow for general
> optimization level / additional CFLAGS to be added.

Sure, and unrolling loops can cause cache misses and be slower than that
jmp back in a loop. The point is this is a string, the people who think
they're able to hand diddle the options can change it. And more to the
point anyone who can't find a string in a makefile shouldn't be second
guessing the compiler anyway.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

