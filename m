Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276545AbRJGSJB>; Sun, 7 Oct 2001 14:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJGSIl>; Sun, 7 Oct 2001 14:08:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60916 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276519AbRJGSIe>; Sun, 7 Oct 2001 14:08:34 -0400
Message-ID: <3BC099CD.9174A32@mvista.com>
Date: Sun, 07 Oct 2001 11:07:09 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: low-latency patches]
In-Reply-To: <3BBEAA2C.1005F7F4@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
>   ------------------------------------------------------------------------
> 
> Subject: Re: low-latency patches
> Date: Fri, 05 Oct 2001 23:51:55 -0700
> From: J Sloan <jjs@pobox.com>
> Organization: J S Concepts
> To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
> References: <20011006010519.A749@draal.physics.wisc.edu>
> 
> Bob McElrath wrote:
> 
> > It seems there are two low-latency projects out there.  The one by Robert Love:
> >     http://tech9.net/rml/linux/
> > and the original one:
> >     http://www.uow.edu.au/~andrewm/linux/schedlat.html
> >
> > Correct me if I'm wrong, but the former uses spinlocks to know when it can
> > preempt the kernel, and the latter just tries to reduce latency by adding
> > (un)conditional_schedule and placing it at key places in the kernel?
> >
> > My questions are:
> > 1) Which of these two projects has better latency performance?  Has anyone
> >     benchmarked them against each other?
> > 2) Will either of these ever be merged into Linus' kernel (2.5?)
> > 3) Is there a possibility that either of these will make it to non-x86
> >     platforms?  (for me: alpha)  The second patch looks like it would
> >     straightforwardly work on any arch, but the config.in for it is only in
> >     arch/i386.  Robert Love's patches would need some arch-specific asm...
> 
> In my experience with them, the Andrew Morton patches
> provide a "smoother" interactive feel, great for things like
> online gaming (quake 3 arena, etc), however the Robert
> Love patches are simpler, seem less intrusive, and I've
> had better luck with them on smp, highmem boxes.
> 
> (just IMHO) I like Andrew's patches on (up) workstations,
> and Robert's on (smp) servers, with some grey area of
> overlap -
> 
> I'm hardly the person to say, but the rml patches would
> seem more likely to go in sooner, if at all.  I'd love to see
> both remain an option.
> 
The two patches are NOT mutually exclusive.  Both can be used and are in
some cases.

MontaVista is actively working on porting the patch you refer to as
Robert Love's patch to most of the other archs.  Which arch are you
interested in?

George
