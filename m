Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSEVOpC>; Wed, 22 May 2002 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSEVOnq>; Wed, 22 May 2002 10:43:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:35344 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315441AbSEVOn0>; Wed, 22 May 2002 10:43:26 -0400
Message-ID: <3CEB9FB3.9040401@evision-ventures.com>
Date: Wed, 22 May 2002 15:40:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.GSO.4.21.0205221030100.2737-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Wed, 22 May 2002, Martin Dalecki wrote:
> 
> 
>>>For kbdrate???  sysctl I might see - after all, we are talking about
>>>setting two numbers.  ioctl() to pass a couple of integers to the kernel?
>>>No, thanks.
>>
> 
> If you are complaining about use of /dev/port - I completely agree that it's
> crap...

Oh then sorry we must have missed the point.
Maybe I was just too eager for a nice flame-war which doesn't
contain the magical word BitKeeper or similar ;-)...
Anyway I'm satisfied now ;-))))...


>>Portable along architectures - no thanks?
>>Portbale along different devices and device driver implementations - no thanks?
>>Not to mess with hardware with preassumtptions how it works - no thanks?
>>Giving PC vendors a chance to get rid of silly legacy hardware - no thanks?
>>Abviously documented by beeing there - no thanks?
> 
> 
> ... but WTF does it have to ioctl vs. saner mechanisms?

It's all about the basic principle that operating systems
serve the principal purpose of abstracting hardware inferfaces
out of the actual hardware implementation and provide
*abstract* interfaces to the user space programmer. Not
more.

In this particular case it's just that ioctl fits it best.
Becouse:

1. It's already there.

2. What is there should only be fixed.

3. It's at the right level (input hardware).

4. It's more easy to implement then every thing else.

5. It's easiest to use by the application programmer.

6. I don't think that there is something saner out there.

7. Did I mention that it's already there?

But now I see that you have just certainly missed only
some previous points in this "discussion" and I wouldn't
of couse at no single second think seriously,
that the former triviallity isn't abvious to you ;-).

