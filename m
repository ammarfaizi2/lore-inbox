Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbSJFNyG>; Sun, 6 Oct 2002 09:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSJFNyG>; Sun, 6 Oct 2002 09:54:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37315 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261614AbSJFNyE>;
	Sun, 6 Oct 2002 09:54:04 -0400
Date: Sun, 6 Oct 2002 16:10:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk@arm.linux.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       <bcollins@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK MetaData License Problem?
In-Reply-To: <20021006144821.B31147@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210061601040.7386-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Russell King wrote:

> > it would be better if the license also said:
> > 
> > 	By transmitting the MetaData to an Open Logging server, You 
> >         hereby also agree to license the MetaData under the same license
> >         you license the data it describes.
> 
> That doesn't explicitly allow bitmover to put the metadata up in public
> view, which would mean the openlogging stuff will leave bitmover wide
> open for legal action.

(this is why i said 'also' in the above sentence. It would be in addition
to the existing (and sensible) requirement for BM to be able to republish
the commit logs.)

> > btw., this is also the case with the emails Linus puts into BK commit info
> > - the email someone sends to Linus is _not_ GPL-ed by default.
> > 
> > (perhaps the solution is simple - i'd be really happy if it was.)
> 
> The exact same problem applies to pre-BK Linus and Alan, and whoever
> else produces a change log that contains information produced by a third
> party.

with the difference that the changelog was a few orders of magnitude less
of an infrastructure element. Plus if you read those changelogs you'll see
that it's 100% written by Alan or Linus - in 99% of the cases it just
describes what the patch does, and in the remaining 1% it quotes a few key
sentences that can be considered fair use. Ie. the ChangeLog was owned by
Alan and Linus. [it would be a bit more robust if the ChangeLogs would be
part of the kernel repository, that would make them covered by the GPL.]

> Does Linus and Alan have an implicit right to republish the
> documentation that was sent to them with the patch? [...]

yes, as long as the documentation comes with the patch and is part of the
kernel tree, which the patch derives, and which kernel tree has a certain
'COPYING' file in the top directory. Patches *are* actively monitored for
conflicting licenses in individual files, and occasionally we had to
remove files.

> [...] The exim mailing lists were recently threatened with legal action
> over this very point, and there was talk at one point about having to
> shut down the whole exim.org site because of this. [...]

> So, this isn't a BK problem.  Its a community problem.

it *is* a BK problem caused by BK becase now this whole can of worms got
silently exported to the kernel tree, and while BM itself is safe via its
license, the kernel tree 'as a whole' is exposed.

until now the Linux kernel tree was distributed in a tarball that had a
nice COPYING file in a very prominent spot. With BK the situation is
different - and like i said in previous mails it's not BK's "fault", but
BK's "effect" - and it's a situation that needs to be remedied, right?

	Ingo

