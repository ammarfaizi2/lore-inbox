Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263770AbSITVaM>; Fri, 20 Sep 2002 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263810AbSITVaL>; Fri, 20 Sep 2002 17:30:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:16037 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263770AbSITVaE>;
	Fri, 20 Sep 2002 17:30:04 -0400
Date: Fri, 20 Sep 2002 14:30:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <68810000.1032557423@flay>
In-Reply-To: <20020920120358.GV28202@holomorphy.com>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AFAICT, with one bottleneck out of the way, a new one merely arises to
> take its place. Ugly. OTOH the qualitative difference is striking. The
> interactive responsiveness of the machine, even when entirely unloaded,
> is drastically improved, along with such nice things as init scripts
> and kernel compiles also markedly faster. I suspect this is just the
> wrong benchmark to show throughput benefits with.
> 
> Also notable is that the system time was significantly reduced though
> I didn't log it. Essentially a long period of 100% system time is
> entered after a certain point in the benchmark, during which there are
> few (around 60 or 70) context switches in a second, and the duration
> of this period was shortened.
> 
> The results here contradict my prior conclusions wrt. HZ 100 vs. 1000.

Hmmm ... I think you need the NUMA aware scheduler ;-) 
On the plus side, that does look like RCU pretty much obliterated the dcache
problems ....

M.


