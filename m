Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288707AbSADSBG>; Fri, 4 Jan 2002 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288702AbSADSA4>; Fri, 4 Jan 2002 13:00:56 -0500
Received: from ns.suse.de ([213.95.15.193]:21523 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288704AbSADSAl>;
	Fri, 4 Jan 2002 13:00:41 -0500
Date: Fri, 4 Jan 2002 19:00:38 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <3C35EAAF.17636C6E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201041858400.20620-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201041858402.20620@Appserv.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Jeff Garzik wrote:

> As we are now in 2.5.x series I figured it might be a good time to push
> this out...  The patch removes __KERNEL__ ifdefs from [only] io.h as a
> nudge to userspace that they should not be including kernel headers.

Why not..

#ifndef __KERNEL__
#error This file should not be included by userspace.
#endif

?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

