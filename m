Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261863AbTCPBRG>; Sat, 15 Mar 2003 20:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTCPBRG>; Sat, 15 Mar 2003 20:17:06 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:36625 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S261863AbTCPBRF>; Sat, 15 Mar 2003 20:17:05 -0500
Date: Sat, 15 Mar 2003 17:27:53 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update filesystems config. menu
Message-ID: <20030316012753.GC23160@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200303150920.h2F9KGm16328@mako.theneteffect.com> <1047720287.3505.146.camel@workshop.saharact.lan> <33707.4.64.238.61.1047748124.squirrel@www.osdl.org> <20030315211151.40f1cf84.azarah@gentoo.org> <34070.4.64.238.61.1047763919.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34070.4.64.238.61.1047763919.squirrel@www.osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 01:31:59PM -0800, Randy.Dunlap wrote:
> > On Sat, 15 Mar 2003 09:08:44 -0800 (PST)
> > "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> >> I'm having trouble decoding...
> >> What is it that "should be safest for most people"?
> >> Are you suggesting any changes here?
> >>
> >> And some of us don't use fs modules, just build what we need into the
> >> kernel.  Do you know of any problems with doing this (related to ext2/ext3
> >> for example)?
> >>
> >
> > I was just saying that recommending it (ext2) compiled into the kernel and
> > not a module should be the safe route for newbies to kernel
> > compiles.
> 
> Thanks for the clarification.
> 
> > Those of us that have build a few to feel comfortable with it, will know to
> > compile the fs of our / partition into the kernel.
> >
> > Except if ext2 is not the most commonly used fs anymore.  I guess a 'cool'
> > feature could be if the make system could 'detect' what your current root is
> > and warn if you do not have that compiled into your kernel, but I do not
> > know the limitations of it (the make system).
> >
> > Then on the other hand, would above be confusing if its a kernel
> > compiled for another box ?
> 
> Yes, I'd say so, although the message could say something like:
>   Kernel does not include a filesystem for / on this computer.
> And would it also have to check the capabilities of what's in the
> initrd?  (not that I'm advocating any of this)

To me that sounds like a feature for the bootloader
config tool.  That is the first time you have a firm
kernel to rootfs connection. 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
