Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTAJSt6>; Fri, 10 Jan 2003 13:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTAJS2g>; Fri, 10 Jan 2003 13:28:36 -0500
Received: from [193.158.237.250] ([193.158.237.250]:19848 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265786AbTAJS0S>; Fri, 10 Jan 2003 13:26:18 -0500
Date: Fri, 10 Jan 2003 19:34:20 +0100
Message-Id: <200301101834.h0AIYKY03757@mail.intergenia.de>
To: William Lee Irwin III <wli@holomorphy.com>
From: Brian Tinsley <btinsley@emageon.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>William Lee Irwin III wrote:
>  
>
>>>IMHO multiprogramming is as valid a use for memory as any other. Or
>>>even otherwise, it's not something I care to get in design debates
>>>about, it's just how the things are used.
>>>      
>>>
>
>On Thu, Jan 09, 2003 at 09:42:06PM -0600, Brian Tinsley wrote:
>  
>
>>I agree with the philosophy in general, but if I sit down to write a 
>>threaded application for Linux on IA-32 and wind up with a design that 
>>uses 800+ threads in any instance (other than a bug, which was our 
>>case), it's time to give up the day job and start riding on the back of 
>>the garbage truck ;)
>>    
>>
>
>I could care less what userspace does: mechanism, not policy. Userspace
>wants, and I give if I can, just as the kernel does with system calls.
>
>800 threads isn't even a high thread count anyway, the 2.5.x testing
>was with a peak thread count of 100,000. 800 threads, even with an 8KB
>stack, is no more than 6.4MB of lowmem for stacks and so shouldn't
>stress the system unless many instances of it are run.
>
I understand your perspective here. I won't get into application design 
issues as it is far out of context from this list.

>I suspect your issue is elsewhere. I'll submit accounting patches for Marcelo's and/or Andrea's trees so you can find out what's actually going on.
>
Much appreciated! I look forward to it.


>On Thu, Jan 09, 2003 at 09:42:06PM -0600, Brian Tinsley wrote:
>  
>
>>In all honesty, I would enjoy nothing more than contributing to kernel 
>>development. Unfortunately it's a bit out of my scope right now (but not forever). If I only believed aliens seeded our gene pool with clones, I could hook up with those folks that claim to have cloned a human and get one of me made! ;)
>>    
>>
>
>I don't know what to tell you here. I'm lucky that this is my day job
>and that I can contribute so much. However, there are plenty who
>contribute major changes (many even more important than my own) without
>any such sponsorship. Perhaps emulating them would satisfy your wish.
>
It would!

I cannot say thanks enough for the efforts of you and everyone else out 
there. Frankly, I would not have my day job and would not have been able 
to make Emageon what it is today were it not for you all!

Oh, please excuse the stupid humor tonight. I'm in a giddy mood for some 
reason. Must be the excitement from the prospect of getting resolution 
to this problem!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

