Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286631AbRL0Unp>; Thu, 27 Dec 2001 15:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286646AbRL0Unf>; Thu, 27 Dec 2001 15:43:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286631AbRL0UnX>; Thu, 27 Dec 2001 15:43:23 -0500
Date: Thu, 27 Dec 2001 12:41:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <20011227123344.H25698@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0112271236120.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Larry McVoy wrote:
> > >
> > > Huh.  I'm not sure I understand this.  Once you accept a patch into the
> > > mainline source, are these people still supposed to maintain that patch?
> >
> > [Linus stuff]
>
> But this didn't answer my question at all.  My question was why is this a
> problem related to a source management system?  I can see how to exactly
> mimic what described Al doing in BK so if that is the definition of goodness,
> the addition (or absence) of a SCM doesn't seem to change the answer.

Ok, I see what you are asking for.

No, I'm taking a bigger view. A patch is not just a "patch". A patch has a
lot of stuff around it, one being the unknowable information on whether
the sender of the patch is somebody who will do a good job maintaining the
things the patch impacts.

That's something a source control system doesn't give you - but that
doesn't mean that you cannot use a SCM as a tool anyway.

> I _think_ what you are saying is that an SCM where your repository is a
> wide open black hole with no quality control is a problem, but that's
> not the SCM's fault.  You are the filter, the SCM is simply an accounting/
> filing system.

Right. But that's true only if I use SCM as a _personal_ medium, which
doesn't help my external patch acceptance.

So even if I used CVS or BK internally, that's not what people _gripe_
about.  People want write access, not just a SCM.

> but your typical SCM has the end user doing the merges, not the maintainer.
> If you had an SCM system which allowed the maintainer to do all or some of
> the merging, would that help?

Well, that's what the filesystem is for me right now ;)

		Linus

