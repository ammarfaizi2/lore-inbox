Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSA3BdO>; Tue, 29 Jan 2002 20:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSA3BdF>; Tue, 29 Jan 2002 20:33:05 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38290
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287858AbSA3Bct>; Tue, 29 Jan 2002 20:32:49 -0500
Message-Id: <200201300131.g0U1VsU22963@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        ebiederm@xmission.com (Eric W. Biederman),
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 20:33:03 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com> <m1wuy1cn0w.fsf@frodo.biederman.org> <E16Vi1x-0000Aw-00@starship.berlin>
In-Reply-To: <E16Vi1x-0000Aw-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 06:51 pm, Daniel Phillips wrote:
> On January 29, 2002 02:19 pm, Eric W. Biederman wrote:
> > So the kernel maintainership becomes a network of maintainers.  Then
> > we only have to understand the routing protocols.  Currently the
> > routing tables appear to have Linus as the default route.  As there
> > are currently kernel subsystems that do not have a real maintainer, it
> > may reasonable to have a misc maintainer.  Who looks after the
> > orphaned code, rejects/ignores patches for code that does have
> > active maintainers, and looks for people to be maintainers of the
> > orphaned code.
> >
> > The key is having enough human to human protocol that there is someone
> > besides Linus you can send your code to.  Or at least when there isn't
> > people are looking for someone.
> >
> > Free Software obtains a lot of it's value by many people scratching an
> > itch and fixing a little bug, or adding a little feature, sending the
> > code off and then they go off to something else.  We need to have the
> > maintainer routing protocol clear enough, and the maintainer coverage
> > good enough so we can accumulate most of the bug fixes from the fly by
> > night hackers.
> >
> > So does anyone have any good ideas about how to build up routing
> > tables?  And almost more importantly how to make certain we have good
> > maintainer coverage over the entire kernel?
>
> Yes, we should cc our patches to a patchbot:
>
>   patches-2.5@kernel.org -> goes to linus
>   patches-2.4@kernel.org -> goes to marcello
>   patches-usb@kernel.org -> goes to gregkh, regardless of 2.4/2.5
>   etc.
>
> The vast sea of eyeballs will do the rest.  A web interface would be a nice
> bonus, but 'patch sent and seen to be sent, to whom, when, what, why' is
> the essential ingredient.

And of course there's not much point in having patches go to that list that 
AREN'T public (um, they're for inclusion into a public tree, right)?  So the 
patchbot might as well distribute to a mailing list, as long as there's some 
variety of moderation (possibly just a procmail recipe) to delete everything 
that didn't actually have a patch in it.  (Yet another discussion list is 
unlikely to help matters too much.)

Of course this still doesn't address the problem of patches going stale if 
they're not applied for a version or two and something else that goes in 
breaks them...

Rob
