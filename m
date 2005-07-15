Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263277AbVGOMoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbVGOMoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbVGOMoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 08:44:09 -0400
Received: from mail.tmr.com ([64.65.253.246]:31418 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S263277AbVGOMnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 08:43:09 -0400
Message-ID: <42D7B100.2010308@tmr.com>
Date: Fri, 15 Jul 2005 08:50:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
References: <200507122110.43967.kernel@kolivas.org> <200507122202.39988.kernel@kolivas.org> <42D55562.3060908@tmr.com> <200507141021.55020.kernel@kolivas.org>
In-Reply-To: <200507141021.55020.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>On Thu, 14 Jul 2005 03:54, Bill Davidsen wrote:
>  
>
>>Con Kolivas wrote:
>>    
>>
>>>On Tue, 12 Jul 2005 21:57, David Lang wrote:
>>>      
>>>
>>>>for audio and video this would seem to be a fairly simple scaleing factor
>>>>(or just doing a fixed amount of work rather then a fixed percentage of
>>>>the CPU worth of work), however for X it is probably much more
>>>>complicated (is the X load really linearly random in how much work it
>>>>does, or is it weighted towards small amounts with occasional large
>>>>amounts hitting? I would guess that at least beyond a certin point the
>>>>liklyhood of that much work being needed would be lower)
>>>>        
>>>>
>>>Actually I don't disagree. What I mean by hardware changes is more along
>>>the lines of changing the hard disk type in the same setup. That's what I
>>>mean by careful with the benchmarking. Taking the results from an athlon
>>>XP and comparing it to an altix is silly for example.
>>>      
>>>
>>I'm going to cautiously disagree. If the CPU needed was scaled so it
>>represented a fixed number of cycles (operations, work units) then the
>>effect of faster CPU would be shown. And the total power of all attached
>>CPUs should be taken into account, using HT or SMP does have an effect
>>of feel.
>>    
>>
>
>That is rather hard to do because each architecture's interpretation of fixed 
>number of cycles is different and this doesn't represent their speed in the 
>real world. The calculation when interbench is first run to see how many 
>"loops per ms" took quite a bit of effort to find just how many loops each 
>different cpu would do per ms and then find a way to make that not change 
>through compiler optimised code. The "loops per ms" parameter did not end up 
>being proportional to cpu Mhz except on the same cpu type.
>
>  
>
>>Disk tests should be at a fixed rate, not all you can do. That's NOT
>>realistic.
>>    
>>
>
>Not true; what you suggest is another thing to check entirely, and that would 
>be a valid benchmark too. What I'm interested in is what happens if you read 
>or write a DVD ISO image for example to your hard disk and what this does to 
>interactivity. This sort of reading or writing is not throttled in real life.
>

Of course it is. At least the read. It's limited to the speed needed to 
either play (watch) the image or to burn it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

