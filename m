Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSEVNgS>; Wed, 22 May 2002 09:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313589AbSEVNgQ>; Wed, 22 May 2002 09:36:16 -0400
Received: from [195.63.194.11] ([195.63.194.11]:53005 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313563AbSEVNgJ>; Wed, 22 May 2002 09:36:09 -0400
Message-ID: <3CEB8FEC.5000702@evision-ventures.com>
Date: Wed, 22 May 2002 14:32:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AVTV-0001Vw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>I'm waiting on Phil Blundell to notice - I think /dev/port may get used
>>on ARM to emulate inb() and outb() from userspace; I don't look after
>>glibc so shrug.
>>
>>I agree however that /dev/port is a rotten interface that needs to go.
> 
> 
> The /dev/port interface is used by various apps and its a traditional
> x86 in paticular unix thing. For platforms like ARM its poorly implemented

Erm... unix thing? I see it only in Linux...
BTW. Just recently someone has found out that it is indeed
*poorly* implemented.


> since it ought to turn into a fraction of /dev/mem and support mmap for
> speedier user space in/out emulation..

