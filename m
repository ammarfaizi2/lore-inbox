Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVFHQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVFHQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFHQ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:28:36 -0400
Received: from mail2.utc.com ([192.249.46.191]:21758 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S261333AbVFHQ0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:26:49 -0400
Message-ID: <42A71C3C.9020707@cybsft.com>
Date: Wed, 08 Jun 2005 11:26:36 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A7135C.5010704@cybsft.com> <42A717E1.5050505@cybsft.com>
In-Reply-To: <42A717E1.5050505@cybsft.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> K.R. Foley wrote:
> 
>> Ingo Molnar wrote:
>>
>>> i have released the -V0.7.48-00 Real-Time Preemption patch, which can 
>>> be downloaded from the usual place:
>>>
>>>     http://redhat.com/~mingo/realtime-preempt/
>>>
>>> this release includes an improved version of Daniel Walker's soft 
>>> irq-flag (hardirq-disable removal) feature. It is an unconditional part
>>> of the PREEMPT_RT preemption model - other preemption models should not
>>> be affected that much (besides possible build issues). Non-x86 arches
>>> wont build. Some regressions might happen, so take care..
>>>
>>> Changes since -47-29:
>>>
>>>  - soft IRQ flag support (Daniel Walker)
>>>
>>>  - fix race in usbnet.c (Eugeny S. Mints)
>>>
>>>  - further improvements to the soft IRQ flag code
>>>
>>> to build a -V0.7.48-00 tree, the following patches should to be applied:
>>>
>>>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
>>>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc6.bz2
>>>    
>>> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc6-V0.7.48-00 
>>>
>>>
>>>     Ingo
>>
>>
>>
>> Ingo,
>>
>> I can't get any version of RT-preempt applied to 2.6.12-rc6 up to and 
>> including 48-01 to boot on any of my SMP systems. I get no log because 
>> it dies right after the "Uncompressing kernel" message. 2.6.12-rc6 
>> boots fine.  I am attaching my config. Am I missing something obvious? 
>> I am building 48-01 with voluntary-preempt now to try that.
>>
>>
> 
> Just confirmed that CONFIG_PREEMPT_VOLUNTARY works OK. Building 
> CONFIG_PREEMPT_DESKTOP=y now.
> 
This too, works OK. Ideas?

-- 
    kr
