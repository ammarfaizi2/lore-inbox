Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWHRKc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWHRKc6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWHRKc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:32:58 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:34317 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751346AbWHRKc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:32:57 -0400
Message-ID: <44E596E1.3070201@shadowen.org>
Date: Fri, 18 Aug 2006 11:30:57 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4-mm1
References: <20060813012454.f1d52189.akpm@osdl.org> <44DF10DF.5070307@gmail.com> <20060813121126.b1dc22ee.akpm@osdl.org> <62F8B56A.8000908@gmail.com> <20060817122248.GA16927@rhlx01.fht-esslingen.de>
In-Reply-To: <20060817122248.GA16927@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi,
> 
> On Sun, Aug 14, 2022 at 10:42:18AM +0200, Maciej Rutecki wrote:
>> Andrew Morton napisa??(a):
>>> Please always do reply-to-all.
>>>
>> Sorry.
>>
>>>
>>> Could be i8042-get-rid-of-polling-timer-v4.patch.  Please try the below
>>> reversion patch, on top of rc4-mm1, thanks.
>>>
>>>
>> Thanks for help.
>>
>> I try this patch, keyboard works, but I have other problem. When I try:
>>
>> echo "standby" > /sys/power/state
>>
>> system goes to standby, but keyboard stop working and CMOS clock was
>> corrupted (randomize date and time e.g. Fri Feb 18 2028 13:57:43). So I
>> must reset computer.
> 
> Thou shalt Not enable no dangerous CMOS corrupting suspend debugging configs ;)
> 
> No idea whether "corrupting" the CMOS content with suspend debugging data
> has any influence on the keyboard resume, though, but it could easily have.

If my memory is working correctly, the CMOS and keyboard etc are all out 
there on that primative (XC?) bus, off a sort of ISA spur, off the first 
PCI bus?  So they may be 'near' in address terms.

Anyone got one of those old diagrams?

-apw
