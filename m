Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUDGWq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUDGWq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:46:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:4278 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261197AbUDGWq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:46:56 -0400
Date: Wed, 07 Apr 2004 15:58:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <12640000.1081378705@flay>
In-Reply-To: <20040406192549.GA14869@elte.hu>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> anyway, i can only repeat what i said last year in the announcement
> email of the 4:4 feature:
> 
>    the typical cost of 4G/4G on typical x86 servers is +3 usecs of
>    syscall latency (this is in addition to the ~1 usec null syscall
>    latency). Depending on the workload this can cause a typical
>    measurable wall-clock overhead from 0% to 30%, for typical
>    application workloads (DB workload, networking workload, etc.).
>    Isolated microbenchmarks can show a bigger slowdown as well - due to
>    the syscall latency increase.
> 
> so it's not like there's a cat in the bag.

I don't see how you can go by the cost in syscall latency ... the real 
cost is not the time take to flush the cache, it's the impact of doing
so .... such microbenchmarks seems pointless. I'm not against 4/4G at all,
I think it solves a real problem ... I just think latency numbers are a 
bad way to justify it - we need to look at whole benchmark runs.

M.
