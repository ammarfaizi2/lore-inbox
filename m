Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbUJ1JeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbUJ1JeG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbUJ1Jcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:32:35 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:40970 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262854AbUJ1Jbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:31:52 -0400
Date: Thu, 28 Oct 2004 11:37:52 +0200
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Timothy Miller <miller@techsource.com>, Tonnerre <tonnerre@thundrix.ch>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-ID: <20041028093752.GB13523@hh.idb.hist.no>
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh> <20041025152921.GA25154@thundrix.ch> <417D216D.1060206@techsource.com> <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410251825480.16966@denise.shiny.it>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:32:27PM +0200, Giuliano Pochini wrote:
> 
> 
> On Mon, 25 Oct 2004, Timothy Miller wrote:
> 
> >
> >
> > Tonnerre wrote:
> > > Salut,
> > >
> > > On Fri, Oct 22, 2004 at 10:57:16AM +0000, Helge Hafting wrote:
> > >
> > >>24-bit color
> > >>------------
> > >
> > >
> > > Why don't you use 32-bit colors?  24-bit packed pixels are a pita, and
> > > a lot of OpenGL hardware doesn't support 24bpp. You might atcually get
> > > better graphics/performance/etc. if you  stick to 32bpp. Only that the
> > > framebuffer size increases by 1/3rd.
> >
> > It's been ages since I've encountered a GPU which could do packed 24.  I
> > think when people talk about "24 bit color", they're also thinking "32
> > bits per pixel".  Besides, there's the alpha channel.
> 
Nothing wrong with 32-bit color.  What I meant, was to
prioritize 24-bit _or better_ - don't waste space on
16-bit or even less stuff. 

> Well, in order to save memory and bandwidth, the data can be 24bpp, but
> the software sees it 32bpp.
> 
Or one could go the other way - if we use 32 bits, then
consider 10 bits per color.  I've always wondered about the purpose
of a 8-bit alpha channel.  what exactly is supposed to show
in "transparent" places?  Transparency makes sense when talking about 
windows - you see the underlying window through a transparent spot.
But this is the frame buffer we're talking about - what is
supposed to be behind that?  Another frame buffer?

> I didn't follow the whole thread, but IMHO the most important thing is 2D.
> If you like gaming, a slow 3D card is useless. I would prefer a card with
> excellent 2D features instead.

No, a slow 3D card is very useful.  Remember the original doom?  It
ran fine on a 486 with no graphichs accelerator other than the cpu
itself.  Then came games that used 3D acceleration - the early 3D
accelerators were simple stuff comparted with this year's cards.

If he can make an open card that runs most 3-year old 3D-stuff, then
great!  There is _lots_ of such programs around.  They doesn't cease
to exist, they doesn't stop getting used just because they're old.

There is a handful of opensource 3D games that works fine with
old 3D cards. There will likely be more with time too.

Games is much more than the "latest and greatest".  Don't fall
into the trap thinking that this month's top seller game is
all that counts.  People still fire up their old C64's from
time to time . . .

Also, there is the fact that the closed nature of many new 3D
cards means their potential isn't realized under linux, where
I play _all_ my games anyway.  Competing with someone who
have no driver is easy, and someone with a severely lacking driver
isn't so hard to beat either.

Helge Hafting


 
