Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311609AbSCNMyO>; Thu, 14 Mar 2002 07:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311608AbSCNMxz>; Thu, 14 Mar 2002 07:53:55 -0500
Received: from [195.63.194.11] ([195.63.194.11]:268 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S311609AbSCNMxL>;
	Thu, 14 Mar 2002 07:53:11 -0500
Message-ID: <3C909CE5.4020706@evision-ventures.com>
Date: Thu, 14 Mar 2002 13:51:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andrew Morton <akpm@zip.com.au>, Roberto Nibali <ratz@drugphish.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C90939E.4070409@evision-ventures.com> <3C909AEE.1020401@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Martin Dalecki wrote:
> 
>> Andrew Morton wrote:
>>
>>> Roberto Nibali wrote:
>>>
>>>> What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed? 
>>>
>>>
>>>
>>> They got collaterally damaged in the IDE "cleanup".  The patch at
>>> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch 
>>>
>>> resurrects them.
>>
>>
>>
>> This is WRONG. What I did here was just removal of unused code.
>> They got obsoleted by the BIO infrastructure changes.
> 
> 
> Martin,
> 
> Did Andrew really deserve that?
> 
> Andrew's patch -implements- those ioctls.
> 
> Can our new IDE maintainer please have a little bit more patience and 
> respect to those who have been hacking the kernel actively for a while? 
> Andrew certainly has earned our respect... calling changes wrong without 
> reading them does not.

It was just a note on the who "broke them". However I welcome his
efforts to actually implement the functionality in a clean manner.
Still something unclear? I wish not?

