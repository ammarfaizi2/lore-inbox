Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282400AbSADSWq>; Fri, 4 Jan 2002 13:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288711AbSADSWc>; Fri, 4 Jan 2002 13:22:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S282914AbSADSVM>;
	Fri, 4 Jan 2002 13:21:12 -0500
Message-ID: <3C35F290.140BB2C7@mandrakesoft.com>
Date: Fri, 04 Jan 2002 13:21:04 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.5.2.7: io.h cleanup and userspace nudge
In-Reply-To: <Pine.LNX.4.33.0201041916490.20620-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Fri, 4 Jan 2002, Jeff Garzik wrote:
> 
> > > #ifndef __KERNEL__
> > > #error This file should not be included by userspace.
> > > #endif
> > I thought about it, but then the tree would be littered with that all
> > over the place.  Programmers are smart enough to figure this out (I hope
> > :))
> 
> I doubt you'd need it in that many places. A few well chosen ones should
> probably suffice.

oh, if Linus would apply it, I would love to see the above code in
asm/types.h or linux/kernel.h or similarly popular headers.

But...   my patch is merely a small step, a "nudge" as I mentioned.  I
don't want to annhilate the glibc developers with a sudden task, just a
nudge :)

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
