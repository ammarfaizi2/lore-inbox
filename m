Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVDFIOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVDFIOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVDFIOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:14:16 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:56447 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262073AbVDFIMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:12:14 -0400
Message-ID: <425399D9.8090301@yahoo.com.au>
Date: Wed, 06 Apr 2005 18:12:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/5] sched: remove degenerate domains
References: <425322E0.9070307@yahoo.com.au> <20050406054412.GA5853@elte.hu> <20050406001041.A24403@unix-os.sc.intel.com> <20050406071341.GA7517@elte.hu>
In-Reply-To: <20050406071341.GA7517@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> 
> 
>>Similarly I am working on adding a new core domain for dual-core 
>>systems! All these domains are unnecessary and cause performance 
>>isssues on non Multi-threading/Multi-core capable cpus! Agreed that 
>>performance impact will be minor but still...
> 
> 
> ok, lets keep it then. It may in fact simplify the domain setup code: we 
> could generate the 'most generic' layout for a given arch all the time, 
> and then optimize it automatically. I.e. in theory we could have just a 
> single domain-setup routine, which would e.g. generate the NUMA domains 
> on SMP too, which would then be optimized away.
> 

Yep, exactly. Even so, Andrew: please ignore this patch series
and I'll redo it for you when we all agree on everything.

Thanks.

-- 
SUSE Labs, Novell Inc.

