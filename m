Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293103AbSBWFu4>; Sat, 23 Feb 2002 00:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293102AbSBWFur>; Sat, 23 Feb 2002 00:50:47 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:15849 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293101AbSBWFuj>; Sat, 23 Feb 2002 00:50:39 -0500
Date: Fri, 22 Feb 2002 22:50:32 -0700
Message-Id: <200202230550.g1N5oWd10802@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Justin Piszcz <war@starband.net>,
        linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.3 vs gcc-3.0.4
In-Reply-To: <3C77270A.1CBA02E8@zip.com.au>
In-Reply-To: <3C771D29.942A07C2@starband.net>
	<20020222204456.O11156@work.bitmover.com>
	<3C77270A.1CBA02E8@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Larry McVoy wrote:
> > 
> > Try 2.72, it's almost twice as fast as 2.95 for builds.  For BK, at least,
> > we don't see any benefit from the slower compiler, the code runs the same
> > either way.
> > 
> 
> Amen.
> 
> I want 2.7.2.3 back, but it was the name:value struct initialiser
> bug which killed that off.  2.91.66 isn't much slower than 2.7.x,
> and it's what I use.
> 
> "almost twice as fast"?  That means that 2.7.2 vs 3.x is getting
> up to a 3x difference.  Does anyone know why?

I'm less concerned about compilation speed than the fact that gcc
2.95.3 generates buggy code. User-space code that used to work with
gcc 2.7.2 and egcs 1.1.2 now doesn't. Blech.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
