Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSIOT1y>; Sun, 15 Sep 2002 15:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSIOT1y>; Sun, 15 Sep 2002 15:27:54 -0400
Received: from crack.them.org ([65.125.64.184]:22030 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318234AbSIOT1x>;
	Sun, 15 Sep 2002 15:27:53 -0400
Date: Sun, 15 Sep 2002 15:32:23 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@arcor.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020915193223.GA22800@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@arcor.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Brownell <david-b@pacbell.net>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <E17qen4-00008R-00@starship> <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209151220360.1393-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 12:26:02PM -0700, Linus Torvalds wrote:
> 
> On Sun, 15 Sep 2002, Daniel Phillips wrote:
> > 
> > I use UML all the time.  It's great, but it doesn't work for SMP debugging.
> 
> That should not be something fundamental, though. It should be perfectly 
> doable with threading. "SMOP".

I run into problems fairly often that I can't reproduce in UML - timing
sensitive, hardware sensitive, etc.  Some of them KGDB perturbs too
much to be useful, but most of the time I can get it to work.  UML also
doesn't use a lot of the code under arch/i386/ (or didn't at least)
which makes debugging that code under UML a bit futile.

> Yeah, and gdb (not to mention all the grapical nice stuff) sucks in a
> threaded environment. At least it used to. 

Well, yeah.  It's getting a little bit better - a lot better for some
cases - but no one's really sure where it needs to go to keep
improving.  I'm making a little progress.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
