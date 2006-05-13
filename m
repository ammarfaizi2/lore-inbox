Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWEMIPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWEMIPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 04:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWEMIPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 04:15:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:61980 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750979AbWEMIPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 04:15:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DHfvqBQuqY1EVGTLKDLjdnWNq1KSjahEU3P+4qiLuZuiBZNkDnPxyRwxo453pfMGy8XHA73Qbx1jNjonX5N1ULAiBNDAPoR6VD8Mmy6GBAZ408IwD4AnDLhoqPvAJgAqhCEHGdztopI8iLsQnirOwawSB+HZB73IUPQRBV9U3/k=
Message-ID: <4465959C.8040906@gmail.com>
Date: Sat, 13 May 2006 17:15:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Stefan Smietanowski <stesmi@stesmi.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com> <44655CF3.5010101@garzik.org> <44658AC3.6070400@gmail.com> <44658C43.8090305@garzik.org>
In-Reply-To: <44658C43.8090305@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tejun Heo wrote:
>>>> Stefan Smietanowski wrote:
>>>>> Randy.Dunlap wrote:
>>>>>>> * New error handling
>>>>>>> * IRQ driven PIO (from Albert Lee)
>>>>>>> * SATA NCQ support
>>>>>>> * Hotplug support
>>>>>>> * Port Multiplier support
>>>>>>
>>>>>> BTW, we often use PM to mean Power Management.
>>>>>> Could we find a different acronym for Port Multiplier support,
>>>>>> such as PMS or PX or PXS?
>>>>>
>>>>> Ok, maybe not PMS ?
>>>>>
>>>>> Can you imagine a bug report from someone that "has problem with PMS"?
>>>>> :)
>>>>>
>>>>
>>>> Would be fun though.  :)
>>>>
>>>> I thought about using another acronym for port multiplier too.  But 
>>>> the spec uses that acronym all over the place, PM, PMP (Port 
>>>> Multiplier Portnumber), which reminds me of USB full/high speed fiasco.
>>>>
>>>> Urghh... I thought we could use power for power management inside 
>>>> libata but that might be a bad idea.  So, PMS?
>>>
>>> PMS is fine.  I encouraged the use of "UFO" for "UDP Fragmentation 
>>> Offload" in network driver land, and it stuck.
>>>
>>> This is Linux, we like to have fun around here :)
>>>
>>
>> Currently, the candidates are...
>>
>> px    : short (good), but I don't know, not pretty
>> pmul    : okay but a bit too long
>> pml    : pretty and official
>> pms    : pretty and fun
>>
>> I think I'll go with either pms or pml.  Man, this decision is difficult.
> 
> To make it more difficult:  Honestly, I prefer Port MultiPlier (PMP), 
> imitating (and perhaps overloading) the acronym used by the standard 
> SATA FIS field.

Ah... I've excluded PMP because I thought it was already taken, but, 
yeah, it wouldn't cause noticeable confusion and fits the best.  I'll 
give PMP a try.

-- 
tejun
