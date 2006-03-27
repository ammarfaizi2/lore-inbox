Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWC0XQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWC0XQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWC0XQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:16:21 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57729 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751093AbWC0XQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:16:20 -0500
Date: Tue, 28 Mar 2006 01:15:57 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Mark Lord <lkml@rtr.ca>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: regular swsusp flamewar [was Re: [PATCH] swsusp: separate swap-writing/reading code]
Message-ID: <20060327231557.GB2439@elf.ucw.cz>
References: <200603231702.k2NH2OSC006774@hera.kernel.org> <442325DA.80300@rtr.ca> <20060327102636.GH14344@elf.ucw.cz> <200603272044.05431.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603272044.05431.ncunningham@cyclades.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you want faster suspend, that should be easy. You'll need *current*
> > 2.6.16-git , and userland tools from suspend.sf.net . There's HOWTO
> > that explains how to set it up. We can even do LZF these days...
> >
> > > >Currently I'm not working on any better solution.  If you can provide
> > > > any patches to implement one, please submit them, but I think they'll
> > > > have to be
> > > >tested for as long as this code, in -mm.
> > >
> > > It would be *really nice* if you guys could stop being so underhandedly
> > > nasty in every single reply to anything from Nigel.
> > >
> > > He really is trying to help, you know.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> > Actually Rafael was *very* nice at him, I'd say. Pointing for tiny
> > inefficiencies, without patch attached is not really helpful.
...
> > I have repeatedly pointed him on ways how he can *really* help. There
> > are ways to do suspend2 in userspace these days, but Nigel refuses to
> > use them.
> 
> You know that I disagree that doing suspend in userspace is the
> right 

You know "disagreeing" with subsystem maintainer (and everyone else
for that matter) is not exactly helpful in getting patches merged. You
are free to believe whatever you want, but if you disagree on
something as fundamental as "do not put unneccessary code to kernel"
with me, it should be no surprise that I "disagree" with your patches
(*).

> approach, and you know that current uswsusp can't do everything Suspend2 does 
> without further substantial modification. Please stop painting me as the bad 
> guy because I won't roll over and play dead for you. Please also
> stop 

I'm not trying to paint you as a bad guy. But Mark said you are trying
to help, and in that context I'd read it as "trying to help mainline
development". And you are not doing that, you are developing your own
suspend2 branch, that has nothing to do with mainline. I think we can
agree on that one...

> encouraging people to use uswsusp when you have also warned that it might eat 
> their partitions.

uswsusp is now reasonably stable. Of course, it was dangerous some
time ago. Every software is dangerous when it is young.
								Pavel

(*) Actually I can't "disagree" with your patches because you did not
submit any, in recent history.
-- 
Picture of sleeping (Linux) penguin wanted...
