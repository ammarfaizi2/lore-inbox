Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSA2XxP>; Tue, 29 Jan 2002 18:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286968AbSA2XwI>; Tue, 29 Jan 2002 18:52:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:773 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287163AbSA2Xvp>; Tue, 29 Jan 2002 18:51:45 -0500
Date: Tue, 29 Jan 2002 15:50:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@trommello.org>
cc: Skip Ford <skip.ford@verizon.net>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201292332.g0TNWwU21215@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Rob Landley wrote:
> > >
> > > Then why not give the subsystem maintainers patch permissions on your
> > > tree. Sort of like committers.  The problem people have is that you're
> > > dropping patches from those ten-twenty people you trust.
> >
> > No. Ask them, and they will (I bet) pretty uniformly tell you that I'm
> > _not_ dropping their patches (although I'm sometimes critical of them,
> > and will tell them that they do not get applied).
>
> Andre Hedrick, Eric Raymond, Rik van Riel, Michael Elizabeth Chastain, Axel
> Boldt...

NONE of those are in the ten-twenty people group.

How many people do you think fits in a small group? Hint. It sure isn't
all 300 on the maintainers list.

> Ah.  So being listed in the maintainers list doesn't mean someone is actually
> a maintainer it makes sense to forward patches to?

Sure it does.

It just doesn't mean that they should send stuff to _me_.

Did you not understand my point about scalability?  I can work with a
limited number of people, and those people can work with _their_ limited
number of people etc etc.

The MAINTAINERS file is _not_ a list of people I work with on a daily
basis. In fact, I don't necessarily even recognize the names of all those
people.

Let's take an example. Let's say that you had a patch for ppp. You'd send
the patch to Paul Mackerras. He, in turn, would send his patches to David
Miller (who knows a hell of a lot better what it's all about than I do).
And he in turn sends them to me.

They are both maintainers. That doesn't mean that I necessarily work with
every maintainer directly.

Or look at USB: I get the USB patches from Greg, and he gets them from
various different people. Johannes Erdfelt is the maintainer for uhci.c,
and he sends them to Greg, not to me.

Why? Because having hundreds of people emailing me _obviously_ doesn't
scale. Never has, never will. It may work over short timeperiods wih lots
of energy, but it obviously isn't a stable setup.

			Linus

