Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVDFH4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVDFH4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDFH4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:56:51 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:30068 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262139AbVDFHyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:54:06 -0400
Message-ID: <42539595.6050509@yahoo.com.au>
Date: Wed, 06 Apr 2005 17:53:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 3/5] sched: multilevel sbe and sbf
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au> <20050406055409.GA5973@elte.hu>
In-Reply-To: <20050406055409.GA5973@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> note that no matter how much scheduler logic, in the end 
> cross-scheduling of tasks between nodes on NUMA will always have a 
> permanent penalty (i.e. the 'migration cost' is 'infinity' in the long 
> run), so the primary focus _hast to be_ on 'get it right initially' When 
> tasks must spill over to other nodes will always remain a special case.  
> So balance-on-fork/exec/[clone] definitely needs to be aware of the full 
> domain tree picture.
> 

Yes, well put. I imagine this will only become more important as
there becomes more push towards multiprocessing machines, and the
need for higher memory bandwidth and lower latency to CPUs.


-- 
SUSE Labs, Novell Inc.

