Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSDIVZG>; Tue, 9 Apr 2002 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311647AbSDIVZG>; Tue, 9 Apr 2002 17:25:06 -0400
Received: from [206.40.202.198] ([206.40.202.198]:45290 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311641AbSDIVZF>; Tue, 9 Apr 2002 17:25:05 -0400
Date: Tue, 9 Apr 2002 14:24:16 -0700 (PDT)
From: John Heil <kerndev@sc-software.com>
To: David Shirley <dave@cs.curtin.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SMP problem with 2.4.18
In-Reply-To: <5.1.0.14.2.20020409103623.025e5178@pop.cs.curtin.edu.au>
Message-ID: <Pine.LNX.4.33.0204091419570.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, David Shirley wrote:

> Date: Tue, 09 Apr 2002 10:59:07 +0800
> From: David Shirley <dave@cs.curtin.edu.au>
> To: linux-kernel@vger.kernel.org
> Subject: SMP problem with 2.4.18
>
> Hi guys,
>
> I am having a problem with a new dual box, its a dual athlon 1900+,
> in a Asus A7M-266-D. When I try using MPS 1.4 the kernel gets upto
> printing out CPU1:<T0:...  but no further.
>
> When I switch to MPS 1.1 everything works correctly?
>
> After doing some research I found that by adding the noapic and apm=off
> kernel parameters everything started to work with 1.4.
>
> Is this normal? Is it better to run with 1.1 or 1.4 and noapic?
>
> If you need more info please ask :)
>
> Thanks
> Dave
>

Run it set at 1.1 only.
1.1 will let you use your apic etc

1.4 is stricter. Mfgrs don't abide by 1.4 correctly/completely.
I don't know of any 1.4 capable board that works right in 1.4 mode.

Johnh

>
>
>
> /-----------------------------------
> David Shirley
> System's Administrator
> Computer Science - Curtin University
> (08) 9266 2986
> -----------------------------------/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

