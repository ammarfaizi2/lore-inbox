Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265702AbTFNSzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 14:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265703AbTFNSzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 14:55:06 -0400
Received: from dsl081-085-006.lax1.dsl.speakeasy.net ([64.81.85.6]:33216 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id S265702AbTFNSy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 14:54:59 -0400
Message-ID: <3EEB72C0.80702@tmsusa.com>
Date: Sat, 14 Jun 2003 12:08:48 -0700
From: Joe <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030612
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Xeon  processors &&Hyper-Threading
References: <3EE9FDFA.6020803@mindspring.com> <Pine.LNX.4.53.0306131241330.5894@chaos> <3EEB6A4B.7040106@mindspring.com>
In-Reply-To: <3EEB6A4B.7040106@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't linux vendors ship a variety of precompiled
kernels to match the various hardware scenarios?

I'm trying to imagine why a customer would ever
want or need to roll their own...

Joe

Joe wrote:

> Thanks, I was asked this by one of our clients, and told them that 
> they would probably have to recompile their kernel.
>
> Joe
>     
>
> Richard B. Johnson wrote:
>
>> On Fri, 13 Jun 2003, Joe wrote:
>>
>>
>>> Does Linux support the Xeon (p4) processor and its capabilities?
>>>
>>> The company I work for recently ported its application to Linux and one
>>> of our current HP clients asked this and I figure it would be just a
>>> recompile the kernel as a P4, but not sure if this would do it.
>>>
>>> I'm not asking if Linux can RUN the Xeon processor.
>>>
>>> I'm asking if Linux processor takes any advantage of the 
>>> Hyper-Threading
>>> built into this processor?
>>>
>>> below is a link to more info on this.
>>>
>>> http://www.intel.com/design/xeon/prodbref/
>>>
>>> Joe
>>>
>>
>>
>> You recompile the kernel for SMP as well as P4. If the motherboard
>> hasn't disabled HT capabilities, you will take full advantage of
>> the processor under Linux. Whatever "full advantage" means, is
>> not absolute, but whatever it is, will be used to its fullest.
>> Basically, if the code is I/O bound, you'll not see any difference.
>> If the code is compute-intensive, you will.
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
>> Why is the government concerned about the lunatic fringe? Think about 
>> it.
>>


