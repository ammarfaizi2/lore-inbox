Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUJMFa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUJMFa1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 01:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUJMFa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 01:30:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:36782 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268368AbUJMFaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 01:30:18 -0400
Message-ID: <416CBC9C.8010905@osdl.org>
Date: Tue, 12 Oct 2004 22:26:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Raj <inguva@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, pazke@donpac.ru
Subject: Re: Build problems with APM/Subarch type
References: <b2fa632f04101204385c09459f@mail.gmail.com>	 <416CB8FC.9020503@osdl.org> <b2fa632f041012222745006916@mail.gmail.com>
In-Reply-To: <b2fa632f041012222745006916@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Raj wrote:
>>Using an editor or make *config?  which *config?
>>
> 
> xconfig
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
>>I agree that it should be fixed, one way or another.
> 
> 
> i am not aware much about the apm dependencies. maintainers might answer 
> this more correctly. 

True.  I should have copied Andrey on it earlier.

Andrey, any thoughts about how to keep VISWS from building APM
support?  use Kconfig?  or does VISWS support APM?

-- 
~Randy
