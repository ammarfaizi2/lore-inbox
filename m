Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSGZTuC>; Fri, 26 Jul 2002 15:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318469AbSGZTuC>; Fri, 26 Jul 2002 15:50:02 -0400
Received: from holomorphy.com ([66.224.33.161]:57247 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318468AbSGZTuB>;
	Fri, 26 Jul 2002 15:50:01 -0400
Date: Fri, 26 Jul 2002 12:53:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>, Ravikiran G Thirumalai <kiran@in.ibm.com>,
       linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
       riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <20020726195304.GY2907@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>,
	riel@conectiva.com.br, Rusty Russell <rusty@rustcorp.com.au>
References: <20020726204033.D18570@in.ibm.com> <3D41990A.EDC1A530@zip.com.au> <20020726194643.GX2907@holomorphy.com> <1027713012.2443.49.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1027713012.2443.49.camel@sinai>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 11:46:34AM -0700, Andrew Morton wrote:
>>> Oh dear.  Most people only have two CPUs.
>>> Rusty, can we *please* fix this?  Really soon?

On Fri, 2002-07-26 at 12:46, William Lee Irwin III wrote:
>> I'll post the panic triggered by lowering NR_CPUS shortly. There's
>> an ugly showstopping i386 arch code issue here.

On Fri, Jul 26, 2002 at 12:50:12PM -0700, Robert Love wrote:
> In current 2.5?  I thought Andrew and I fixed all those issues and
> pushed them to Linus...
> The `configurable NR_CPUS' patch works fine for me.  I always boot with
> NR_CPUS=2.

Sorry I didn't get a chance to test in time, these things are slow to
boot and my testing bandwidth is limited. Please hold off until the
issue is resolved. You *will* prevent me from booting. IO-APIC APIC ID
reassignment panics. I'll follow up after this when the thing comes up
into the kernel exhibiting the problem.


Cheers,
Bill
