Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268257AbTALILE>; Sun, 12 Jan 2003 03:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268262AbTALILE>; Sun, 12 Jan 2003 03:11:04 -0500
Received: from mark.mielke.cc ([216.209.85.42]:13 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S268257AbTALILC>;
	Sun, 12 Jan 2003 03:11:02 -0500
Date: Sun, 12 Jan 2003 03:28:22 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Valdis.Kletnieks@vt.edu
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: inefficient RT vs efficient non-RT
Message-ID: <20030112082822.GB16050@mark.mielke.cc>
References: <20030112075844.GA16050@mark.mielke.cc> <200301120804.h0C84jLE011563@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301120804.h0C84jLE011563@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 03:04:44AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 12 Jan 2003 02:58:44 EST, Mark Mielke said:
> > Think about it logically -- if I can process 5X as much data as you can on
> > the same hardware, but I can't guarantee that *at* 5X no data will be lost,
> > but then, I only run at 1X (the same speed as you), how many packets have
> > a chance of being lost?
> The question is, of course, whether you're willing to bet the entire
> chemical plant on the chances of a packet being lost.

> There's a difference between "if the core temperature hits 350
> degrees, the pump WILL go on in 13 milliseconds" and "if the core temp
> hits 350 degrees, the pump will have a 98% chance of going on sometime
> between 13 and 17.5 milliseconds..."

Of course, this is besides the original point which had nothing to do
with whether RT is better for tasks that require RT response times.

The point is that VxWorks sucks. The secondary point is that Linux may
be quite a bit more sophisticated than VxWorks. The reason for making
the point is that a guy jumped on linux-devel saying that anybody can
write a kernel, and he knows, because he has contributed to
VxWorks. He then went on to say that he has personally submitted
several dozen patches to VxWorks.

So please stop telling me what RT is and what it is best used for. I never
meant to say, nor do I think I said, that RT tasks can be 100% provided for
by non-RT Linux. If you read the posts again without this bias, you will
see that it is a stab at VxWorks, *not* a claim that RT is unnecessary.

It *is* a claim (and note the altered subject) that *anybody* can
write a crappy operating system, and people can even *sell* crappy
operating systems. I guarantee to you that I can personally write a
crappy enough RT operating system given sufficiently little time,
that Linux could satisfy 1000X the capacity of my operating system,
and running at 1X, I predict the rate that it misses on a response is
less than the rate of bugs that trigger in my code making my supposed
RT system, effectively non-RT.

It *is* a claim that Linux is not a crappy operating system.

*sigh*

mark

P.S. Don't tell me you have never heard your land line fail on you, or
     your cell phone click or otherwise. A certain amount of failure *is*
     acceptable, and in fact, unavoidable without charging you significantly
     more than what you pay for to be able to use your cell phone anywhere
     in North America, or anywhere in the world. If you paid $1000/minute,
     that would be different...

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

