Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290545AbSA3UGr>; Wed, 30 Jan 2002 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290528AbSA3UGh>; Wed, 30 Jan 2002 15:06:37 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:48392 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290537AbSA3UG3>; Wed, 30 Jan 2002 15:06:29 -0500
Date: Wed, 30 Jan 2002 21:06:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Larry McVoy <lm@bitmover.com>
cc: Jeff Garzik <garzik@havoc.gtf.org>, Rob Landley <landley@trommello.org>,
        Miles Lane <miles@megapathdsl.net>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130080642.E18381@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201301830320.9003-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Jan 2002, Larry McVoy wrote:

> > What we IMO need is a patch management system
> > not a source management system.
>
> BK can happily be used as a patch management system and it can, and has
> for years, been able to accept and generate traditional patches.  Linus
> could maintain the source in a BK tree and make it available as both
> a BK tree and traditional patches.

It's not really the same or that's not what I mean with patch management
system or can bk also manage the patches, which Linus drops?
What I have in mind is a patch management system which tracks the status
of unapplied patches. The status could be:
- patch applies cleanly to tree x.
- patch is approved/disappoved by y.
- patch is in tree z since version...
This system should not only support Linus, but also other tree
maintainers, so they can pick patches they want to integrate into their
trees, which could also feed back information which patch conflicts with
another patch (this could be done by the patchbot as well, but humans are
usually better at judging which patch is more important).
Linus again could use this information to decide which patches he
integrates into his in own tree, so he can easier sync up with other
trees.
My suggestion would be to setup an alias for Linus and/or Marcelo, which
just collects patches send to them. Anyone interested in implementing a
patchbot can use this data to test and demonstrate his/her implementation.

bye, Roman

