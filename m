Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSFCKGI>; Mon, 3 Jun 2002 06:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSFCKGH>; Mon, 3 Jun 2002 06:06:07 -0400
Received: from adsl-203-134.38-151.net24.it ([151.38.134.203]:7931 "EHLO
	morgana.systemy.it") by vger.kernel.org with ESMTP
	id <S317345AbSFCKGH>; Mon, 3 Jun 2002 06:06:07 -0400
Date: Mon, 3 Jun 2002 12:05:58 +0200
From: Alessandro Rubini <rubini@gnu.org>
To: andersen@codepoet.org, karim@opersys.com, linux-kernel@vger.kernel.org,
        rpm@idealx.com
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Message-ID: <20020603120558.A29441@morgana.systemy.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Free Lance in Pavia, Italy.
In-Reply-To: <20020603095202.GA16392@codepoet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It still looks to me like a real time operating system
> (Adeos) running real time and non-real time tasks with a general
> purpose operating system as one of the non-real time tasks...

But the point is exactly that adeos is not a real-time operating
system.  It is not an operating system at all.

Besides, adeos is not a "circumvention device" to run RT-and-non-RT at
the same time.  It's a nano-kernel meant to run several independent OS's
at once, as well as kernel debuggers and a lot of other stuff. Did you
notice Karim is the author and maintainer of the linux trace toolkit?

> Could you summarize (for non-lawyers such as myself) how this
> bypasses the claims in the patent?  

I'll quote the patent for you:

   A process for [...]  providing a general purpose operating system as
   one of the non-real time tasks; preempting the general purpose
   operating system as needed for the real time tasks; and preventing the
   general purpose operating system from blocking preemption of the
   non-real time tasks.

Nothing of this is in adeos. And nothing of this will be in the
adeosized RTAI.

/alessandro, living in a swpat-free country (with other problems, though :)
