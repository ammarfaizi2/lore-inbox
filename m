Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVAGQgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVAGQgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVAGQgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:36:42 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:20412 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261507AbVAGQef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:34:35 -0500
Subject: Re: starting with 2.7
From: "M. Edward Borasky" <znmeb@cesmail.net>
Reply-To: znmeb@cesmail.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105045853.17176.273.camel@localhost.localdomain>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
	 <41DD9968.7070004@comcast.net>
	 <1105045853.17176.273.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 08:34:31 -0800
Message-Id: <1105115671.12371.38.camel@DreamGate>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-06 at 21:29 +0000, Alan Cox wrote:
> On Iau, 2005-01-06 at 20:02, John Richard Moser wrote:
> > experiments have no place in production; if your "stable" mainline
> > branch is going to continuously add and remove features and go through
> > wild API and functionality changes, nobody is going to want to use it.
> > Mozilla doesn't support IE's broken crap "because IE is a moving
> > target."  Unpredictable API changes and changes to the deep inner
> 
> IE hasn't moved in years. The inventiveness of the bad web page authors
> might be unbounded 8)
> 
> > workings of the kernel will make the kernel "a moving target."  If
> > that's the route you take, it will become too difficult for people to
> > develope for linux.
> 
> Its also impossible to do development if none of the changes you make
> get into the kernel for stability reasons ever. Its a double edged
> sword. For most end users it is about distribution kernels not the base.

There are two classes of "end users". There are true end users who get
their Linux from a distributor, and there are the distributors. And
there are two classes of distributors, for-profit and not-for-profit.
Somehow the Linux kernel has managed to meet enough of the needs of
enough of these folks that GNU/Linux is one of the top three desktop
operating systems in the world. I'm not sure where it ranks among
servers, but surely it's competitive with Windows on Intel-based
servers, if not with the "native" UNIX derivatives on other hardware.

I use Red Hat (mix of 8.0, 9.0 and RHEL) at work and Gentoo at home. I
recently migrated all my home systems to Gentoo's version of 2.6.10, did
the devfs-udev, oss-alsa, 2.4 headers-2.6 headers, and ntpl migration.
As far as Gentoo is concerned, this is a stable, production
environment. 

I had a few glitches; it's not something I'd expect someone without
extensive system programming experience to pull off, even with Gentoo's
well-written HowTos. As far as *I'm* concerned, it is a stable
production environment. I would recommend it to my friends (knowing that
I could bail them out if they messed it up :). I would recommend it to
businesses (knowing that I could earn big bucks to bail them out when
they messed it up. :).

Given all that, what about 2.6 and 2.7? Here's where I break away from
the mainstream -- big-time. I'd like to see 2.6 live forever as the
"stable general purpose kernel of choice for multiple architectures"
that it is today. And I'd like to see the broad "kernel community" move
to a 64-bit-only microkernel-based "GNU/Whatever". 

There's just too many hacks, patches, band-aids, etc., in the address
space on 32-bit architectures. Just about everybody *has* a 64-bit
address space available, and the performance penalities that drove Linus
away from microkernels have, to my knowledge, been resolved.

Which microkernel? Well ... I'm sure there are people here who are more
expert than I am. The one that appeals to me the most is the Dresden
Real-Time Operating System/L4 line, which, in fact, can support Linux
2.4 and 2.6 on 32-bit architectures as a "bonus". 64 bit is the future
-- I expect to have a 64-bit machine operating by summer, although it's
not clear to me whether it will be AMD64 or PPC64 at this point, and
it's not clear to me whether the OS will be Gentoo GNU/Linux or
Macintosh OS X. I'm really intrigued with the thought of a G5
dual-booted; I've had a lot of fun with Windows/Linux dual-boot machines
over the years. :)


