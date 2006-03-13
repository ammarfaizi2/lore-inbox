Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932507AbWCMXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbWCMXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCMXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:16:56 -0500
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:58571 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932507AbWCMXQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:16:56 -0500
Message-ID: <4415FD66.4090708@bigpond.net.au>
Date: Tue, 14 Mar 2006 10:16:54 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
References: <200603131906.11739.kernel@kolivas.org> <4415F49C.8020208@bigpond.net.au> <cone.1142290371.837084.5853.501@kolivas.org>
In-Reply-To: <cone.1142290371.837084.5853.501@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 13 Mar 2006 23:16:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Peter Williams writes:
> 
>> Con Kolivas wrote:
>>
>>> +unsigned long weighted_cpuload(const int cpu)
>>> +{
>>> +    return (cpu_rq(cpu)->raw_weighted_load);
>>> +}
>>> +
>>
>>
>> Wouldn't this be a candidate for inlining?
> 
> 
> That would make it unsuitable for exporting via sched.h.

Right, no cpu_rq() out there.

Sorry, for the noise,
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
