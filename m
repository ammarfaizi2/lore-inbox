Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281646AbRKPXk1>; Fri, 16 Nov 2001 18:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281650AbRKPXkS>; Fri, 16 Nov 2001 18:40:18 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:50844 "EHLO
	k-7.stesmi.com") by vger.kernel.org with ESMTP id <S281646AbRKPXj7>;
	Fri, 16 Nov 2001 18:39:59 -0500
Message-ID: <3BF5A3FB.9000106@stesmi.com>
Date: Sat, 17 Nov 2001 00:40:43 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162302160.22827-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

>>Would you mind writing what each of these actually is?
>>Athlon 661 doesn't tell me much, neither does Duron 671.
>>That's just an example, which is which?
> 
> The numbers translate to the family/model/stepping fields
> of /proc/cpuinfo.


Yeah, I know. That was the easy bit.

> The only older models certified as safe for SMP are.
> 
>  Athlon model 6, stepping 0 CPUID = 660
>  Athlon model 6, stepping 1 CPUID = 661
>  Duron  model 7, stepping 0 CPUID = 670


Ok, since you're misunderstanding me, where do I find out which is 
which, ie CPUID 660 is an ... and CPUID 670 is an ...

Point me to some good place to find out and I'm happy.

I'll try looking on www.amd.com to see if I can find it myself :)

> The newer models..
>  model 6 stepping 2 and above 662
>  model 7 stepping 1 and above 671
> 
> have a cpuid flag that must be compared to find out if they
> are capable or not. Note that these id's tally with XP's and MP's.
> The capability bit is the only way to distinguish between these models.


Right, all I'd need is a way to match these numbers to core names. :)


// Stefan


