Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288747AbSA3NYP>; Wed, 30 Jan 2002 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSA3NYG>; Wed, 30 Jan 2002 08:24:06 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:43921 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288747AbSA3NXz>;
	Wed, 30 Jan 2002 08:23:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Wanted: Volunteer to code a Patchbot
Date: Wed, 30 Jan 2002 14:28:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201301306190.7674-100000@serv>
In-Reply-To: <Pine.LNX.4.33.0201301306190.7674-100000@serv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VumS-0000EM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 01:39 pm, Roman Zippel wrote:
> On Wed, 30 Jan 2002, Daniel Phillips wrote:
> 
> > > I'd rather make the patchbot more intelligent, that means it analyzes 
the
> > > patch and produces a list of touched files. People can now register to 
get
> > > notified about patches, which changes areas they are interested in.
> >
> > But they can already do that, by subscribing to the respective mailing 
list
> > (obviously, the bot posts to the list as well as forwarding to the
> > maintainer) and running the mails through a filter of their choice.
> 
> What about unmaintained parts?

One or both of patches-2.4@kernel.org or patches-2.5@kernel.org

> > > In the simplest configuration nothing would change for Linus, but 
patches
> > > wouldn't get lost and people could be notified if their patch was 
applied
> > > or if it doesn't apply anymore.
> >
> > OK, it would be nice, but you wouldn't want to pile on so many features 
that
> > this never gets implemented would you?  The minimal thing that forwards 
and
> > posts patches is what we need now.  Like any other software it can be
> > improved over time.
> 
> That's what I have in mind. What we can already do now is to store
> incoming patches into some directory. That would give us already some
> basic data to work with and we can start to implement new features as they
> are needed.

Yes, mine the data.

> > Automating the applied/dropped status is clearly the next problem to 
tackle,
> > but that's harder, it involves behavioral changes on the maintainers side.
> 
> What "behavioral changes"? Maintainers should react in some way or another
> react to patches no matter where come from.

They already have their own ways of reacting.  I don't hear a lot of pleading
from maintainers for tools to help them respond to patches; most seem to be
satisfied with Mutt or whatever.  I feel sure that any attempt to force
changes to such personal practices will be met with a solid wall of
disinterest.

> > (Pragmatically, providing a web interface so somebody whose job it is to 
do
> > that, can efficiently post 'applied' messages to the list would get the 
job
> > done without making anyone learn new tools or change the way they work.)
> 
> Web interfaces can be nice, but the bulk work should be doable by mail.

Oh yes, certainly.

> For changes in areas which have a maintainer, the mail to Linus could
> include a note "forwarded to maintainer x" and Linus can still decide,
> whether he applies the patch or waits for the OK from the maintainer.

Or just cc it to lkml and don't bother Linus.  If Linus wants to know about
traffic to maintainers he can look in the mail archives (he won't).

> > By the way, who is going to code this?  Or are we determined to make
> > ourselves look like wankers once again, by putting considerably more time
> > into the lkml flamewar than goes into producing working code?
> >
> > (Hint: I am not going to code it, nor should I since I should be working 
in
> > the kernel.)
> 
> That's a known problem, I have no time either, but we should give anyone
> interested in this some example data. This data has to come from the
> kernel hackers, but patch management system is better implemented by
> non-kernel hackers.

<deleted>
That's the problem.  I have seen at least two attempted starts on a patchbot
and know of a third (Dan Quinlan was going to do something 1.5 years ago).
So at this point I want to step out of this discussion.  There is going to
be no patchbot without a coder to write it, so why spend more time talking
about it?
</deleted>

OK, on a less pessimistic note, I'll make a small effort to find a volunteer 
to code this, under advisement that it will be a thankless task (everybody 
will complain about everything) and may not even get accepted by Linus or 
anyone else (yes, and?).  So here it is:

   Wanted: a scripting person who has a clue about MTAs and wants to 
   contribute to the kernel.  Please step up to the table over here
   and sign in blood, then we will tell you what your mission is.
   Nobody will thank you for any of the work you do or reward you in
   any way, except for the right to bask in the glory and fame of
   being the one who ended the patchbot wars.  And maybe, just maybe
   get that coveted Slashdot interview.

OK. that's it, if somebody bites I'll gladly participate in a design thread, 
otherwise I think this is just going to sleep until the next bi-monthly 
patchbot flameup.

/me goes back to work

-- 
Daniel
