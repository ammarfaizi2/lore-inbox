Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJQBc0>; Tue, 16 Oct 2001 21:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJQBcG>; Tue, 16 Oct 2001 21:32:06 -0400
Received: from ljbc.wa.edu.au ([203.59.143.14]:55540 "HELO gamma.ljbc")
	by vger.kernel.org with SMTP id <S273619AbRJQBcB>;
	Tue, 16 Oct 2001 21:32:01 -0400
Date: Wed, 17 Oct 2001 09:32:12 +0800 (WST)
From: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: <rwhron@earthlink.net>, <linux-kernel@vger.kernel.org>,
        <ltp-list@lists.sourceforge.net>
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
In-Reply-To: <20011017021242.S2380@athlon.random>
Message-ID: <Pine.LNX.4.30.0110170920350.18794-100000@gamma.student.ljbc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001, Andrea Arcangeli wrote:

> On Tue, Oct 16, 2001 at 08:16:39AM -0400, rwhron@earthlink.net wrote:
> >
> > Summary:
> >
> > Wall clock time for this test has dropped dramatically (which
> > is good) over the last 3 Andrea Arcangeli patched kernels.
>
> :) I worked the last two days to make it faster under swap, it's nice to
> see that your tests also confirm that.  I'm only scared it swaps too
> much when swap is not used but if this sorts out to be the case it will
> be very easy to fix. And a very minor bit of very seldom background
> pagetable scanning shouldn't hurt anyways. So far on my desktop it seems
> not to swap too much.

Swapping too much probably has a lot to do with a particular hard drive
and its performace. Is there any way of adding a configurable option (via
sysctl) to allow the adminstrators to tune how aggressively the kernel
swaps out data/vs throwing out the disk cache (so if it is set to
agressive, the kernel will try hard to make sure to use swap to free up
memory, or if it is set to conservative it will try to free disk cache (to
a limit) instead of swapping stuff out to free memory)

Beau Kuiper
kuib-kl@ljbc.wa.edu.au


