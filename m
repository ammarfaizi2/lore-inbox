Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263946AbSITXMd>; Fri, 20 Sep 2002 19:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263951AbSITXMd>; Fri, 20 Sep 2002 19:12:33 -0400
Received: from holomorphy.com ([66.224.33.161]:41354 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263946AbSITXMc>;
	Fri, 20 Sep 2002 19:12:32 -0400
Date: Fri, 20 Sep 2002 16:11:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920231126.GN3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com> <20020920120358.GV28202@holomorphy.com> <68810000.1032557423@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <68810000.1032557423@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> AFAICT, with one bottleneck out of the way, a new one merely arises to
>> take its place. Ugly. OTOH the qualitative difference is striking. The
>> interactive responsiveness of the machine, even when entirely unloaded,
>> is drastically improved, along with such nice things as init scripts
>> and kernel compiles also markedly faster. I suspect this is just the
>> wrong benchmark to show throughput benefits with.

On Fri, Sep 20, 2002 at 02:30:23PM -0700, Martin J. Bligh wrote:
> Hmmm ... I think you need the NUMA aware scheduler ;-) 
> On the plus side, that does look like RCU pretty much obliterated the dcache
> problems ....

This sounds like a likely solution to the expense of load_balance().
Do you have a patch for it floating around?


Thanks,
Bill
