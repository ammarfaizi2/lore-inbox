Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267948AbTBVXAq>; Sat, 22 Feb 2003 18:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbTBVXAq>; Sat, 22 Feb 2003 18:00:46 -0500
Received: from franka.aracnet.com ([216.99.193.44]:22926 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267948AbTBVXAo>; Sat, 22 Feb 2003 18:00:44 -0500
Date: Sat, 22 Feb 2003 15:10:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <1370000.1045955447@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0302221648010.2686-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, so now you've slid from talking about PCs to 2-way to 4-way ...
>> perhaps because your original arguement was fatally flawed.
> 
> oh, come on.  the issue is whether memory is fast and flat.
> most "scalability" efforts are mainly trying to code around the fact
> that any ccNUMA (and most 4-ways) is going to be slow/bumpy.

Scalability is not just NUMA machines by any stretch of the imagination.
It's 2x, 4x, 8x SMP as well.

> it is reasonable to worry that optimizations for imbalanced machines
> will hurt "normal" ones.  is it worth hurting uni by 5% to give
> a 50% speedup to IBM's 32-way?  I think not, simply because 
> low-end machines are more important to Linux.

We would never try to propose such a change, and never have. 
Name a scalability change that's hurt the performance of UP by 5%.
There isn't one.

> ccNUMA worst-case latencies are not much different from decent 
> cluster (message-passing) latencies.  getting an app to work on a cluster
> is a matter of programming will.

It's a matter of repeatedly reimplementing a bunch of stuff in userspace,
instead of doing things in kernel space once, properly, with all the
machine specific knowledge that's needed. It's *so* much easier to
program over a single OS image.

M.

