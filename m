Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSEVRkL>; Wed, 22 May 2002 13:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316421AbSEVRkK>; Wed, 22 May 2002 13:40:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42770 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316544AbSEVRkH>; Wed, 22 May 2002 13:40:07 -0400
Message-ID: <3CEBC91A.3070207@evision-ventures.com>
Date: Wed, 22 May 2002 18:36:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AZoV-0002I7-00@the-village.bc.nu> <3CEBC496.9030900@evision-ventures.com> <20020522183012.J16934@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Russell King napisa?:
> On Wed, May 22, 2002 at 06:17:26PM +0200, Martin Dalecki wrote:
> 
>>#include <linux/io.h>
>>#include <stdio.h>
>>#include <stdlib.h>
>>
>>int main(char *argv[], int argc)
>>{
>>	int port = aoit(argv[0]);
>>	 int byte = aoit(argv[1]);
>>
>>	if (port > 0)
>>		return inb(port);		
>>	 else
>>			outb(port, byte);
>>
>>
>>		return 0;
>>}
> 
> 
> Erm:
> 
> 1. not checking number of arguments passed.
> 2. thinking argv[0] is the first arg.
> 3. wrong test for in/out (port > 0 -> inb, port <= 0 -> outb)
> 4. returning the read byte via the program status code.
> 5. aoit is an undefined function.
> 6. including linux/*.h is fundamentally wrong for any user space
>    program.
> 
> That's one bug every 2 lines.  Should I continue? 8)

Where the *hell* - did I say that the above program was supposed
to be ANSI C ?#$@#! It's in my own
advanced/object oriented/intuitive/component/virtual machine
based mdcki-c-alike-python commercial closed source language
I'm developing to provide a replacement base for the next
generation of Rudy102 distro configuration utilities if you ask. OK?

BTW.> I'm sure it will bite the pants out of C# in the year 2100 where I
have scheduled it for the first public release.

Any questions remaining?


