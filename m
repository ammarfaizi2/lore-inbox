Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129638AbRCZXJw>; Mon, 26 Mar 2001 18:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCZXJm>; Mon, 26 Mar 2001 18:09:42 -0500
Received: from river.it.gvsu.edu ([148.61.1.16]:10953 "EHLO river.it.gvsu.edu")
	by vger.kernel.org with ESMTP id <S129638AbRCZXJc>;
	Mon, 26 Mar 2001 18:09:32 -0500
Message-ID: <3ABFCBCC.30700@lycosmail.com>
Date: Mon, 26 Mar 2001 18:07:56 -0500
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac20 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Sane Architectures
In-Reply-To: <Pine.LNX.4.10.10103261752260.23483-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

>> Are there any architectures that are simple (sane) to implement sftw on? 
> 
> 
> sftw?  software?  yes: portable C/C++ is a fine platform.

Not really the platform, but the architecture, from a C/C++ compiler and 
kernel/asm/lowlevel lang development standpoint

> 
>> The i386 is plagued by it's 16-bit (arguably its 8 or even 4 bit) past. 
> 
> 
> I wonder what you mean by that.  it's ia32's accumulator-based
> architecture, and stack-based FPU that "plague" it, neither of which
> has anything to do with bitness.  or are you actually talking about
> instruction encoding?

the limited number of registers (3 bits allocated, IIRC) which limits 
the number to 8 minus CS,DS,IP; meaning only 5 GPRs, the requirement of 
an (antiquated) BIOS (design), 16-bit bootstrap

> 
>> This can include architectures like the IA64 & the upcoming x86-64. Just 
>> looking for something with lots of GPR's, sane MM support, etc.
> 
If not lots of GPRs, but at least enough to be able to allocate sanely.

> 
> alpha?  mips?

Yes, I just didn't feel like listing all arch's. Plus, (ducks) the MIPS 
is no longer supported by Windoze, and I rarely see any discussion on lk 
about this arch, and I forgot about Alpha for a minute.

I admit that I likely look like an idiot right now, and I am not 
intending to insult anyone, just curious about this.

