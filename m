Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284195AbRLRQwa>; Tue, 18 Dec 2001 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283009AbRLRQwV>; Tue, 18 Dec 2001 11:52:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280410AbRLRQwI>; Tue, 18 Dec 2001 11:52:08 -0500
Date: Tue, 18 Dec 2001 08:50:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011218020456.A11541@redhat.com>
Message-ID: <Pine.LNX.4.33.0112180843510.2867-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Benjamin LaHaise wrote:
> On Mon, Dec 17, 2001 at 10:10:30PM -0800, Linus Torvalds wrote:
> > > Well, we've got serious chicken and egg problems then.
> >
> > Why?
>
> The code can't go into glibc without syscall numbers being reserved.

It sure as hell can.

And I'll bet $5 USD that glibc wouldn't take the patches anyway before
the kernel interfaces are _tested_.

> I've posted the code, there are people playing with it.  I can't make them
> comment.

Well, if people aren't interested, then it doesn't _ever_ go in.

Remember: we do not add features just because we can.

Quite frankly, I don't think you've told that many people. I haven't seen
any discussion about the aio stuff on linux-kernel, which may be because
you posted several announcements and nobody cared, or it may be that
you've only mentioned it fleetingly and people didn't notice.

Take a look at how long it took for ext3 to be "standard" - I put them in
my tree when I started getting real feedback that it was used and people
liked using it. I simply do not like applying patches "just to get users".
Not even reservations - because I reserve the right to _never_ apply
something if critical review ends up saying that "that doesn't make
sense".

Quite frankly, the fact that it is being tested out at places like Oracle
etc is secondary - those people will use anything. That's proven by
history. That doesn't mean that _I_ accept anything.

Now, the fact that I like the interfaces is actually secondary - it does
make me much more likely to include it even in a half-baked thing, but it
does NOT mean that I trust my own taste so much that I'd do it "under the
covers" with little open discussion, use and modification.

Where _is_ the discussion on linux-kernel?

Where are the negative comments from Al? (Al _always_ has negative
comments and suggestions for improvements, don't try to say that he also
liked it unconditionally ;)

		Linus

