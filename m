Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317023AbSGSUkB>; Fri, 19 Jul 2002 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSGSUkB>; Fri, 19 Jul 2002 16:40:01 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13527 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317023AbSGSUkA>;
	Fri, 19 Jul 2002 16:40:00 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D3875D4.3090102@us.ibm.com>
References: <3D3875D4.3090102@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 19 Jul 2002 13:40:42 -0700
Message-Id: <1027111243.1269.94.camel@dyn9-47-17-90.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 10:31 am, Martin J. Bligh wrote:
> > Do you think the breakdown is realistic?
>
> Here's a list of other things I am hoping to see merged:
>
> shared pagetables
> large page support
> NUMA aware multipath IO
> NUMA aware scheduler extensions
> ia32 discontigmem support for NUMA machines
> NUMA aware slab allocator
> CONFIG_NONLINEAR (in some form, quite possibly a cut down version)
> shared pagetables
> large page support
> rcu rtcache
> rcu dcache

The work for the mentioned NUMA items is quite active.  Some of
the pieces have already been submitted and others are near completion.
I would hope that the items mentioned by Martin make it into the 2.5
kernel.  The NUMA changes tend to be very easy to isolate such that 
they only affect kernels built with the appropriate NUMA config options.

>From my list of NUMA items:

NUMA memory allocation
NUMA aware scheduler
Topology representation in kernel
Memory binding API
Per-zone swapd
Multipath support

Also, not NUMA specific but beneficial to databases (which tend to
run on NUMA platforms) is a fast user space gettimeofday capability.
This shows up in the AMD-64 port as vsyscalls.

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

