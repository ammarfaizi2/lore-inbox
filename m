Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310615AbSCHAZO>; Thu, 7 Mar 2002 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310612AbSCHAZF>; Thu, 7 Mar 2002 19:25:05 -0500
Received: from air-2.osdl.org ([65.201.151.6]:50182 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S310614AbSCHAYy>;
	Thu, 7 Mar 2002 19:24:54 -0500
Date: Thu, 7 Mar 2002 16:24:49 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Scott L. Burson" <gyro@zeta-soft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Performance issue on dual Athlon MP
In-Reply-To: <E16j7Yh-0004CL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L2.0203071622320.23254-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Alan Cox wrote:

| > BTW, this doesn't seem like a preemption issue, considering that throughput
| > is very definitely affected as well as latency.
| >
| > Anyway, please let me know if there's anything I can do, within my
| > constraints, to help.  (As you can guess, though, I don't have any kernel
| > debugging experience.)
|
| It sounds like the hit you are taking is from highmem and I/O (having to
| copy pages lower into memory so the I/O subsystem can use them). Some of
| that is in the hard to fix for 2.4 category with the x86. There are some
| experimental patches around but they are experimental.
| -

I don't recall what kernel version you are using..?

Andrea now maintains the block-highmem 2.4 patches.
Latest is available at:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa1/
and file:  00_block-highmem-all-18b-5.gz

If you can apply this patch, I'd be interested in the results.

-- 
~Randy

