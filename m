Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281046AbRKLWlN>; Mon, 12 Nov 2001 17:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281079AbRKLWk6>; Mon, 12 Nov 2001 17:40:58 -0500
Received: from 239-ZARA-X33.libre.retevision.es ([62.82.234.239]:56324 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S281046AbRKLWjt>;
	Mon, 12 Nov 2001 17:39:49 -0500
Message-ID: <3BEF04AC.5070305@zaralinux.com>
Date: Mon, 12 Nov 2001 00:07:24 +0100
From: Jorge Nerin <comandante@zaralinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: es-es, en-us
MIME-Version: 1.0
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
CC: David Grant <davidgrant79@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Athlon cooling
In-Reply-To: <Pine.LNX.4.33.0111081752490.2404-100000@twin.uoregon.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Jaeggli wrote:

> CONFIG_APM_CPU_IDLE
> 
> in the apm setup...
> 
> clock throttling is a subject of some debate on the linux kernel list... ;) 
> but the apm idle call will at least idle the cpu once the idle loop has 
> been running for a while.
> 
> joelja
> 
> On Thu, 8 Nov 2001, David Grant wrote:
> 
> 
>>There is a program for Windows called CPUIdle, which cools the Athlon
>>tremendoulsy.  I can get my temp. from 52C down to 36C.  It makes the CPU
>>truly go idle.  Is there anything like this for Linux, and I'm wondering if
>>anyone knows the instructions (and/or signals) which could be used to put
>>the Athlon into this state.  I guess it's more of a question for some APM
>>guys, but I thought some people here might know the interface to the Athlon,
>>and might thus know how this software cooling works.  Actually the low-level
>>apm stuff is part of the kernel right?  so maybe this is on-topic.
>>
>>http://www.cpuidle.de/
>>
>>Cheers,
>>David Grant
>>
> 

It has been discused before, it seems that the athlon needs another step 
to really enter in power saving mode, I can't remember the details, but 
I think it was a pci register, and I also remember that some people saw 
corrupts pci tranfer, namely the exact situation was grabbing with a TV 
card.

So the decision was that if this corrupted pci transfers from a tv card 
it could do the same with a pci ide controler, and that was not 
considered safe.

But you should crawl the archives for the same url.

-- 
Jorge Nerin
<comandante@zaralinux.com>

