Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288714AbSADSb4>; Fri, 4 Jan 2002 13:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288719AbSADSbj>; Fri, 4 Jan 2002 13:31:39 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30423 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288716AbSADSbZ>; Fri, 4 Jan 2002 13:31:25 -0500
Date: Fri, 4 Jan 2002 11:31:10 -0700
Message-Id: <200201041831.g04IVAD23320@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <3C35F290.140BB2C7@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de>
	<3C35F290.140BB2C7@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Dave Jones wrote:
> > 
> > On Fri, 4 Jan 2002, Jeff Garzik wrote:
> > 
> > > > #ifndef __KERNEL__
> > > > #error This file should not be included by userspace.
> > > > #endif
> > > I thought about it, but then the tree would be littered with that all
> > > over the place.  Programmers are smart enough to figure this out (I hope
> > > :))
> > 
> > I doubt you'd need it in that many places. A few well chosen ones should
> > probably suffice.
> 
> oh, if Linus would apply it, I would love to see the above code in
> asm/types.h or linux/kernel.h or similarly popular headers.
> 
> But...   my patch is merely a small step, a "nudge" as I mentioned.  I
> don't want to annhilate the glibc developers with a sudden task, just a
> nudge :)

Please test this change on a libc5 system before unleashing a
potential horror. All the world *is not* glibc!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
