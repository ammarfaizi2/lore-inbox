Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289967AbSAKOsV>; Fri, 11 Jan 2002 09:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289968AbSAKOsM>; Fri, 11 Jan 2002 09:48:12 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:11012 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289967AbSAKOsA>; Fri, 11 Jan 2002 09:48:00 -0500
Date: Fri, 11 Jan 2002 15:47:57 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
In-Reply-To: <Pine.LNX.4.33.0201111725420.3212-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0201111547020.12411-100000@banaan.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -H5 (-G1, latest I've tried worked)
> > >
> > > 1 GHz Athlon II, 640 MB
> > > hang hard right after
> > > Initializing RT netlink socket
> >
> > Look in init/main.c, if kernel_thread() is called before init_idle().
> 
> look at my patches, they have included this fix for quite some time.
> (Linus found it or me, i dont remember.) So whatever problem Dieter has,
> it's not this particular bug.

i've got the same problem (UP, athlon 500Mhz)
anything I can check/test ??

Cheers,
Taco.

