Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318294AbSGYBvI>; Wed, 24 Jul 2002 21:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318296AbSGYBvI>; Wed, 24 Jul 2002 21:51:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13796 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S318294AbSGYBvH>; Wed, 24 Jul 2002 21:51:07 -0400
Date: Thu, 25 Jul 2002 03:54:06 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
In-Reply-To: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com>
Message-ID: <Pine.SOL.4.30.0207250311480.871-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

On Wed, 24 Jul 2002, Linus Torvalds wrote:

> On 25 Jul 2002, Daniel Egger wrote:

> > Am Don, 2002-07-25 um 00.52 schrieb Linus Torvalds:
> >
> > > Actually, that patch _was_ on the mailing list, with lots of discussion.
> >
> > So IDE-101 equals to the small snippet of code pasted somewhere in the
> > evil flamewar?
>
> Have you _looked_ at the full changelog? Apparently not.
>
> The snippet was posted as part of the IDE-2.5.27 thread. Go look for it
> yourself. In addition, I asked Martin to send it to me separately, to
> verify that he hadn't had other issues too. The full changelog has that
> email.

Yes, but the code actually is only this fix.

> > > And since none of the discussion was civil, it didn't get a changelog. But
> > > you can search it out yourself.
> >
> > Especially since the IDE code at the moment is not really something I
> > would trust uncoditionally a bit more comentary would be adequate IMHO,
> > even if it's just a: "Fixed race introduced in IDE-97, see flamewar"...
>
> Most of the IDE stuff is FUD and misinformation. I've run every single
> 2.5.x kernel on an IDE system ("penguin.transmeta.com" has everything on
> IDE), and the main reported 2.5.27 corruption was actually from my BK tree
> apparently due to the IRQ handling changes.

I wish it was misinformation.

> > Perhaps not everyone wanting to use 2.5.x for some development is
> > eager to disassemble a patch to see whether it might be usable or
> > trash the partition even more badly (given that one has the knowledge
> > to judge for her-/himself).
>
> The thing I dislike is how people who apparently haven't even read the
> discussions, and didn't bother to look up the full changelog feel that
> they are perfectly fine to spread FUD and misinformation about the IDE
> layer.
>
> Do we have issues there? Yes. But there are actually _more_ problems with
> people dissing the work than with the code itself.

No, I worked on this code really hard for some time.
Just got tired listening to flacky ideas and syncing against
intendation/whitespaces changes.

The biggest problem with IDE is not code or dissing people,
but _the way_ of changes...

And the thing I dislike is how people who apparently haven't read
carefully every ide-clean patch, and didn't bother to look up the full
track of changes (2.4 -> 2.5) feel that they are perfectly fine to make
such statements ;-).

> 		Linus

Linus, please don't add me to .killmail for this mail yet :-).

It is really _the last_ mail on this subject.
Yep, I did too much of this dissing lately...
...and it was really not needed.

Regards
--
Bartlomiej

