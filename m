Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280320AbRKIXvk>; Fri, 9 Nov 2001 18:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280322AbRKIXva>; Fri, 9 Nov 2001 18:51:30 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:16334 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S280320AbRKIXvR>;
	Fri, 9 Nov 2001 18:51:17 -0500
Message-ID: <3BEC6BE0.6080503@candelatech.com>
Date: Fri, 09 Nov 2001 16:50:56 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
Subject: Re: Disk Performance
In-Reply-To: <000201c16963$365e19e0$5101a8c0@pbc.adelphia.net> <3BEC67BB.3000607@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stefan Smietanowski wrote:

> Hi.
> 
>> Why does my 40 Megabyte per second IDE drive, transfer files at best 
>> at 1-2
>> Megabytes per second? Can anyone prove that this must be the case? 
>> What is
>> the most efficient way to convince anyone who reads this that it can't be
>> proven because a counter example exists?
>>
>> I wish to be personally CC'ed the answers/comments posted to the list in
>> response to this posting.
>>
>> This is my first attempt at being part of the process. Please give me 
>> some
>> time to adjust.
> 
> 
> 40Megabyte per second you say. Well, if it benchmarks at 1-2 Megabytes 
> per second it sounds like a 2 Megabytes per second drive to me, not a 40 
> Megabytes per second drive.
> 
> But, to try to speed it up, make sure you're running with DMA mode enabled.
> 
> hdparm -d1 /dev/hdx where x = number of drive (a=primary master, 
> b=primary slave, c=secondary master, etc).
> 
> But, apart from that, if it indeed is a real problem, what's the name of 
> the motherboard, chipset, hard drive, what linux kernel revision are you 
> running and do you use any special patches or tricks with it?
> 


I once had a problem where the cable was attached in the middle, and the end was
not attached to anything (the cable supported two drives).  After changing to
the end connector, it went from 2MB to 30+MB....

Ben


> // Stefan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


