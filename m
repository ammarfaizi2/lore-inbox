Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313690AbSEVNmO>; Wed, 22 May 2002 09:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313537AbSEVNmN>; Wed, 22 May 2002 09:42:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54286 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313690AbSEVNmM>; Wed, 22 May 2002 09:42:12 -0400
Message-ID: <3CEB9157.2080308@evision-ventures.com>
Date: Wed, 22 May 2002 14:38:47 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AVnY-0001YZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>   From: Paul Mackerras <paulus@samba.org>
>>   Date: Wed, 22 May 2002 20:42:47 +1000 (EST)
>>
>>   Martin Dalecki writes:
>>   
>>   > Remove support for /dev/port altogether.
>>   
>>   Great idea!
>>   
>>You have my blessing too :-)
> 
> 
> I'd rather you didn't break too much application code. How do you think the
> perl people and the python folks do hardware control ? Or for that matter
> java people trying to avoid the crawling horrors of JNI. Its also used by
> libraries like libieee1284. Clock(8) uses it on some systems if the 
> /dev/rtc isn't available or built in.
> 
> Xfree86 much to my suprise seems completely clean. Non Linux stuff uses it
> extensively but not Linux.

The Xfree86 people are actually sane and hold up the BSD tradition.
They don't even use /proc/bus and killed early /proc/agpgart usage!
Quite the reverse is true.


