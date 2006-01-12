Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWALC0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWALC0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWALC0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:26:37 -0500
Received: from smtp-out.google.com ([216.239.45.12]:41074 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932676AbWALC0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:26:36 -0500
Message-ID: <43C5BE4A.9030105@google.com>
Date: Wed, 11 Jan 2006 18:26:18 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601121218.47744.kernel@kolivas.org> <43C5B0F6.5090500@bigpond.net.au> <200601121236.07522.kernel@kolivas.org> <43C5BD8F.3000307@bigpond.net.au>
In-Reply-To: <43C5BD8F.3000307@bigpond.net.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Con Kolivas wrote:
> 
>> On Thu, 12 Jan 2006 12:29 pm, Peter Williams wrote:
>>
>>> Con Kolivas wrote:
>>>
>>>> This is a shot in the dark. We haven't confirmed 1. there is a 
>>>> problem 2.
>>>> that this is the problem nor 3. that this patch will fix the problem.
>>>
>>>
>>> I disagree.  I think that there is a clear mistake in my original patch
>>> that this patch fixes.
>>
>>
>>
>> I agree with you on that. The real concern is that we were just about 
>> to push it upstream. So where does this leave us?  I propose we delay 
>> merging the
>> "improved smp nice handling" patch into mainline pending your further 
>> changes.
> 
> 
> I think that they're already in 2.6.15 minus my "move load not tasks" 
> modification which I was expecting to go into 2.6.16.  Is that what you 
> meant?
> 
> If so I think this is a small and obvious fix that shouldn't delay the 
> merging of "move load not tasks" into the mainline.  But it's not my call.

BTW, in reference to a question from last night ... -git7 seems fine. So
if you merged it already, it wasn't that ;-)

M.
