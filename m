Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVGVBGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVGVBGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 21:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGVBGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 21:06:18 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:47219 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261962AbVGVBGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 21:06:18 -0400
Message-ID: <42E04686.9020107@bigpond.net.au>
Date: Fri, 22 Jul 2005 11:06:14 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Matthew Helsley <matthltc@us.ibm.com>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
References: <20050715013653.36006990.akpm@osdl.org>	<20050715150034.GA6192@infradead.org>	<20050715131610.25c25c15.akpm@osdl.org>	<20050717082000.349b391f.pj@sgi.com>	<1121985448.5242.90.camel@stark> <20050721163227.661a5169.pj@sgi.com>
In-Reply-To: <20050721163227.661a5169.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 22 Jul 2005 01:06:14 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Matthew wrote:
> 
>>I don't see the large ifdefs you're referring to in -mm's
>>kernel/sched.c.
> 
> 
> Perhaps someone who knows CKRM better than I can explain why the CKRM
> version in some SuSE releases based on 2.6.5 kernels has substantial
> code and some large ifdef's in sched.c, but the CKRM in *-mm doesn't.
> Or perhaps I'm confused.  There's a good chance that this represents
> ongoing improvements that CKRM is making to reduce their footprint
> in core kernel code.  Or perhaps there is a more sophisticated cpu
> controller in the SuSE kernel.

As there is NO CKRM cpu controller in 2.6.13-rc3-mm1 (that I can see) 
the one in 2.6.5 is certainly more sophisticated :-).  So the reason 
that the considerable mangling of sched.c evident in SuSE's 2.6.5 kernel 
source is not present is that the cpu controller is not included in 
these patches.

I imagine that the cpu controller is missing from this version of CKRM 
because the bugs introduced to the cpu controller during upgrading from 
2.6.5 to 2.6.10 version have not yet been resolved.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
