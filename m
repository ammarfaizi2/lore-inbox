Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310223AbSCLAQu>; Mon, 11 Mar 2002 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCLAQk>; Mon, 11 Mar 2002 19:16:40 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7433 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310223AbSCLAQ2>; Mon, 11 Mar 2002 19:16:28 -0500
Date: Mon, 11 Mar 2002 19:14:39 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111449190.17864-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Linus Torvalds wrote:

> Note that I've actually tried to read all patches, and right now they are 
> all in my tree (of course, the "all" is the Linus kind of "all", which 
> only includes the ones I actually _noticed_. 
> 
> That includes your AMD IDE driver change _and_ the oh-so-much-discussed
> patches by Martin (which in turn included Pavel's change, which - together
> with his changelog entry - seems to be the one that triggered the "lively
> discussions").

I think you might want to offer an opinion (or edict, mandate, whatever)
WRT taskfile. While I think that some protective editing of commands is
desirable, useful, etc, I'm damn sure that some form of raw access is
required long term to allow diagmostics. I wouldn't argue if that
interface was required for low level format and other really drastic
operations as well.

I think "future new commands" is total FUD, the idea that some new command
would come along and be so instantly popular, useful and incompatible that
all Linux boxes would require it before the next kernel or driver update
is silly at best, and I'm working hard to keep this on a civil plane.
Linux moves a hell of a lot faster than Windows, and I can't see anything
coming out which requires "instant attention" because it is totally
incompatible with existing drivers. Most changes will be only added
functionality, like 48 bit addressing, and will be a superset of current
drivers. In other words, not everyone will wnat or need the capability,
and no one is going to feel that a month or so wait from driver TESTING
would cause them to give up computing and become a stripper in a gay bar.

In any case, taskfile is here, and unless there is a good reason to drop
lightly edited commands, or raw commands, or go to some totally different
approach, I wish you would express a clear opinion, at least WRT 2.4,
before developers become nasty and stop limiting themselves to accusations
of stupidity, incompetence, inreliability and prevarication.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

