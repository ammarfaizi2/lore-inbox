Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVIUTuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVIUTuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 15:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVIUTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 15:50:40 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:32910 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S932134AbVIUTug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 15:50:36 -0400
Message-ID: <4331B9B0.6050300@concannon.net>
Date: Wed, 21 Sep 2005 15:51:12 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Concannon <mike@concannon.net>
CC: Tomasz Torcz <zdzichu@irc.pl>, linux-kernel@vger.kernel.org
Subject: Re: spurious mouse clicks
References: <433164F4.40205@concannon.net> <20050921140857.GA17224@irc.pl> <43316B2A.4040303@concannon.net> <43316C36.1010703@concannon.net>
In-Reply-To: <43316C36.1010703@concannon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Concannon wrote:

> Michael Concannon wrote:
>
>> Tomasz Torcz wrote:
>>
>>>>
>>>> With 2.6.13.1 & 2 as I move my mouse around the screen, I get 
>>>> random clicks on things the mouse passes.  Seems to happen more 
>>>> often with the first move from idle, but in general, it is just 
>>>> totally random...
>>>>
>>>> With 2.6.9-11.EL and 2.6.12.6 (stock kernel.org) I do NOT get this.
>>>>
>>> Do you have lines like:
>>>
>>> psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost 
>>> synchronization, throwing 1 bytes away.
>>>
>>> in your dmesg?
>>>
>> [mike@porthos proc]$ dmesg | grep -i throwing
>> [mike@porthos proc]$ dmesg | grep -i psmouse
>>
>> it would appear not...
>
>
> oops - I am running 2.6.12.6 now - I guess I should try the offending 
> kernel before I answer that question ;-)
>
> BTW - I also neglected to mention that I routinely lower Hz to 250 in 
> param.h to remove sound-card whine - but I did this with all kernels 
> in question... (it is now a CONFIG option in 2.6.13 which is nice... )

Been using 2.6.13.2 most of the day - and though I have seen fewer 
random clicks - I am still seeing them...

no dmesg output though...  anything else I can check?

Thanks,

/mike

