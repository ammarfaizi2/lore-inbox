Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCRIQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 03:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUCRIQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 03:16:46 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:18648 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261987AbUCRIQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 03:16:43 -0500
Date: Thu, 18 Mar 2004 09:16:30 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Peter Williams <peterw@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong thing
Message-ID: <20040318091630.A2591@pc9391.uni-regensburg.de>
References: <1079593351.1830.12.camel@bonnie79> <40594ADE.2020804@aurema.com> <1079594175.1830.22.camel@bonnie79> <4059565E.4020007@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4059565E.4020007@aurema.com>; from peterw@aurema.com on Thu, Mar 18, 2004 at 08:57:18 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.2004   08:57 Peter Williams wrote:
> Christian Guggenberger wrote:
>> On Thu, 2004-03-18 at 08:08, Peter Williams wrote:
>> 
>>> Christian Guggenberger wrote:
>>> 
>>>>> With 2.6.4 I'm getting the following messages very early in the boot 
>>>>> long before XFree86 is started:
>>>>> 
>>>>> Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released 
>>>>> (translated set 2, code 0x7a on isa0060/serio0).
>>>>> Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It 
>>>>> shouldn't access hardware directly.
>>>>> 
>>>>> They are repeated 6 times and are NOT the result of any keys being 
>>>>> pressed or released.
>>>> 
>>>> 
>>>> this has been fixed in XFree86 HEAD (4.4.99.1)
>>>> see changelog entry nr. 6 - the changes can easily be backported to 
>>>> 4.3.0, and work as expected on my box.
>>>> (no noise anymore)
>>> 
>>> I repeat.  These messages are appearing when XFree86 is NOT running so 
>>> there is no way that it can be the cause of them.
>> 
>> 
>> yeah, sorry. After reading your previous mail I realized it, too.
>> If you have some spare time, you could boot with init=/bin/bash and then
>> start every boot script step by step to see which one is causing these
>> kernel messages.
> 
> OK.  As requested, I just did a boot with init=/bin/bash and the bad news is 
> that the messages appeared before bash started.  So I think that confirms my 
> suspicion that they occur before any of the start scripts are invoked?
> 
[cc'ed linux-kernel again]

Yeah, I do think so.



