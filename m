Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbULGRwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbULGRwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbULGRwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:52:31 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:58381 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261869AbULGRwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:52:30 -0500
Message-ID: <41B5EDB1.4040708@mrv.com>
Date: Tue, 07 Dec 2004 19:51:45 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <20041204175636.GA3115@elte.hu> <41B5C038.1090501@mrv.com> <20041207153720.GA20712@elte.hu>
In-Reply-To: <20041207153720.GA20712@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Eran Mann <emann@mrv.com> wrote:
> 
> 
>>On my machine, disabling CONFIG_LATENCY_TRACE causes the kernel to
>>stop reporting preempt latencies. After
>>
>># echo 1 > /proc/sys/kernel/preempt_max_latency
>>
>>/proc/sys/kernel/preempt_max_latency always shows 1 no matter what
>>load is on the machine. I´ve seen this behavior since the first time I
>>tried to disable CONFIG_LATENCY_TRACE, around V0.7.31.something.
> 
> indeed - there was a thinko in trace_stop_sched_switched() that likely
> caused this problem. Does the -32-8 patch (freshly uploaded) work better
> for you?
> 
> 	Ingo

V0.7.32-9 works fine. Thanks.
	Eran.
