Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267780AbTBGKWO>; Fri, 7 Feb 2003 05:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267783AbTBGKWO>; Fri, 7 Feb 2003 05:22:14 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:50899 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267780AbTBGKWM>;
	Fri, 7 Feb 2003 05:22:12 -0500
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel>
            <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel>
            <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel>
            <p73znpbpuq3.fsf@oldwotan.suse.de>
            <3E4045D1.4010704@rogers.com>
            <20030206070256.GB30345@daikokuya.co.uk>
            <courier.3E423112.00007219@softhome.net>
            <20030206212218.GA4891@daikokuya.co.uk>
In-Reply-To: <20030206212218.GA4891@daikokuya.co.uk> 
From: b_adlakha@softhome.net
To: Neil Booth <neil@daikokuya.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Fri, 07 Feb 2003 03:31:50 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.152]
Message-ID: <courier.3E438B16.00000E1F@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Booth writes: 

> b_adlakha@softhome.net wrote:- 
> 
>> Maybe thats why its a 0.9* version, and the auther has stated on his site 
>> that not all C98 features are implimented...but then even GCC doesn't 
>> impliment them...
> 
> No, I said C89.  He's got a *long* way to go for that.  Forget C99. 
> 
> However, he does claim C89 compliance, which is quite disingenuous. 
> 
>> I checked tcc out, and its damn fast, much much much much faster than gcc.
>> gcc is bloated and its slow even on my pentium 4 machine, let alone my 1.2 
>> celeron. It takes 20 minutes to compile a new kernel on that, now if you're 
>> gonna test kernels/patches, you can wait 20 minutes for every compile! 
> 
> I agree.  I'm trying to fix it. 
> 
> GCC is larger for a reason: it does things properly.  It's easy to be
> fast if you're willing to be wrong, and not emit warnings or errors, and
> not implement half the standard.  And not optimize. 
> 
>> Even icc is much better than gcc, but its very perticular about code (and 
>> its not gcc compatible as the intel site says)
>> And its non-free also... 
> 
> Only better in terms of compile speed.

Cool (you're trying to fix it), maybe you can modify tcc so it is optimized 
for compiling linux (optimized for compiling speed and runtime speed for 
linux). I think it'll be easier and quicker to just make it compile linux 
properly first, then do the testing/fixing for other things, as they are so 
many compilers for other things anyway...And maybe it can be called "Linux C 
Compiler"? lol. 

