Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287542AbRLaPfG>; Mon, 31 Dec 2001 10:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287543AbRLaPe5>; Mon, 31 Dec 2001 10:34:57 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:46610 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S287542AbRLaPet>;
	Mon, 31 Dec 2001 10:34:49 -0500
Date: Mon, 31 Dec 2001 08:03:37 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Timothy Covell <timothy.covell@ashavan.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <Pine.LNX.4.33.0112301618310.1011-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0112310757510.26107-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Dec 2001, Linus Torvalds wrote:

> Date: Sun, 30 Dec 2001 16:19:15 -0800 (PST)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: Timothy Covell <timothy.covell@ashavan.org>
> Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
>      Linux Frame Buffer Device Development
>     <linux-fbdev-devel@lists.sourceforge.net>,
>      Marcelo Tosatti <marcelo@conectiva.com.br>
> Subject: Re: [patch] Re: Framebuffer...Why oh Why???
> 
> 
> On Sun, 30 Dec 2001, Timothy Covell wrote:
> >
> > 	When X11 locks up, I can still kill it and my box lives.  When
> > framebuffers crash, their is no recovery save rebooting.  Back in 1995
> > I thought that linux VTs and X11 implemenation blew Solaris out of the
> > water, and now we want throw away our progress?  I'm still astounded
> > by the whole "oooh I can see  a penquin while I boot-up" thing?
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
> 
> 		Linus

Like the no choice if having one's 11 year old syster try to use the
thing?

Text-mode and X11 seem to work fine if you walk on egg shells but just try
switching from console to text mode and back again several
times.  Eventually it _will_ crash.  Or worse yet mix svgalib and X11.

My brother and sister both used to crash my system at least 3 times a week  
before framebuffer + fbdev came into play.

	Gerhard



 



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

