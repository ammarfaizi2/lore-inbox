Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSG1Cmt>; Sat, 27 Jul 2002 22:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSG1Cmt>; Sat, 27 Jul 2002 22:42:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318883AbSG1Cms>; Sat, 27 Jul 2002 22:42:48 -0400
Date: Sat, 27 Jul 2002 19:47:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
In-Reply-To: <20020727235726.GB26742@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0207271939220.3799-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andries Brouwer wrote:

> On Wed, Jul 24, 2002 at 06:08:48PM -0700, Linus Torvalds wrote:
>
> > Most of the IDE stuff is FUD and misinformation. I've run every single
> > 2.5.x kernel on an IDE system ("penguin.transmeta.com" has everything on
> > IDE), and the main reported 2.5.27 corruption was actually from my BK tree
> > apparently due to the IRQ handling changes.
>
> Linus, Linus, how can you say something so naive?
> I need not tell you that one user without problems does not imply
> that nobody will have problems.

That's not what I'm saying. I'm saying that there _are_ problems with IDE,
but that the real problem with IDE is that some people aren't even willing
to help despite the fact that we do have a maintainer that actually can
work with people.

I realize that so many people are probably used to the fact that IDE
maintainers do not take patches from the outside that people have kind of
given up on even working on IDE, but it doesn't help to have people only
be negative (and btw, I'm definitely not talking about you - you've been
exceedingly _positive_ in that you're still willing to test and report on
problems. I'm talking about people who don't even bother to do
bug-reports, but only trash-talk the maintenance).

> A few people reported lost filesystems. Many more reported mild
> filesystem damage. And now you also report mild filesystem damage.

No, I've not reported lost filesystems. I'm reporting that _others_
reported filesystem damage that was _not_ related to the IDE patches at
all, yet were instantly blamed on the IDE patches.

And THAT is part of the problem. I don't know why, but the IDE subsystem
brings out the worst in people.

This is, btw, one reason why I hate mid layers. People blame them for
everything, and fixing it for one setup breaks it for another.

> My third candidate is USB. Systems without USB are clearly more stable.

Hmm.. I doubt that's your problem, but you might just want to pester
Martin about your particular IDE setup and see if some light eventually
goes off somewhere.

I have this memory that you're using PIO mode? Please do make full details
available, reminding people which exact setups are broken..

		Linus

