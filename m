Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTA1Gtm>; Tue, 28 Jan 2003 01:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTA1Gtl>; Tue, 28 Jan 2003 01:49:41 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16305 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264883AbTA1Gtl>; Tue, 28 Jan 2003 01:49:41 -0500
Date: Mon, 27 Jan 2003 22:58:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <884740000.1043737132@titus>
In-Reply-To: <3.0.6.32.20030127224726.00806c20@boo.net>
References: <3.0.6.32.20030127224726.00806c20@boo.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is yet another holding action, a port of my page coloring patch
> to the 2.5 kernel. This is a minimal port (x86 only) intended to get
> some testing done; once again the algorithm used is the same as in 
> previous patches. There are several cleanups and removed 2.4-isms that
> make the code somewhat more compact, though.
> 
> I'll be experimenting with other coloring schemes later this week.
> 
> www.boo.net/~jasonp/page_color-2.5.59-20030127.patch
> 
> Feedback of any sort welcome.

I took a 16-way NUMA-Q (700MHz P3 Xeon's w/2MB L2 cache) and ran some 
cpu-intensive benchmarks (kernel compile on warm cache with -j32 and
-j 256, SDET 1 - 128 users, and numaschedbench with 1 to 64 processes, 
which is a memory thrasher to test node affinity of memory operations), 
and compared to virgin 2.5.59 - no measurable difference on any test. 
Sorry,

M.

