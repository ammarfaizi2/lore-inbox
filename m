Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSA2NVd>; Tue, 29 Jan 2002 08:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSA2NVY>; Tue, 29 Jan 2002 08:21:24 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62924 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289236AbSA2NVO>;
	Tue, 29 Jan 2002 08:21:14 -0500
Date: Tue, 29 Jan 2002 16:18:39 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VY5z-0003sn-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201291603520.7176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Alan Cox wrote:

> Ingo, you should have a look at my mailbox and the people sick of
> trying to get Linus to take 3 liners to fix NODEV type stuff and being
> ignored so that 2.5.* still doesn't even compile or boot for many
> people.

for code areas where there is not active maintainer or the maintainer has
ignored patches? Eg. the majority of the kdev transition patches went in
smoothly.

but i'm not claiming that everything is rosy (i would post patches if
everything was rosy in Linux-land), but i disagree with the majority of
serious examples i've seen cited.

> Dave in doing the patch hoovering at least ensures these are picked
> up. You think if this carries on anyone will be running Linus tree in
> 9 months ?

Dave and you doing patch hoovering is indeed very good. One reason is that
it multithreads the introduction of more risky stuff (by splitting up the
testing effort), and builds up confidence in more complex patches. This is
especially important in the stable cycle - eg. it happened not once that
had eg. some APIC cleanup that was too risky to be added to the stable
branch, and which went into your branch and lived a few iterations (got a
few bugreports) and then went to Linus.

Obviously you wont apply all the complex patches at once - i remember that
occasionally you delayed certain patches of mine because something else
was happening in your tree at that monent. You are simply doing
*different* transitions, but you are constrained by the same basic limits
as Linus' tree is.

Another reason is that you do much more housekeeping in areas that are not
actively maintained. But wouldnt it be better if there were active
maintainers in those areas as well so you could spend more time on eg.
doing the kernel-stack coloring changes?

but i truly believe that for the hard issues there is no solution, and
that most of the patch rejects are due to hard issues.

	Ingo

