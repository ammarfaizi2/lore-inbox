Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSLEPCt>; Thu, 5 Dec 2002 10:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSLEPCt>; Thu, 5 Dec 2002 10:02:49 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:50128 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S261574AbSLEPCt>;
	Thu, 5 Dec 2002 10:02:49 -0500
Date: Thu, 5 Dec 2002 08:08:54 -0700
From: yodaiken@fsmlabs.com
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: yodaiken@fsmlabs.com, Andrew Morton <akpm@digeo.com>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021205080854.A16009@hq.fsmlabs.com>
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <20021205042312.A12616@hq.fsmlabs.com> <20021205181153.C12588@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205181153.C12588@in.ibm.com>; from dipankar@in.ibm.com on Thu, Dec 05, 2002 at 06:11:53PM +0530
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 06:11:53PM +0530, Dipankar Sarma wrote:
> > Doesn't your allocator increase chances of cache conflict on the same
> > cpu ?
> > 
> 
> You mean by increasing the footprint and the chance of eviction ? It
> is a compromise. Or you would face NR_CPUS bloat and non-NUMA-node-local 
> accesses for all CPUs outside the NUMA node where your NR_CPUS array
> is located.

What do you base the trade-off decision on?

> 
> Thanks
> -- 
> Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
> Linux Technology Center, IBM Software Lab, Bangalore, India.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
www.fsmlabs.com  www.rtlinux.com
1+ 505 838 9109

