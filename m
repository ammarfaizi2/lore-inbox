Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUJOEM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUJOEM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 00:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUJOEM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 00:12:29 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:27408 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S266163AbUJOEM1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 00:12:27 -0400
Message-ID: <416F5CC8.7020605@vt.edu>
Date: Fri, 15 Oct 2004 00:14:48 -0500
From: William Wolf <wwolf@vt.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
References: <416EE7EB.4070209@vt.edu> <200410142230.38633.dtor_core@ameritech.net> <416F556E.4090103@vt.edu> <200410142305.29859.dtor_core@ameritech.net>
In-Reply-To: <200410142305.29859.dtor_core@ameritech.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's compiling now, i'll let you know how it goes.  Do you have any idea 
about my other errors when using this kernel?

Dmitry Torokhov wrote:
> On Thursday 14 October 2004 11:43 pm, William Wolf wrote:
> 
>>Dmitry Torokhov wrote:
>>
>>>On Thursday 14 October 2004 10:23 pm, William Wolf wrote:
>>>
>>>
>>>>Dmitry Torokhov wrote:
>>>>
>>>>
>>>>>On Thursday 14 October 2004 03:56 pm, William Wolf wrote:
>>>>>
>>>>>
>>>>>
>>>>>>Hey, I just tried -rc4-mm1 on my amd64 laptop, and my keyboard fails to
>>>>>>work, I don't even think it is being recognized. 
>>>>>
>>>>>
>>>>>Could you try booting with i8042.noacpi and if it helps mailing me your
>>>>>/proc/acpi/dsdt?
>>>>>
>>>>>Thanks!
>>>>>
>>>>
>>>>
>>>>Thanks a bunch, this fixed the keyboard problem.  What did this do 
>>>>exactly?
>>>
>>>
>>>It caused i8042 not to rely on ACPI BIOS data and use defaults.
>>>
>>>/proc/acpi/dsdt, pretty please.
>>>
>>
>>Hmmm, not sure if i did this right, doesnt look to readable, but ive 
>>attatched it below, i just did a cat /proc/acpi/dsdt > dsdt, hope this 
>>is what u wanted, lemme know if i did something wrong.
>>
> 
> 
> Yes, that's what I needed.. It seems that they decided to use new PNP IDs
> for mouse and keyboard. Please try the patch below when you have time.
> 
