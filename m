Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUA2Sqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUA2Sqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:46:31 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17795 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266295AbUA2Sq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:46:29 -0500
Date: Thu, 29 Jan 2004 18:55:17 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4019472D.70604@techsource.com>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, the cost of fabricating depends on the device.  I was basically
> > thinking of a 68000, an EPROM and a SIMM on a piece of stripboard,
> > some ribbon cable and a DB-25 connector.
> > 
> > Maybe our goals are somewhat different :-)
> 
> Very different.  What you're describing is a dumb terminal.

Hardly.  It's nothing like a dumb terminal whatsoever.

It's a simple framebuffer, possibly with line drawing, and box filling
capabilities.  Nevertheless, it could be used as a general purpose X
display, for spreadsheets, simple to moderate wordprocessing,
(I.E. probably not DTP-like applications), status displays for various
systems, etc.

So, it does have real world uses.

> What I'm describing is a PC console graphics card that will let someone 
> play Quake III at a reasonable framerate.
> 
> Isn't that what most people want?

In the embedded and server markets, I don't see it being a major
requirement, actually.

Just because a standard graphics card is going to do all they want and
be cheaper to develop, doesn't make it a requirement.

> And the performance disparity between what you're describing and what 
> I'm describing is enormous!

Your arguments seem to be based on the fact that fabricating an ASIC
is out of the budget of most individuals, and that no large company
would want to develop open source graphics hardware when they can buy
$15 graphics cards.  That argument is perfectly valid, but it's
incomplete.

What _is_ within the budget of most interested individuals are things
like general purpose CPUs, generic video sync generation ICs, SIMMs.
The parallel port remains far easier to interface to than the PCI bus,
and can easily provide enough bandwidth for experimenting with simple
640x480 framebuffer graphics type applications.

So, we can either do something interesting with the above, or sit
around discussing how expensive it is to make a graphics card.

At least it provides a way for us to create the first generation of
open graphics hardware cheaply, and experiment with various ideas.

Besides, this is just the first stage - once we have the graphics
card, we can move on to other things like the 9-track tape drive
discussed on LKML a while ago:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105128749415083&w=2

John.
