Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287720AbSA2GBo>; Tue, 29 Jan 2002 01:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288671AbSA2GBe>; Tue, 29 Jan 2002 01:01:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46602 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287720AbSA2GBU>; Tue, 29 Jan 2002 01:01:20 -0500
Date: Mon, 28 Jan 2002 22:00:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@trommello.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201282153160.10900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Rob Landley wrote:
>
> > A word of warning: good maintainers are hard to find.  Getting more of
> > them helps, but at some point it can actually be more useful to help the
> > _existing_ ones.  I've got about ten-twenty people I really trust, and
> > quite frankly, the way people work is hardcoded in our DNA.  Nobody
> > "really trusts" hundreds of people.  The way to make these things scale
> > out more is to increase the network of trust not by trying to push it on
> > me, but by making it more of a _network_, not a star-topology around me.
>
> You don't see an integration maintainer as a step in the right direction?
> (It's not a star topology, it's a tree.)

No, I don't really think an "integration manager" works well.

I think it helps a lot to have people pick up patches that nobody else
wants to maintain, and to gather them up. Andrea does that to some degree.
But it is _much_ better if you have somebody who is a point-man for
specific areas.

The problem with an overall guy is that there can't be too many of them.
The very thing you are _complaining_ about is in fact that there are a
number of over-all guys without clear focus, which only leads to confusion
about who handles what.

Clarity is good.

> Are you saying that Alan Cox's didn't serve a purpose during the 2.2 kernel
> time frame, and that Dave Jones is currently wasting his time?

No, I'm saying that there are not very many peopel who can do it, and who
can get the kind of trust that they are _everywhere_. Let's face it, Alan
grew to be respected because he did lots of different stuff over many
years, and he proved himself more than capable. And I suspect he's _quite_
happy not being in the middle of it right now.. It's a tough job.

It's a lot more likely to find people who can maintain _parts_. And if
there are patches that fall out of those parts, that tends to indicate a
lack of modularity, and perhaps a lack of maintainer for those parts.

And more likely, even if you _do_ find ten people who can do everything,
you don't want them to.

		Linus

