Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263963AbSITXUo>; Fri, 20 Sep 2002 19:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSITXUn>; Fri, 20 Sep 2002 19:20:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39900 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263963AbSITXUn>; Fri, 20 Sep 2002 19:20:43 -0400
Date: Fri, 20 Sep 2002 16:22:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <231070000.1032564140@flay>
In-Reply-To: <20020920231126.GN3530@holomorphy.com>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com> <68810000.1032557423@flay> <20020920231126.GN3530@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> AFAICT, with one bottleneck out of the way, a new one merely arises to
>>> take its place. Ugly. OTOH the qualitative difference is striking. The
>>> interactive responsiveness of the machine, even when entirely unloaded,
>>> is drastically improved, along with such nice things as init scripts
>>> and kernel compiles also markedly faster. I suspect this is just the
>>> wrong benchmark to show throughput benefits with.
> 
> On Fri, Sep 20, 2002 at 02:30:23PM -0700, Martin J. Bligh wrote:
>> Hmmm ... I think you need the NUMA aware scheduler ;-) 
>> On the plus side, that does look like RCU pretty much obliterated the dcache
>> problems ....
> 
> This sounds like a likely solution to the expense of load_balance().
> Do you have a patch for it floating around?

I have a really old hacky one from Mike Kravetz, or Michael Hohnbaum
is working on something new, but I don't think it's ready yet .... 
I think Mike's will need some rework. Will send it to you ...

M.

