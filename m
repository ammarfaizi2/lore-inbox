Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267868AbUHZInK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267868AbUHZInK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUHZIkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:40:22 -0400
Received: from gizmo06bw.bigpond.com ([144.140.70.41]:52200 "HELO
	gizmo06bw.bigpond.com") by vger.kernel.org with SMTP
	id S267971AbUHZIjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:39:35 -0400
Message-ID: <412DA1C3.6020505@bigpond.net.au>
Date: Thu, 26 Aug 2004 18:39:31 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040826023028.39690.qmail@web13926.mail.yahoo.com> <412D4E01.7000504@bigpond.net.au>
In-Reply-To: <412D4E01.7000504@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> spaminos-ker@yahoo.com wrote:
> 
>> --- Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>>> You could try Lee Revell's (rlrevell@joe-job.com) latency measuring 
>>> patches and also try applying Ingo Molnar's (mingo@elte.hu) 
>>> voluntary-preempt patches.
>>>
>>> Peter
>>
>>
>>
>> I tried 2.6.8.1 with voluntary-preempt-2.6.8.1-P9 and I am getting 
>> latency
>> messages, they trigger at around the same time I get "delta = 3" 
>> messages.
>>
>> I guess that there is no way to have the latency reporting work with 
>> the zaphod
>> patch?
> 
> 
> I'll see what I can do and let you know.

A (gzipped) combined ZAPHOD and P9 voluntary preempt patch for 2.6.8.1 
is available at:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8.1-zaphod-vp-v5.0.1.gz?download>

This patch has had minimal testing so use with care and please let me 
know if there are any problems.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

