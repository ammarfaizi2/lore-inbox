Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268355AbUJMFZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268355AbUJMFZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268357AbUJMFZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:25:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:32423 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268355AbUJMFY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:24:58 -0400
Message-ID: <416CBB5E.7050803@osdl.org>
Date: Tue, 12 Oct 2004 22:21:34 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ricky lloyd <ricky.lloyd@gmail.com>
CC: Raj <inguva@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Build problems with APM/Subarch type
References: <b2fa632f04101204385c09459f@mail.gmail.com>	 <416CB8FC.9020503@osdl.org> <1a50bd370410122221ebb3796@mail.gmail.com>
In-Reply-To: <1a50bd370410122221ebb3796@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky lloyd wrote:
>>>Did all the configuration properly, except that i fumbled on the keyboard and
>>>the option 'Subarchitecture Type' somehow got set to
>>>'(SGI 320/540 Visual Workstation)'.
>>
>>Using an editor or make *config?  which *config?
> 
> 
> make menuconfig.
> 
> 
>>>The build failed with an error 'Undefined reference to machine_real_restart'
>>
>>Yep, I see that also.
>>
>>
>>>It seems that , unless Subarch is PC-Compatible ( CONFIG_PC ) ,
>>>CONFIG_X86_BIOS_REBOOT will not be set and thusly, reboot.c would not be
>>>compiled.
>>>
>>>( yeah, i know messing around with configs is suicidal, but.... )
>>>
>>>Can this be fixed ?? At the very least, hide APM options #if !(CONFIG_PC) ??
>>
>>Do you/we/maintainer know that APM is not applicable to all of the
>>other PC sub-arches?
>>
> 
> afaics, i found 'apm.c' only in arch/i386/kernel and arch/arm/kernel.
> does that really
> confirm that apm would not be applicable for other archs ?? 

The question is actually about other PC sub-arches, not other (Big)
arch-es.

> 
>>I agree that it should be fixed, one way or another.
>>--


-- 
~Randy
