Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267985AbUHYQAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267985AbUHYQAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUHYQAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:00:53 -0400
Received: from mail4.utc.com ([192.249.46.193]:59332 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S267985AbUHYQAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:00:50 -0400
Message-ID: <412CB78F.9020000@cybsft.com>
Date: Wed, 25 Aug 2004 11:00:15 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Scott Wood <scott@timesys.com>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P9
References: <20040823221816.GA31671@yoda.timesys>	 <20040824061459.GA29630@elte.hu>  <412C04DB.9000508@cybsft.com> <1093404161.5678.12.camel@krustophenia.net>
In-Reply-To: <1093404161.5678.12.camel@krustophenia.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2004-08-24 at 23:17, K.R. Foley wrote:
> 
>>Ingo Molnar wrote:
>>
>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P9
>>>
> 
> 
>>latency trace of ~148 usec in scsi_request? I don't know if this is real 
>>or not. Note the 79 usec here:
>>
>>00000001 0.107ms (+0.079ms): sd_init_command (scsi_prep_fn)
>>
>>Entire trace is here:
>>
>>http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace7.txt
>>
>>
>>Is this possible? This is not the first time I have seen this. There is 
>>another one here:
>>
>>http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace5.txt
>>
> 
> 
> This looks like a real latency.  What is
> /sys/block/sdX/queue/max_sectors_kb set to?  Does lowering it help?
> 
> Lee
> 
> 
Well I had no sooner sent the last message and another one of these 
popped up. This one is 123 usec:

http://www.cybsft.com/testresults/2.6.8.1-P9/latency_trace12.txt

kr
