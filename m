Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWCWWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWCWWGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422711AbWCWWGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:06:11 -0500
Received: from omta04ps.mx.bigpond.com ([144.140.83.156]:52399 "EHLO
	omta04ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932391AbWCWWGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:06:09 -0500
Message-ID: <44231BCE.4030006@bigpond.net.au>
Date: Fri, 24 Mar 2006 09:06:06 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: kernel@kolivas.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: cpu scheduler merge plans
References: <20060322155122.2745649f.akpm@osdl.org> <1143068226.4421d6424ecf1@vds.kolivas.org> <20060322173754.A19085@unix-os.sc.intel.com>
In-Reply-To: <20060322173754.A19085@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 23 Mar 2006 22:06:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Mar 23, 2006 at 09:57:06AM +1100, kernel@kolivas.org wrote:
> 
>>Quoting Andrew Morton <akpm@osdl.org>:
>>
>>>#
>>># "strange load balancing problems": pwil3058@bigpond.net.au
>>>sched-new-sched-domain-for-representing-multi-core.patch
>>>sched-fix-group-power-for-allnodes_domains.patch
>>>x86-dont-use-cpuid2-to-determine-cache-info-if-cpuid4-is-supported.patch
> 
> 
> I'd like to see the three above patches in 2.6.17. Peters "strange load
> balancing problems" seems to be a false alarm(this patch will have
> minimal impact on a single core cpu because of domain degeneration..) and
> doesn't happen on recent -mm kernels..

I agree.  This is no longer a problem and certainly shouldn't prevent 
the above patches going in to 2.6.17.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
