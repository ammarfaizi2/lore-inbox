Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTBPD7S>; Sat, 15 Feb 2003 22:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTBPD7R>; Sat, 15 Feb 2003 22:59:17 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:11460
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265777AbTBPD7Q>; Sat, 15 Feb 2003 22:59:16 -0500
Date: Sat, 15 Feb 2003 23:08:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Larry McVoy <lm@bitmover.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030215205446.GA11988@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0302151836370.13273-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, Larry McVoy wrote:

> On Sat, Feb 15, 2003 at 08:44:59PM +0000, Alan Cox wrote:
> > On Sat, 2003-02-15 at 18:12, Larry McVoy wrote:
> > > All of this sounds great and is exactly what is already the plan.
> > > There is one missing item.  A consensus in the community that if we
> > > provide BK, the CVS mirror, bkbits hosting, in return the community
> > > agrees to leave off using BK to copy BK.
> > 
> > The community is an amorphous thing so thats tricky to define
> 
> You're right, I thought of that after I posted.  What would probably
> work best is if someone who was not particularly BK friendly but
> is acknowledged as a Linux leader were to step forward and agree to
> represent the community interests.

Larry, what you ask is impossible.

This community isn't hierarchized and is unlikely to form a single opinion
on anything like corporate politics.  No one can be authoritative of 
everybody else's opinion.

It doesn't work in a pull model either where you ask for things.  Rather,
you must push things and see how it goes, how people react.

> It's clear from the fuss this causes about every three weeks that people
> don't feel safe, on either side.  You're scared that we're going to do
> some evil thing and we're scared that you are going to do evil thing.

That might be true, but I think the BK opponents from the community are more
concerned by preserving their "freedom" (or ability) to access the
up-to-the-minute changes that appeared in the official kernel reference
repository, and without being forced to use a proprietary tool with a
proprietary protocol and with restrictive license terms.  I really think it
has nothing to do with BK itself beside the fact that it's BK that is used
to handle the data they cherish so much and no "free" path currently exists
to that data.  Even if hourly snapshots do exist, that still makes those
people sort of second class citizens.  They want the changes available to
them in real time but in the most purist free way too.  The best answer is a
CVS gateway IMHO, and then the true believers, or those who simply can't
comply with your license for all sort of good and legitimate reasons, won't
have anything against you from that moment since they won't see BK as an
obstacle in the way.

If a real time CVS gateway exists, and bkbits.net is pushing CVS commits to
kernel.org and linux.org.uk just to name those few obvious examples among
others, then individuals within this community will have the choice between
many tools according to their respective characteristics and not based on the
quality of service with regards to the kernel repository.

Only then people won't be able to invoke the BitMover lock-in argument
against the Linux community (regardless if that was your intention or not),
and only then will you be able to consider those who try to reverse-engineer
your "technology" as bad people, since invoking fair use will then be much
harder to legitimate.

In other words, if people can have real time change sets to the reference
kernel and have the possibility of ignoring you and BK entirely at the same
time, only then the issue will be closed.

> Maybe it's not possible, but it would be nice if we could, operating in
> good faith, work out some sort of agreement that made sense.  Yeah, I
> know it isn't binding, that the best you could do on the community side is
> have a bunch of people stand up and say "hey, leave BitMover alone, they
> are doing a good service" but I'd take that over the current mess any day.

You are doing the best you can in the terms you chose, and a lot of people
including myself are extremely grateful.  Your terms are just totally
incompatible with the view of some people.  And many of those people just
don't like what you do and they _never_ will, that's a simple fact of life.
Your only way out is to provide a mechanism that will allow them to totally
ignore you without impairing their access to the kernel development data.  
BK might be way ahead at what it does, but real-time access to the kernel
repository must _not_ be among the advantages of BK against competitor
products/solutions.


Nicolas

