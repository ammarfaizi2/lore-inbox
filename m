Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSEVNfP>; Wed, 22 May 2002 09:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSEVNfO>; Wed, 22 May 2002 09:35:14 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50701 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313508AbSEVNfO>; Wed, 22 May 2002 09:35:14 -0400
Message-ID: <3CEB8FB4.5070802@evision-ventures.com>
Date: Wed, 22 May 2002 14:31:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AW58-0001eU-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>kmem = kernel memory.  That may not be the same as the physical
>>memory (the fact that it is at present I find mostly irrelevant here).
>>/dev/mem is the more correct device to use for this purpose.
> 
> 
> /dev/mem is also not strictly correct. Linux in/out space is operated as
> synchronous I/O operations. A dumb map of /dev/mem areas can lead to
> differences if the platform concerned has to do the I/O post and wait
> completion handling in software. (O_SYNC is also not enough since thats
> memory caching not PCI posting)
> 

I wisper only - memzone...


