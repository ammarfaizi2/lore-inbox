Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRHBTLZ>; Thu, 2 Aug 2001 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268688AbRHBTLF>; Thu, 2 Aug 2001 15:11:05 -0400
Received: from w146.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.146]:27304 "EHLO
	windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S268598AbRHBTK7>; Thu, 2 Aug 2001 15:10:59 -0400
Date: Thu, 2 Aug 2001 12:10:25 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@heat.gghcwest.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.3.95.1010802144823.4472A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33.0108021206570.21298-100000@heat.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Richard B. Johnson wrote:

> On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
>
> > This just in: Linux 2.4 VM still useless.
> >
> > I have 2 GB main memory and 4GB swap on a 2-way intel machine running a
> > variety of 2.4 kernels (we upgrade every time we have to reboot), and we
> > have to power cycle the machine weekly because too much memory usage + too
> > much disk I/O == thrash for hours.
> >
> > Gosh, I guess it is silly to use all of the available RAM and I/O
> > bandwidth on my machines.  My company will just go out of their way to
> > do less work on smaller sets of data.
> >
>
> Are you sure it's not just come user-code with memory leaks? I use
> 2.4.1 on an embeded system with no disks, therefore no swap. It does
> large FFT arrays to make spectrum-analyzer pictures and it has never
> seen any problems with VM, in fact never any problems that can be
> blamed on the Operating System.
>
> Try 2.4.1 and see if your problems go away. If not, you probably
> have user-mode leakage.

My process are not small.  They are huge.  They take up nearly all
available memory.  And then when a lot of file I/O kicks in, they get
swapped out in favor of RAM, then the thrashing starts, and the box goes
to la la land.

Are you saying that I can expect any userland process to be able to take
the box down?  Shit, why don't I just go back to DOS?

-jwb

