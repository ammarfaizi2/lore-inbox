Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTAEE7e>; Sat, 4 Jan 2003 23:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTAEE7d>; Sat, 4 Jan 2003 23:59:33 -0500
Received: from holomorphy.com ([66.224.33.161]:25040 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262812AbTAEE7c>;
	Sat, 4 Jan 2003 23:59:32 -0500
Date: Sat, 4 Jan 2003 21:07:55 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rewritten page coloring for 2.4.20 kernel
Message-ID: <20030105050755.GH9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <3.0.6.32.20030104233111.007ed3c0@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20030104233111.007ed3c0@boo.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 11:31:11PM -0500, Jason Papadopoulos wrote:
> Hello. After a year in stasis, I've completely rebuilt my kernel
> patch that implements page coloring. Improvements include:
> - Page coloring is now hardwired into the kernel. The hash
>   queues now use bootmem, and page coloring is always on. The
>   patch still creates /proc/page_color for statistics, but that
>   will go away in time.
> - Automatic detection of external cache size on many architectures.
>   I have no idea if any of this code works, since I don't have any
>   of the target machines. The preferred way to initialize the coloring
>   is by passing "page_color=<external cache size in kB>" as a boot 
>   argument.
> - NUMA-safe, discontig-safe
> Right now the actual page coloring algorithm is the same as in previous
> patches, and performs the same. In the next few weeks I'll be trying new
> ideas that will hopefully reduce fragmentation and increase performance.
> This is an early attempt to get some feedback on mistakes I may have made.

Any chance for a 2.5.x-mm port? This is a bit feature-ish for 2.4.x.


Thanks,
Bill
