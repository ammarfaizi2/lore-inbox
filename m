Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSEGLht>; Tue, 7 May 2002 07:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSEGLhs>; Tue, 7 May 2002 07:37:48 -0400
Received: from [195.63.194.11] ([195.63.194.11]:55816 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315411AbSEGLhr>; Tue, 7 May 2002 07:37:47 -0400
Message-ID: <3CD7ADD1.5080404@evision-ventures.com>
Date: Tue, 07 May 2002 12:34:57 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Roman Zippel <zippel@linux-m68k.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <Pine.LNX.4.21.0205071329380.32715-100000@serv> <3CD7ACF4.7030606@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Martin Dalecki napisa?:
> Uz.ytkownik Roman Zippel napisa?:
> 
>> Hi,
>>
>> On Tue, 7 May 2002, Martin Dalecki wrote:
>>
>>
>>>> Please don't do this! There are configurations possible with pci 
>>>> enabled but without a pci ide adapter.
>>>
>>>
>>> So please just don't configure any PCI host chip support there.
>>
>>
>>
>> Then ide-pci.c is still compiled into the kernel. Why?
> 
> 
> 
> Becouse the big tables there are subject to go.

And at some point in time it will check whatever there is
request for any host chip support.

