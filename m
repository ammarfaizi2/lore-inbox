Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268933AbTBWV10>; Sun, 23 Feb 2003 16:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbTBWV10>; Sun, 23 Feb 2003 16:27:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41480 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268933AbTBWV1Z>; Sun, 23 Feb 2003 16:27:25 -0500
Date: Sun, 23 Feb 2003 13:34:32 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <15961.8482.577861.679601@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0302231326370.1534-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, David Mosberger wrote:
> 
> But does x86 reall work so well?  Itanium 2 on 0.13um performs a lot
> better than P4 on 0.13um.

On WHAT benchmark?

Itanium 2 doesn't hold a candle to a P4 on any real-world benchmarks.

As far as I know, the _only_ things Itanium 2 does better on is (a) FP
kernels, partly due to a huge cache and (b) big databases, entirely
because the P4 is crippled with lots of memory because Intel refuses to do
a 64-bit version (because they know it would totally kill ia-64).

Last I saw P4 was kicking ia-64 butt on specint and friends.

That's also ignoring the fact that ia-64 simply CANNOT DO the things a P4
does every single day. You can't put an ia-64 in a reasonable desktop
machine, partly because of pricing, but partly because it would just suck
so horribly at things people expect not to suck (games spring to mind).

And I further bet that using a native distribution (ie totally ignoring
the power and price and bad x86 performance issues), ia-64 will work a lot
worse for people simply because the binaries are bigger. That was quite
painful on alpha, and ia-64 is even worse - to offset the bigger binaries,
you need a faster disk subsystem etc just to not feel slower than a
bog-standard PC.

Code size matters. Price matters. Real world matters. And ia-64 at least 
so far falls flat on its face on ALL of these.

>                         As far as I can guess, the only reason P4
> comes out on 0.13um (and 0.09um) before anything else is due to the
> latter part you mention: it's where the volume is today.

It's where all the money is ("ia-64: 5 billion dollars in the red and
still sinking") so of _course_ it's where the efforts get put.

			Linus

