Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbSJFKsD>; Sun, 6 Oct 2002 06:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263376AbSJFKsD>; Sun, 6 Oct 2002 06:48:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61893 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S263375AbSJFKsC>;
	Sun, 6 Oct 2002 06:48:02 -0400
Date: Sun, 6 Oct 2002 13:04:39 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       Ben Collins <bcollins@debian.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210061229320.3729-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Oct 2002, Alan Cox wrote:

> Linus used to do about a patch every 2 days. Nowdays its a lot slower.
> [...]

it's actually much different, and the patch flux has not only became much
larger (compare the current _per day_ patch flux with the one from one
year ago), it has also become more consistent. The 'trivial' patches get
in much more consistently, many subsystems have become more uptodate than
in eg. the 2.3 kernel days. And for people to keep posting stuff they need
dependability. Also, it's easier to get core stuff in these days because
1) the kernel is 'frozen' much more rarely 2) it's much easier for Linus
to just unroll bad stuff. Plus the BK tools to look at a piece of source
code's evolution over time are really nice and useful when trying to sync
up with some code one has not seen for a couple of weeks.

but i share some of your fundamental concerns. As much as i like Larry the
person, Larry the businessman is apparently a distinct entity. I remember
when moving the kernel tree over to BK was raised first time (it was not
even called bitkeeper back in that time), Larry talked about some sort of
guarantees that involve GPL-ing of BK code 1-2 years after it's first used
by the kernel, to make sure the Linux kernel tree is not left in limbo.

Today we are _very_ far away from such guarantees - and in fact i was
Cc:-ed on a mail in where kernel.org's admin got flamed by Larry with "you
get what you pay for" when he simply asked for a .rpm version of the
binary-only bk stuff so that it becomes easier to maintain. Larry, do you
have any plans to GPL the BK code at any future date?

And i'm not sure what Larry the businessman would say to a $100m
acquisition offer today. Or a $200m one, or a $500m one. Based on Larry's
past comments we have to assume that "yes" would be the answer - because
he has employees who have kids to be fed, etc.

So i believe the hard point of no return is the day the commit metadata
becomes proprietary, either via using a proprietary format, or via getting
a patent awarded. (it isnt right now, despite increasing centralization.)
That would be the time Ingo the kernel hacker would definitely say 'no' to
BK. (despite of what Ingo the person thinks about Larry the person.)

i'm also a bit worried about the legal status of commit messages posted
via bkbits. Are they GPL-ed automatically, can we just take them and put
them into a free-BK type server? We already have one precedent of a
business entity abusing a free OS project and then suing it (and winning
the suit), hindering the free OS's development for years.

and frankly, i find it very sobering how Larry (the businessman?) plays
down the fundamental and valid worries of the Linux community with "well
you get what you pay for" type of arguments. There are tons of other
businesses in the world that would 'pay' alot more than a free server, a
T1 line, and "ask nicely enough and be prepared to be flamed when you are
asking for too much" kind of free support, for the big PR-advantage of
hosting the Linux kernel tree. Occasionally i ask myself whether the
significant de-loading of Linus' patch management work is worth the
increasing feeling of ... humiliation this causes.

	Ingo

