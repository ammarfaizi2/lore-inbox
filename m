Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270499AbUJTX5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270499AbUJTX5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbUJTXzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:55:22 -0400
Received: from web40706.mail.yahoo.com ([66.218.78.163]:6970 "HELO
	web40706.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270499AbUJTXsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:48:25 -0400
Message-ID: <20041020234819.23232.qmail@web40706.mail.yahoo.com>
Date: Wed, 20 Oct 2004 16:48:19 -0700 (PDT)
From: Timothy Miller <theosib@yahoo.com>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm posting from home, so this won't look right.  Sorry.

Anyhow, Andre Eisenbach said this:

>>>
If the graphics card mostly supports 2D initially, it's really not
much better then just about any off the shelf graphics card with VESA
drivers. As in, the hardware doesn't need to be open for just that.
Most (all?) the frustration in Linux graphics card land comes from
unsupported/closed 3D drivers.
<<<

I have tried using cards with VESA drivers before, and I found it to be
very painful.  Certainly, you can turn off certain features and get a
reasonably useful UI experience, but dragging windows around with "show
window contents while moving" enabled is painfully slow, even with AGP
4x.  Just imagine doing it over PCI.

When it comes to desktop applications, the FIRST thing you need is good
2D acceleration.  In fact, that's really the ONLY thing.  OpenOffice
does not need to use OpenGL.  GNOME doesn't need to use OpenGL.  In
fact, for the most part, they don't bother.  There are some instances
where they use OpenGL, but most of what a workstation user does fits
squarely within all the functionality supplied by Xlib, which is
entirely 2D.

Ok, so with limited 3D support, it's almost not worth trying to play
Doom II (let alone III), but that's never affected me.  On Linux, I use
nedit, Mozilla, GNOME, KDE... ALL 2D apps.  I use Linux as a
development platform for chip logic, X server modules, and web sites. 
I also do a fair amount of tinkering with CPU-intensive things like
genetic algorithms.  In fact, the ONLY time I have EVER played with 3D
on Linux was when I fiddled with some of the screensavers.

Ok, so I'm really limited in my use.  But what about what a secretary
would use?  GNOME, OpenOffice, Evolution, Mozilla.  All 100% 2D apps. 
How about a sysadmin?  Well, he wants something simple in his server
that lets him run his Red Hat configuration tools.  What's a system
integrator want?  Something that won't result in any tech-support
calls.

Nevertheless, I do think 3D is very important.  MacOS has moved to pure
3D, and Longhorn's Aero Glass thingy is all 3D too.  Plus there's that
Sun thing.  With Linux, we're kinda constrained by the fact that core
X11 protocol is strictly 2D, but soon, GNOME and KDE will surely find a
way around that too.  I know we could not sell a graphics device which
did not have ANY 3D support.  But keep in mind that the more
sophistocated the 3D support, the larger an FPGA you'll need.  The
prices of FPGA's go up exponentially with die area.

I've been given a very limited budget here for development.  (Well, I
haven't been given a budget yet--I've just been told that we're not
going to spend $100K to do an ASIC for something this speculative.) 
I'm further constrained by the impact of FPGA chip cost on the end
product.

Here's an off-the-cuff guess as to the parts cost for one board (I'm
sure I have most of the prices wrong):

- FPGA             $30
- PCB               $5
- DAC              $10
- DVI transmitter  $10
- RAM              $20
- Assembly         $??
- Development cost $??
- Profit           $??

The parts alone are $75, and I've left plenty out.  If the board is
profitable at $100... who will buy it?

I'll do whatever anyone wants, as long as it fits into these
constraints!!

One idea I have is to merge the 2D and 3D pipelines into one.  This
way, we can get better 3D functionality, and 2D comes in for free.  The
problem is that 2D performance would be a LOT slower in this case.  But
forget I said that, because it's absolutely pointless to talk
implementation details at this point.  

The whole issue comes down to this:  This is technically feasible. 
Should we do it?


The open source community often complains about hardware vendors being
too tight-lipped with their IP.  Here, we have a golden opportunity to
get what we want, both in terms of features and disclosure.  How do we
figure out how to not miss that opportunity?


In case you're wondering why I'm writing so much about this... it's
because I REALLY REALLY REALLY want to do this.  As a geek who enjoys
designing stuff, this is an exciting idea to me.  I'm also a free
software zealot, but I often feel like a leech because I haven't given
anything back (well, there's GTerm, but who cares.).  I just don't know
how to justify the cost of this project to my employer.




		
__________________________________
Do you Yahoo!?
Take Yahoo! Mail with you! Get it on your mobile phone.
http://mobile.yahoo.com/maildemo 
