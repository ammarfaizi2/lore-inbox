Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288706AbSADSM0>; Fri, 4 Jan 2002 13:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSADSMQ>; Fri, 4 Jan 2002 13:12:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288710AbSADSMK>;
	Fri, 4 Jan 2002 13:12:10 -0500
Message-ID: <3C35F073.54E89624@mandrakesoft.com>
Date: Fri, 04 Jan 2002 13:12:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <Pine.LNX.4.33.0201041858400.20620-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Fri, 4 Jan 2002, Jeff Garzik wrote:
> 
> > As we are now in 2.5.x series I figured it might be a good time to push
> > this out...  The patch removes __KERNEL__ ifdefs from [only] io.h as a
> > nudge to userspace that they should not be including kernel headers.
> 
> Why not..
> 
> #ifndef __KERNEL__
> #error This file should not be included by userspace.
> #endif

I thought about it, but then the tree would be littered with that all
over the place.  Programmers are smart enough to figure this out (I hope
:))

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
