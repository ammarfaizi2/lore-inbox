Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTCFHZl>; Thu, 6 Mar 2003 02:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267871AbTCFHZl>; Thu, 6 Mar 2003 02:25:41 -0500
Received: from flrtn-2-m1-133.vnnyca.adelphia.net ([24.55.67.133]:30592 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S267870AbTCFHZk>;
	Thu, 6 Mar 2003 02:25:40 -0500
Message-ID: <3E66FA6B.3050506@tmsusa.com>
Date: Wed, 05 Mar 2003 23:36:11 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01 (NSCD7.01)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, ahu@ds9a.nl
Subject: Re: Oops in 2.5.64
References: <3E66E782.5010502@tmsusa.com> <20030305223638.77c22cb7.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>J Sloan <joe@tmsusa.com> wrote:
>  
>
>>Mar  5 21:17:41 jyro init: Switching to runlevel: 3
>>Mar  5 21:17:42 jyro kernel: mtrr: MTRR 2 not used
>>Mar  5 21:17:43 jyro microcode_ctl: microcode_ctl startup succeeded
>>Mar  5 21:17:44 jyro kernel: Unable to handle kernel paging request at virtual address d85b0000
>>    
>>
>
>hmm, looks like a module address.
>
ah - hmm...

>>Mar  5 21:17:44 jyro kernel: EFLAGS: 00010216
>>Mar  5 21:17:44 jyro kernel: EIP is at __constant_c_and_count_memset+0x85/0xa0
>>    
>>
>
>Eh?  How come the compiler didn't inline __constant_c_and_count_memset?
>What compiler version are you using?
>
Yes, odd -

I'm using plain old gcc-3.2 as supplied by Red Hat

>
>My guess would be that something has tried to reference a module which isn't
>there any more.
>
>Did you at any time unload a module?   If so, which one?
>
I last unloaded a module while running 2.4.21-pre5-ac1

I hadn't done so in 2.4.64 - at least not manually...

Joe



