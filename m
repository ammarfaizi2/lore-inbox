Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbSADSSg>; Fri, 4 Jan 2002 13:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282690AbSADSSQ>; Fri, 4 Jan 2002 13:18:16 -0500
Received: from ns.suse.de ([213.95.15.193]:15109 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281916AbSADSSF>;
	Fri, 4 Jan 2002 13:18:05 -0500
Date: Fri, 4 Jan 2002 19:18:05 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <3C35F073.54E89624@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Jeff Garzik wrote:

> > #ifndef __KERNEL__
> > #error This file should not be included by userspace.
> > #endif
> I thought about it, but then the tree would be littered with that all
> over the place.  Programmers are smart enough to figure this out (I hope
> :))

I doubt you'd need it in that many places. A few well chosen ones should
probably suffice.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

