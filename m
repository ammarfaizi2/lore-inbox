Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSERTCp>; Sat, 18 May 2002 15:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSERTCo>; Sat, 18 May 2002 15:02:44 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:26273 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S313743AbSERTCn>; Sat, 18 May 2002 15:02:43 -0400
Message-ID: <3CE6A288.2090705@notnowlewis.co.uk>
Date: Sat, 18 May 2002 19:50:48 +0100
From: mikeH <mikeH@notnowlewis.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cantab.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.16 and VIA Chipset
In-Reply-To: <5.1.0.14.2.20020518144515.040cd480@pop.cus.cam.ac.uk> <5.1.0.14.2.20020518194031.04025d10@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aha, now I see! Just got so used to the options being in the same 
place... couldn't see for looking!

Now to see if that fixes the boot problem... :)

Anton Altaparmakov wrote:

> At 16:10 18/05/02, Adrian Bunk wrote:
>
>> On Sat, 18 May 2002, Anton Altaparmakov wrote:
>> > At 13:47 18/05/02, mikeH wrote:
>> > >Apologies, on closer examination of the 2.4 and 2.5 dmesg, it 
>> hangs just
>> > >before the
>> > >ACPI is going to come up. However, there is no option for it in make
>> > >menuconfig, and enabling it in .config breaks the compile.
>> >
>> > What do you mean there is no config option in menuconfig?!? I just 
>> checked
>> > and there is "General options" ---> "ACPI Support" ---> "[ ] ACPI 
>> Support".
>>
>> There are two options that are required and it might be that one of them
>> is missing:
>>
>> 1. "Code maturity level options" -> "Prompt for development and/or
>>                                      incomplete code/drivers"
>
>
> Not true in 2.5.x. ACPI is not dependent on config experimental. Just 
> checked.
>
>> 2. "General setup" -> "Power Management support"
>
>
> Not true in 2.5.x. Power management is not a prerequisite for ACPI in 
> 2.5.x. You notice this already by the fact that ACPI is not under the 
> power management menu any more...
>
> Anton
>
>



