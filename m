Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTBDXCg>; Tue, 4 Feb 2003 18:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTBDXCf>; Tue, 4 Feb 2003 18:02:35 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:32222 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S267546AbTBDXCf>;
	Tue, 4 Feb 2003 18:02:35 -0500
References: <1044385759.1861.46.camel@localhost.localdomain.suse.lists.linux.kernel>
            <200302041935.h14JZ69G002675@darkstar.example.net.suse.lists.linux.kernel>
            <b1pbt8$2ll$1@penguin.transmeta.com.suse.lists.linux.kernel>
            <p73znpbpuq3.fsf@oldwotan.suse.de>
            <3E4045D1.4010704@rogers.com>
In-Reply-To: <3E4045D1.4010704@rogers.com> 
From: b_adlakha@softhome.net
To: Jeff Muizelaar <muizelaar@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 2.95 vs 3.21 performance
Date: Tue, 04 Feb 2003 16:12:09 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [210.214.82.90]
Message-ID: <courier.3E4048C9.00003149@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Muizelaar writes: 

> Andi Kleen wrote: 
> 
>> If you want small and fast use lcc. 
>> 
>> Unfortunately it's not completely free (some weird license), doesn't
>> really support real inline assembly and generates rather bad code 
>> compared to gcc. 
>> 
>> I'm still looking forward to Open Watcom (http://www.openwatcom.org) - 
>> they are near self hosting on Linux. The inline assembly is very VC++ 
>> style though; very different from gcc and worse you have to write it in
>> Intel syntax. 
>> 
>> Another alternative would be TenDRA, but it also has no inline assembly
>> and it's C understanding can be only described as "fascist". 
>> 
>> If you don't care about free software you could also use the Intel
>> compiler, which seems to be often faster in compile time than gcc now
>> and can already compile kernels. 
>> 
> There is also tcc (http://fabrice.bellard.free.fr/tcc/)
> It claims to support gcc-like inline assembler, appears to be much smaller 
> and faster than gcc. Plus it is GPL so the liscense isn't a problem 
> either.
> Though, I am not really sure of the quality of code generated or of how 
> mature it is. 
> 
> -Jeff

wow, looks like some teenage kid like me made it...
its a 170 kb gzipped tar!
nice for a C compiler...But i'm not sure if it could compile half of the 
linux kernel successfully... 
