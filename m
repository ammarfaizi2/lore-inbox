Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311603AbSCNMoN>; Thu, 14 Mar 2002 07:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311604AbSCNMoE>; Thu, 14 Mar 2002 07:44:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:36061 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311603AbSCNMnu>;
	Thu, 14 Mar 2002 07:43:50 -0500
Message-ID: <3C909AEE.1020401@mandrakesoft.com>
Date: Thu, 14 Mar 2002 07:43:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Andrew Morton <akpm@zip.com.au>, Roberto Nibali <ratz@drugphish.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C90939E.4070409@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:

> Andrew Morton wrote:
>
>> Roberto Nibali wrote:
>>
>>> What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed? 
>>
>>
>> They got collaterally damaged in the IDE "cleanup".  The patch at
>> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.6/dallocbase-10-readahead.patch 
>>
>> resurrects them.
>
>
> This is WRONG. What I did here was just removal of unused code.
> They got obsoleted by the BIO infrastructure changes.

Martin,

Did Andrew really deserve that?

Andrew's patch -implements- those ioctls.

Can our new IDE maintainer please have a little bit more patience and 
respect to those who have been hacking the kernel actively for a while? 
 Andrew certainly has earned our respect... calling changes wrong 
without reading them does not.

    Jeff





