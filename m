Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTA1QkY>; Tue, 28 Jan 2003 11:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTA1QkY>; Tue, 28 Jan 2003 11:40:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:24018 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267431AbTA1QkW>; Tue, 28 Jan 2003 11:40:22 -0500
Date: Tue, 28 Jan 2003 08:49:34 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>
cc: jasonp@boo.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <1498630000.1043772571@titus>
In-Reply-To: <p73k7gpz0vu.fsf@oldwotan.suse.de>
References: <3.0.6.32.20030127224726.00806c20@boo.net.suse.lists.linux.kernel> <884740000.1043737132@titus.suse.lists.linux.kernel> <20030128071313.GH780@holomorphy.com.suse.lists.linux.kernel> <1466000000.1043770007@titus.suse.lists.linux.kernel> <p73k7gpz0vu.fsf@oldwotan.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The main advantage of cache coloring normally is that benchmarks 
> should get stable results. Without it a benchmark result can vary based on 
> random memory allocation patterns.
> 
> Just having stable benchmarks may be worth it.

OK, I'll try to hack the scripts to measure standard deviation between runs
as well.

> I suspect the benefit will vary a lot based on the CPU. Your caches may
> have good enough associativity. On other CPUs it may make much more difference.

IIRC, P3's are 4 way associative ... people had been saying that this would
make more of a difference on machines with larger caches, which is why I ran
it ... 2Mb is fairly big for ia32. 

M.

