Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSGYBEb>; Wed, 24 Jul 2002 21:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318146AbSGYBEb>; Wed, 24 Jul 2002 21:04:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20496 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318061AbSGYBEa>; Wed, 24 Jul 2002 21:04:30 -0400
Date: Wed, 24 Jul 2002 18:08:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Egger <degger@fhm.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
In-Reply-To: <1027553482.11881.5.camel@sonja.de.interearth.com>
Message-ID: <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Jul 2002, Daniel Egger wrote:
> Am Don, 2002-07-25 um 00.52 schrieb Linus Torvalds:
>
> > Actually, that patch _was_ on the mailing list, with lots of discussion.
>
> So IDE-101 equals to the small snippet of code pasted somewhere in the
> evil flamewar?

Have you _looked_ at the full changelog? Apparently not.

The snippet was posted as part of the IDE-2.5.27 thread. Go look for it
yourself. In addition, I asked Martin to send it to me separately, to
verify that he hadn't had other issues too. The full changelog has that
email.

> > And since none of the discussion was civil, it didn't get a changelog. But
> > you can search it out yourself.
>
> Especially since the IDE code at the moment is not really something I
> would trust uncoditionally a bit more comentary would be adequate IMHO,
> even if it's just a: "Fixed race introduced in IDE-97, see flamewar"...

Most of the IDE stuff is FUD and misinformation. I've run every single
2.5.x kernel on an IDE system ("penguin.transmeta.com" has everything on
IDE), and the main reported 2.5.27 corruption was actually from my BK tree
apparently due to the IRQ handling changes.

> Perhaps not everyone wanting to use 2.5.x for some development is
> eager to disassemble a patch to see whether it might be usable or
> trash the partition even more badly (given that one has the knowledge
> to judge for her-/himself).

The thing I dislike is how people who apparently haven't even read the
discussions, and didn't bother to look up the full changelog feel that
they are perfectly fine to spread FUD and misinformation about the IDE
layer.

Do we have issues there? Yes. But there are actually _more_ problems with
people dissing the work than with the code itself.

		Linus

