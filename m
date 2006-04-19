Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDSOlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDSOlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDSOlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:41:08 -0400
Received: from el02.a5.com ([216.201.112.39]:913 "EHLO el02.a5.com")
	by vger.kernel.org with ESMTP id S1750805AbWDSOlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:41:06 -0400
X-ClientAddr: 207.179.227.39
Message-ID: <44464BD3.3060708@billgatliff.com>
Date: Wed, 19 Apr 2006 09:40:19 -0500
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFC: rename arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx
References: <20060418165204.GG2516@trinity.fluff.org> <4446187C.2090603@andric.com>
In-Reply-To: <4446187C.2090603@andric.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-A5COM-MailScanner-Information: Please contact the ISP for more information
X-A5COM-MailScanner: Found to be clean
X-MailScanner-From: bgat@billgatliff.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitry:

Dimitry Andric wrote:

>Ben Dooks wrote:
>  
>
>>With the advent of the s3c2410 port adding support for
>>more of the samsung SoC product line (s3c2440, s3c2442,
>>s3c2400) there have been several requests by other people
>>to rename the (in their opinion) increasingly inaccurate
>>arch/arm/mach-s3c2410 to arch/arm/mach-s3c24xx.
>>    
>>
>
>Well, if you start this way, you might also consider renaming it to
>mach-s3cxxxx, since Samsung also seems to have S3C3410, S3C44B0 and who
>knows what else.  Otherwise you'd maybe have to do such an operation
>again in the future...
>
>Also, I've always found the dichotomy of having
>"include/asm-arm/arch-s3c2410" and "arch/arm/mach-s3c2410" rather weird.
>Isn't s3cxxxx an "architecture", instead of a specific machine?  If so,
>arch/arm/arch-s3cxxxx would be more logical.
>  
>

I always interpreted the arch/arm directories to be "machines based on 
the s3cxxxx", etc.  Thus, in my world there's no dichotomy.  But hey, 
that's just one person's world.  :)

>Anyway, by starting to rename directories, you start a never-ending
>quest, and you'll stress the abilities of most version control systems
>too.  Your huge diff for just one rename operation already shows this.
>  
>

It doesn't stress GNU Arch, and I bet it doesn't stress SVN or Cogito.  
What it does do is make the kernel code appear more obvious and better 
organized, which I see as being a good thing for future 
maintainability's sake alone.  So I'm all for these changes.

>There are certainly a lot more directories (also not specifically
>arm-related ones) in the Linux kernel source that could be renamed to be
>more logical, but I'd say the cost is rather large.  E.g. difficulty
>merging patches on older kernels and other version control difficulties.
>  
>

Well, now's our chance to find out whose VC systems we break.  :)  And I 
don't see the "moving patches forward from older kernels" as being an 
argument for locking down the current/future state of the kernel sources.


Respectfully,


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

