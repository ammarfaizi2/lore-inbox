Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286150AbRLaBzG>; Sun, 30 Dec 2001 20:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286153AbRLaBzA>; Sun, 30 Dec 2001 20:55:00 -0500
Received: from www.transvirtual.com ([206.14.214.140]:36370 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S286150AbRLaByt>; Sun, 30 Dec 2001 20:54:49 -0500
Date: Sun, 30 Dec 2001 17:54:15 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Linux-fbdev-devel] Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10112301751120.20136-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Granted, frame buffers have usage in embedded systems, but do they
> > really have to be so deeply integrated??
> 
> They aren't.
> 
> No sane person should use frame buffers if they have the choice.
> 
> Like your mama told you: "Just say no". Use text-mode and X11, and be
> happy.
> 
> Some people don't have the choice, of course.

Some. Try pretty much every platform except ix86. Plus now that M$ doesn't
support DOS you are starting to see graphics card manufactures dropping
VGA support. Even BIOS setup interfaces use the VESA graphics interface
these days. So VGA text days are numbered. I agree the framebuffer/console
layer really needs to reworked to do the right things. I plan to do that
for 2.5.X. 

