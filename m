Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317414AbSGDNhV>; Thu, 4 Jul 2002 09:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSGDNhU>; Thu, 4 Jul 2002 09:37:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61968 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317414AbSGDNhT>; Thu, 4 Jul 2002 09:37:19 -0400
Date: Thu, 4 Jul 2002 09:33:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Kernel release management
In-Reply-To: <20020704130243.A11601@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020704091340.4082D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, Russell King wrote:

> > The maintainer can alway push really new stuff into 2.7, and Linus can
> > always refuse to take a feature into 2.7 until something else is fixed in
> > 2.6.
> 
> And you expect Linus to track every single feature and fix that exists in
> 2.6 and 2.7?

The maintainer should have a handle on the serious problems in 2.6, and
should be able to tell Linus who needs to look at a problem before moving
on. Not having a development kernel didn't work well for 2.2, it didn't
work well in 2.4, and now some people say "we've always done it that way"
while others say "we'll do it better this time." It's my feeling that
trying something else would be a good thing, if 2.6 doesn't get attention
2.7 could always be frozen after it exists, and you would still avoid
having totally new featues shoved in 2.6.
 
> If 2.6 and 2.7 come out at the same time, I'll have to ignore one or either
> of the source trees completely.  As an architecture maintainer, that would
> be *bad*.

If 2.6 is so buggy that it takes your full time to fix, it should still be
2.5. And it should take your full time. And that wouldn't be one bit
different than if 2.7 wasn't out, would it? 

If I understand what you do, it is limited to things related to your
architecture, and not general bugs like IDE eats the filesystems, stuff
won't compile as modules, smp locks up under high network multicast load,
etc. Unless changes in 2.6 break your area, which will be MUCH less likely
if new features are going in 2.7, I really wouldn't expect it to take all
your time.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

