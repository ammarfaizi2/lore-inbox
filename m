Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRHCLkS>; Fri, 3 Aug 2001 07:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbRHCLkJ>; Fri, 3 Aug 2001 07:40:09 -0400
Received: from gw.framfab.dk ([194.239.251.2]:40216 "HELO [194.239.251.2]")
	by vger.kernel.org with SMTP id <S268940AbRHCLjy>;
	Fri, 3 Aug 2001 07:39:54 -0400
Message-ID: <3B6A8CEC.1010401@fugmann.dhs.org>
Date: Fri, 03 Aug 2001 13:37:16 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010628
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Paul G. Allen" <pgallen@randomlogic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon, AGP, and PCI
In-Reply-To: <3B691B85.368D1BD0@randomlogic.com> <3B6939BA.30001@fugmann.dhs.org> <3B693D6F.AD0DB931@randomlogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul G. Allen wrote:

> Anders Peter Fugmann wrote:
[SNIP]
>>I have an UP system with the AMD761 chipset.
>>
> 
> The AMD762 has a different ID and is not recognized (the 761 is 7006,
> and 762 is 700c), which throws a small wrench into things.


I'm not shure why. You stated that AGPGART worked with the 
try_unsopported=1 parameter (and that you had hacked the code to accept 
it anyways).


>>
>>(try look in NVIDIA_kernel-1.0-1251/os-registry.c for more parameters)
>>
> 
> I'll take a look, again after the project Database is rebuilt. (Without
> "Understand for C++" I'd still be quite lost looking through all this
> code!)


You do not need C experience to look at that code. It just states all 
possible module parameters in C form, and has a comment to them all.

> 
> 
>>It works like a charm on my machine.
>>
>>Btw, if you want to make the NVidia module devfs aware please let me
>>know and I'll send you a patch.
>>
> 
> 
> Hmmm, it might be nice.
> 
> Thanks for the input.
> 
> PGA
> 
> 


Ill create a patch for it this weekend.

Regards
Anders Fugmann.





