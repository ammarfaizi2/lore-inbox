Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSFKSbE>; Tue, 11 Jun 2002 14:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSFKSbD>; Tue, 11 Jun 2002 14:31:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33285 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317489AbSFKS3t> convert rfc822-to-8bit; Tue, 11 Jun 2002 14:29:49 -0400
Message-ID: <3D06418F.3050904@evision-ventures.com>
Date: Tue, 11 Jun 2002 20:29:35 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, Robert Love <rml@tech9.net>,
        linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
In-Reply-To: <Pine.LNX.4.44.0206111917310.3521-100000@sharra.ivimey.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Ruth Ivimey-Cook napisa³:
> On Tue, 11 Jun 2002, Randy.Dunlap wrote:
> 
> 
>>On 11 Jun 2002, Robert Love wrote:
>>
>>| Here are the defaults I picked:
>>|
>>| CONFIG_NR_CPUS=32: i386, mips, parisc, ppc, sparc
>>
>>I don't know what is "typical" for non-x86, but for x86, why not
>>use something more like a 'typical' NR_CPUS for SMP, like 8 (?)...
>>why still waste all of that memory?
> 
> 
> Perhaps it's just because I'm coming in late, but I cannot understand why
> NR_CPUS cannot be as low as 4 by default, for all archs, and then in the
> kernel boot messages, should more be found than is configured for a message is
> emitted to say "reconfigure your kernel", and continue with the number it was
> configured for. I personally only rarely see 2-way boxes, 4-way is pretty
> rare, and anything more must surely count as very specialized.
> 
> Let the defaults be reasonable for 99% of users (IMO 99.9%), and let the rest 
> have to think about config options...


Actually 2 would only make sense on Intel.
Well and then you have to account for the recent
HT additions so this becoumes 4.
On Sparc 4 is quite common.
But anything above is indeed very very rare.


