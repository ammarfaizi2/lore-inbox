Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbUKKVvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUKKVvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKKVu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:50:58 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:12710 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262371AbUKKVr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:47:59 -0500
Message-ID: <419432D5.7020305@free.fr>
Date: Fri, 12 Nov 2004 04:49:41 +0100
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
References: <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <4193D21A.7010809@free.fr> <4193B2A3.8020103@cybsft.com>
In-Reply-To: <4193B2A3.8020103@cybsft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:

> Remi Colinet wrote:
>
>> Ingo Molnar wrote:
>>
>>> i have released the -V0.7.25-0 Real-Time Preemption patch, which can be
>>> downloaded from the usual place:
>>>
>>>    http://redhat.com/~mingo/realtime-preempt/
>>>
>> Hi,
>>
>> I'm getting the following warning with V0.7.25-0
>>
>> INSTALL sound/drivers/opl3/snd-opl3-lib.ko
>> INSTALL sound/drivers/opl3/snd-opl3-synth.ko
>> INSTALL sound/drivers/snd-dummy.ko
>> INSTALL sound/drivers/snd-mtpav.ko
>> INSTALL sound/drivers/snd-serial-u16550.ko
>> INSTALL sound/drivers/snd-virmidi.ko
>> INSTALL sound/pci/snd-sonicvibes.ko
>> if [ -r System.map ]; then /sbin/depmod -ae -F System.map 
>> 2.6.10-rc1-mm3-RT-V0.7.25-0; fi
>> WARNING: 
>> /lib/modules/2.6.10-rc1-mm3-RT-V0.7.25-0/kernel/drivers/char/rtc.ko 
>> needs unknown symbol rtc_close_event
>> WARNING: 
>> /lib/modules/2.6.10-rc1-mm3-RT-V0.7.25-0/kernel/drivers/char/rtc.ko 
>> needs unknown symbol rtc_open_event
>> [root@tigre01 im]#
>>
>> .config file attached
>>
>> Remi
>
>
> Damn. Here is the patch again. Last one was hosed by wrap. Sorry.
>
> kr

Solved with V0.7.25-1
Thanks

Remi
