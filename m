Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280840AbRKGQWK>; Wed, 7 Nov 2001 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280841AbRKGQWA>; Wed, 7 Nov 2001 11:22:00 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:55860 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S280840AbRKGQV4>;
	Wed, 7 Nov 2001 11:21:56 -0500
Date: Wed, 7 Nov 2001 18:19:57 +0200 (EET)
From: lkml user <lk@ts.ray.fi>
To: <erik@hensema.xs4all.nl>
cc: Ricky Beam <jfbeam@bluetopia.net>, <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <20011107170836.A4782@hensema.net>
Message-ID: <Pine.LNX.4.33.0111071815030.14694-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >Heck, 95% compatibility could even be achieved using a 100% userspace app
> > >which serves the data over named pipes.
> > 
> > Screw backwards compatibilty.  Sometimes you have to cut your loses and
> > move on.  We don't want to end up like Microsoft and the whole brain-fuck
> > that is their dll world. (Yes, they knew it was stupid.  And yes, they
> > would love to abandon it, but it's far, far too late.)  We switched to ELF,
> > abandoned libc4, etc.  Add another to the pile.
> 
> It will be very, very hard for distributors to create a distribution which
> runs one the native 2.6 /proc interface as soon as 2.6 comes out. I think
> we must assume rewriting things like procps, init scripts, etc. will only
> start as soon as 2.6 comes out. We should provide some transitional period
> for userspace to adapt, but make clear to everybody that compatibility
> isn't going to last forever.

You must have forgotten about 2.5 which should serve as a transitional 
period just fine. By the time 2.6.0 is about to be released I'll be damned 
if init scripts and the rest proc related hadn't made their transition.

What was said there about making a transition for the better and M$ dlls 
aswell as ELF binary format and libc4, I'd say ditch it even if we planned
to jump from 2.4 directly to 2.6. 



