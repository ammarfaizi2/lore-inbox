Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290657AbSA3WJk>; Wed, 30 Jan 2002 17:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290646AbSA3WJZ>; Wed, 30 Jan 2002 17:09:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61457 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290645AbSA3WHi>; Wed, 30 Jan 2002 17:07:38 -0500
Date: Wed, 30 Jan 2002 17:06:15 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201300917270.1928-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020130165655.5584B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Linus Torvalds wrote:

> 
> On Wed, 30 Jan 2002, Alan Cox wrote:
> >
> > So if someone you trusted actually started batching up small fixes and
> > sending you things like
> >
> > "37 random documentation updates - no code changed", "11 patches to fix
> > kmalloc checks", "maintainers updates to 6 network drivers"
> >
> > that would work sanely ?
> 
> Yes. That would take a whole lot of load off me - load I currently handle
> by just not sweating the small stuff, and concentrating on the things I
> think are important.

Once more beating a dead horse, you don't improve scalability by finding a
better way to push everything through one person. "Random documentation
updates" and "corrections to MAINTAINERS mailing addresses" could and
should be approved by someone else.

So should the 1-2-3 liners which are clearly and obviously tiny bug fixes
for obvious problems, off by one, mistyped lock names, adding casts to
make the kernel compile w/o hundreds of "you don't understand C type
rules" warnings.

The way to get crap out of your life is to trust some people to identify
changes of this type and leave you to code review significant changes. The
most efficient way to do something is to avoid having to do it all all,
not by doing the wrong thing better. Pushing hard to you is like hand
coding a bubble sort in assembler, the problem is not in the
implementation but the algorithm. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

