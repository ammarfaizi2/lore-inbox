Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129869AbQKFRlQ>; Mon, 6 Nov 2000 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129923AbQKFRlG>; Mon, 6 Nov 2000 12:41:06 -0500
Received: from underdog.barkingdogstudios.com ([206.186.109.131]:5892 "EHLO
	underdog.barkingdogstudios.com") by vger.kernel.org with ESMTP
	id <S129869AbQKFRkr>; Mon, 6 Nov 2000 12:40:47 -0500
Date: Mon, 6 Nov 2000 12:40:26 -0500 (EST)
From: Michael Vines <mjvines@undergrad.math.uwaterloo.ca>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Catalin BOIE <util@deuroconsult.ro>, linux-kernel@vger.kernel.org
Subject: Re: Kernel hook for open
In-Reply-To: <20001106182059.G12348@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10011061234230.12539-100000@barkingdogstudios.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Erik Mouw wrote:

> On Mon, Nov 06, 2000 at 10:11:11AM -0500, Michael Vines wrote:
> > On Mon, 6 Nov 2000, Erik Mouw wrote:
> > > Use LD_PRELOAD instead.
> > 
> > You could also write a simple kernel module that replaces the open system
> > call.  See the Linux Kernel Module Programming Guide for details. 
> > http://www.linuxdoc.org/guides.html
> > 
> > specifically http://www.linuxdoc.org/LDP/lkmpg/node20.html
> 
> Why difficult when it can be done easy? To test the Y2K readiness of
> some programs (yeah, Y2K, remember?), I wrote a small library that
> overloaded the time() and gettimeofday() syscalls in about 100 lines of
> code.  No kernel modules needed, no root privileges needed, just set the
> environment variable LD_PRELOAD and off you go.

Well the question was posted to the kernel mailing list and not the glibc
mailing list after all :)

	Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
