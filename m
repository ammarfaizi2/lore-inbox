Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbRLaAUN>; Sun, 30 Dec 2001 19:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285812AbRLaAUE>; Sun, 30 Dec 2001 19:20:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23056 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285783AbRLaATz>; Sun, 30 Dec 2001 19:19:55 -0500
Date: Sun, 30 Dec 2001 16:19:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <200112302117.fBULHISr011887@svr3.applink.net>
Message-ID: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Dec 2001, Timothy Covell wrote:
>
> 	When X11 locks up, I can still kill it and my box lives.  When
> framebuffers crash, their is no recovery save rebooting.  Back in 1995
> I thought that linux VTs and X11 implemenation blew Solaris out of the
> water, and now we want throw away our progress?  I'm still astounded
> by the whole "oooh I can see  a penquin while I boot-up" thing?
> Granted, frame buffers have usage in embedded systems, but do they
> really have to be so deeply integrated??

They aren't.

No sane person should use frame buffers if they have the choice.

Like your mama told you: "Just say no". Use text-mode and X11, and be
happy.

Some people don't have the choice, of course.

		Linus

