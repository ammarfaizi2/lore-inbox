Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbSADSUg>; Fri, 4 Jan 2002 13:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282400AbSADSUR>; Fri, 4 Jan 2002 13:20:17 -0500
Received: from waste.org ([209.173.204.2]:15030 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S281780AbSADSUF>;
	Fri, 4 Jan 2002 13:20:05 -0500
Date: Fri, 4 Jan 2002 12:19:38 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <3C35F073.54E89624@mandrakesoft.com>
Message-ID: <Pine.LNX.4.43.0201041218050.23365-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Jeff Garzik wrote:

> Dave Jones wrote:
> >
> > On Fri, 4 Jan 2002, Jeff Garzik wrote:
> >
> > > As we are now in 2.5.x series I figured it might be a good time to push
> > > this out...  The patch removes __KERNEL__ ifdefs from [only] io.h as a
> > > nudge to userspace that they should not be including kernel headers.
> >
> > Why not..
> >
> > #ifndef __KERNEL__
> > #error This file should not be included by userspace.
> > #endif
>
> I thought about it, but then the tree would be littered with that all
> over the place.  Programmers are smart enough to figure this out (I hope
> :))

You can put it in config.h or the like where it gets included by everyone.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

