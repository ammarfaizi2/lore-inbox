Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVDFPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVDFPkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 11:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDFPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 11:40:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:46466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbVDFPkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 11:40:10 -0400
Date: Wed, 6 Apr 2005 08:42:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel SCM saga..
Message-ID: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 as a number of people are already aware (and in some cases have been
aware over the last several weeks), we've been trying to work out a
conflict over BK usage over the last month or two (and it feels like
longer ;). That hasn't been working out, and as a result, the kernel team
is looking at alternatives.

[ And apparently this just hit slashdot too, so by now _everybody_ knows ]

It's not like my choice of BK has been entirely conflict-free ("No,
really? Do tell! Oh, you mean the gigabytes upon gigabytes of flames we
had?"), so in some sense this was inevitable, but I sure had hoped that it
would have happened only once there was a reasonable open-source
alternative. As it is, we'll have to scramble for a while.

Btw, don't blame BitMover, even if that's probably going to be a very
common reaction. Larry in particular really did try to make things work
out, but it got to the point where I decided that I don't want to be in
the position of trying to hold two pieces together that would need as much
glue as it seemed to require.

We've been using BK for three years, and in fact, the biggest problem
right now is that a number of people have gotten very very picky about
their tools after having used the best. Me included, but in fact the
people that got helped most by BitKeeper usage were often the people
_around_ me who had a much easier time merging with my tree and sending
their trees to me.

Of course, there's also probably a ton of people who just used BK as a
nicer (and much faster) "anonymous CVS" client. We'll get that sorted out,
but the immediate problem is that I'm spending most my time trying to see
what the best way to co-operate is.

NOTE! BitKeeper isn't going away per se. Right now, the only real thing
that has happened is that I've decided to not use BK mainly because I need
to figure out the alternatives, and rather than continuing "things as
normal", I decided to bite the bullet and just see what life without BK
looks like. So far it's a gray and bleak world ;)

So don't take this to mean anything more than it is. I'm going to be
effectively off-line for a week (think of it as a normal "Linus went on a
vacation" event) and I'm just asking that people who continue to maintain
BK trees at least try to also make sure that they can send me the result
as (individual) patches, since I'll eventually have to merge some other
way.

That "individual patches" is one of the keywords, btw. One thing that BK 
has been extremely good at, and that a lot of people have come to like 
even when they didn't use BK, is how we've been maintaining a much finer- 
granularity view of changes. That isn't going to go away. 

In fact, one impact BK ha shad is to very fundamentally make us (and me in
particular) change how we do things. That ranges from the fine-grained
changeset tracking to just how I ended up trusting submaintainers with
much bigger things, and not having to work on a patch-by-patch basis any
more. So the three years with BK are definitely not wasted: I'm convinced 
it caused us to do things in better ways, and one of the things I'm 
looking at is to make sure that those things continue to work.

So I just wanted to say that I'm personally very happy with BK, and with 
Larry. It didn't work out, but it sure as hell made a big difference to 
kernel development. And we'll work out the temporary problem of having to 
figure out a set of tools to allow us to continue to do the things that BK 
allowed us to do.

Let the flames begin.

		Linus

PS. Don't bother telling me about subversion. If you must, start reading
up on "monotone". That seems to be the most viable alternative, but don't
pester the developers so much that they don't get any work done. They are
already aware of my problems ;)
