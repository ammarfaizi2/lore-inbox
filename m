Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUA3VHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUA3VHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:07:22 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:52490 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263880AbUA3VHT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:07:19 -0500
Date: Fri, 30 Jan 2004 22:19:49 +0100
To: Timothy Miller <miller@techsource.com>
Cc: John Bradford <john@grabjohn.com>, chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Message-ID: <20040130211949.GB4147@hh.idb.hist.no>
References: <200401291211.05461.chakkerz@optusnet.com.au> <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk> <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk> <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk> <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no> <401A8E0E.6090004@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401A8E0E.6090004@techsource.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:02:06PM -0500, Timothy Miller wrote:
> 
> Helge Hafting wrote:
> 
> >>
> >I run X on an unaccelerated framebuffer (1280x1024 16bit color) every day.
> 
> This is you.  How many other people would be happy with this?
>
Depends on what they do, of course.  It _is_ fine for 2D office work,
that surprised me quite a bit. I can even use mplayer and watch
videos on this. 

Someone interested in quake will of course not be satisfied though.
> 
> >
> >So a good 2D card is trivial - a video signal generator and memory on an 
> >AGP bus.
> 
> I wouldn't call it 'good', but you're essentially correct.  Mind you, 
> you can get the latest S3 chip for $30 or less.  That's well documented, 
> a lot faster than a dumb framebuffer, and has VGA built in.
> 
> Once you get below a certain level of performance in this open-source 
> design, it's no longer worth doing because there are so many low-end 
> alternatives that blow it away.
> 
Good point.  I had the impression you weren't going for the
best performance anyway.

> A BIOS ROM doesn't help you if you don't have a VGA core, and a VGA core 
> is not a trivial piece of logic.
> 
> I like Macs, Suns, and other UNIX workstations because they don't rely 
> on this antiquated piece of logic to act as a console.  The chip I 
> designed doesn't do VGA, but that doesn't stop it from working nicely as 
> a console in a Sun.
> 
The pc doesn't need VGA anymore than a Sun does.  A pc without any vga
runs the same stuff as the sun - various unixes and no legacy dos stuff.
Don't confuse "pc" with "msdos/windows".  If the sun's software
selection satisfy you, then you're fine on a pc/x86 without vga (or other
legacy hw) too.

[...]
> 
> My knowledge of 3D graphics is limited to linear algebra and mostly pure 
> theory, but I do have SOME clue as to what existing 3D engines are like. 
>    The issue of general purpose CPU's versus GPU's has been discussed 
> on the web at nauseum, and for what they do, modern GPU's are an order 
> of magnitude faster than CPU's at what they do.  And they're less expensive!
>

Seems the solution is to get one of those general purpose GPU's
instead, and build the card around that.  Not entirely open hw,
but _fully documented_ with no hidden surprises.

Helge Hafting
