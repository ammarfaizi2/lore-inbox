Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289781AbSA2Rh1>; Tue, 29 Jan 2002 12:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289783AbSA2RhR>; Tue, 29 Jan 2002 12:37:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289781AbSA2RhI>; Tue, 29 Jan 2002 12:37:08 -0500
Date: Tue, 29 Jan 2002 09:36:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Skip Ford <skip.ford@verizon.net>
cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020129143359.BBSA15035.out018.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Message-ID: <Pine.LNX.4.33.0201290914270.7701-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Jan 2002, Skip Ford wrote:
>
> Linus Torvalds wrote:
> [snip]
> > A word of warning: good maintainers are hard to find.  Getting more of
> > them helps, but at some point it can actually be more useful to help the
> > _existing_ ones.  I've got about ten-twenty people I really trust, and
>
> Then why not give the subsystem maintainers patch permissions on your tree.
> Sort of like committers.  The problem people have is that you're dropping
> patches from those ten-twenty people you trust.

No. Ask them, and they will (I bet) pretty uniformly tell you that I'm
_not_ dropping their patches (although I'm sometimes critical of them,
and will tell them that they do not get applied).

Sure, it happens occasionally that they really do get dropped, just
because I get too much email, but these people know how to re-send every
once in a while, and keep their patches separate.

I think there is some confusion about who I trust. Being listed as
MAINTAINER doesn't mean you are automatically trusted. The MAINTAINERS
list is not meant for me _at_all_ in fact, it's meant more as one of the
places for _others_ to search for a contact with.

Examples of people who I trust: Ingo Molnar, Jeff Garzik, Alan Cox, Al
Viro, David Miller, Greg KH, Andrew Morton etc. They've shown what I call
"good taste" for a long time. But it's not always a long process - some
of you may remember Bill Hawes, for example, who came out of nowhere
rather quickly.

There are other categories: Andrea, for example, is in a category all of
his own under "absolutely stunning, but sometimes somewhat erratic", which
just means that I have to think a lot more about his patches. I love his
experimentation, especially now that he maintains separate patches (and
I'd also love for him to be more active in pushing the non-experimental
parts towards me, hint hint, Andrea)

And there are categories of people who just own a big enough chunk that is
separate enough that I trust them for that area: architecture maintainers
etc tend to be here, as long as they only affect their own architecture.

But you have to realize that there are a _lot_ of people on the
maintainers list that I don't implicitly trust. And being loud and
wellknown on the mailing lists or IRC channels doesn't make them any more
trusted.

			Linus

