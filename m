Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTE1WBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTE1WBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:01:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56068 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261241AbTE1WBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:01:08 -0400
Date: Wed, 28 May 2003 18:08:31 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70 compile error
In-Reply-To: <4060000.1054072761@[10.10.2.4]>
Message-ID: <Pine.LNX.3.96.1030528180246.21414A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Martin J. Bligh wrote:

> >  > > What the hell am I supposed to enter here?  This is just friggin ugly
> >  > > and un-readable.  It should be cleaned up.
> >  > I agree and I already fixed this here, so with the next update this will 
> >  > look like this:
> >  > 
> >  > Subarchitecture Type
> >  > > 1. PC-compatible (X86_PC)
> >  >   2. Voyager (NCR) (X86_VOYAGER)
> >  >   3. NUMAQ (IBM/Sequent) (X86_NUMAQ)
> >  >   4. Summit/EXA (IBM x440) (X86_SUMMIT)
> >  >   5. Support for other sub-arch SMP systems with more than 8 CPUs (X86_BIGSMP)
> >  >   6. SGI 320/540 (Visual Workstation) (X86_VISWS)
> >  >   7. Generic architecture (Summit, bigsmp, default) (X86_GENERICARCH) (NEW)
> >  > choice[1-7]: 
> >  > 
> >  > This has other advantages too, one can see now which options were newly 
> >  > added and the individual help texts are accessible.
> > 
> > Given that 99% of users will be choosing option 1, it might be a
> > good thing to have the remaining options only shown if a
> > CONFIG_X86_SUBARCHS=y and have things default to option 1 if =n.
> 
> Please, not more layered config options! That just makes people who
> want to enable the x440 or other alternative platform require fair
> amounts of psychic power (maybe this can be fixed with a big fat help
> message, but so can the current method).

You have one good idea here, leaving the output unreadable is not it. I
was going to suggest a readable menu but someone beat me to it, it's the
obvious choice for this much stuuf, rather than one (usually folded) line.
>
> If you're going hide the other options away so much, then the default
> should be the generic arch, IMHO.

Not *that* is the good idea! A nice multiple choice menu with a note to
leave alone unless you have a clue is the right way to do it, but the
default should be what's most likely to work.

You will not get people to leave it alone by making it unreadable, you
will just confust the shit out of them by letting them see such detail if
they don't go looking for it. IMHO of course.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

