Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTAJDcg>; Thu, 9 Jan 2003 22:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTAJDcg>; Thu, 9 Jan 2003 22:32:36 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:37418 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262449AbTAJDce>; Thu, 9 Jan 2003 22:32:34 -0500
Message-ID: <3E1E410E.5050905@emageon.com>
Date: Thu, 09 Jan 2003 21:42:06 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>At some point in the past, I wrote:
>  
>
>>>There is no extant implementation of paged stacks yet.
>>>      
>>>
>
>On Thu, Jan 09, 2003 at 09:17:56PM -0600, Brian Tinsley wrote:
>  
>
>>For the most part, this is probably a boundary condition, right? Anyone 
>>that intentionally has 800+ threads in a single application probably 
>>needs to reevaluate their design :)
>>    
>>
>
>IMHO multiprogramming is as valid a use for memory as any other. Or
>even otherwise, it's not something I care to get in design debates
>about, it's just how the things are used.
>
I agree with the philosophy in general, but if I sit down to write a 
threaded application for Linux on IA-32 and wind up with a design that 
uses 800+ threads in any instance (other than a bug, which was our 
case), it's time to give up the day job and start riding on the back of 
the garbage truck ;)

>The only trouble is support for what you're doing is unimplemented.
>
You mean the 800+ threads or Java on Linux?

>At some point in the past, I wrote:
>  
>
>>>I'm working on a different problem (mem_map on 64GB on 2.5.x). I
>>>probably won't have time to implement it in the near future, I
>>>probably won't be doing it vs. 2.4.x, and I won't have to if someone
>>>else does it first.
>>>      
>>>
>
>On Thu, Jan 09, 2003 at 09:17:56PM -0600, Brian Tinsley wrote:
>  
>
>>Is that a hint to someone in particular?
>>    
>>
>
>Only you, if anyone. My intentions and patchwriting efforts on the 64GB
>and highmem multiprogramming fronts are long since public, and publicly
>stated to be targeted at 2.7. Since there isn't a 2.7 yet, 2.5-CURRENT
>must suffice until there is.
>
In all honesty, I would enjoy nothing more than contributing to kernel 
development. Unfortunately it's a bit out of my scope right now (but not 
forever). If I only believed aliens seeded our gene pool with clones, I 
could hook up with those folks that claim to have cloned a human and get 
one of me made! ;)


