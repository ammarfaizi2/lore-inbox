Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265306AbTLHCtz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbTLHCtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:49:55 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:63242 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265306AbTLHCtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:49:52 -0500
Message-ID: <3FD3EB1A.2060600@nishanet.com>
Date: Sun, 07 Dec 2003 22:08:10 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>	 <3FD1199E.2030402@gmx.de> <1070669706.3987.4.camel@athlonxp.bradney.info>	 <3FD12114.7080505@gmx.de> <1070671068.3972.6.camel@athlonxp.bradney.info>
In-Reply-To: <1070671068.3972.6.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>On Sat, 2003-12-06 at 01:21, Prakash K. Cheemplavam wrote:
>  
>
>>Craig Bradney wrote:
>>    
>>
>>>On Sat, 2003-12-06 at 00:49, Prakash K. Cheemplavam wrote:
>>>
>>>      
>>>
>>>>Hi,
>>>>
>>>>*maybe* I found the bugger, at least I got APIC more stable (need to 
>>>>test whether oit is really stable, compiling kernel right now...):
>>>>
>>>>It is a problem with CPU disconnect function. I tried various parameters 
>>>>in bios and turned cpu disconnect off, and tada, I could do several 
>>>>subsequent hdparms and machine is running! As CPU disconnect is a ACPI 
>>>>state, if I am not mistkaen, I think there is something broken in ACPI 
>>>>right now or in APIC and cpu disconnect triggers the bug.
>>>>
>>>>Maybe now my windows environment is stable, as well. It was much more 
>>>>stable with cpu disconnect and apic, nevertheless seldomly locked up.
>>>>
>>>>
>>>>So gals and guys, try disabling cpu disconnect in bios and see whether 
>>>>aopic now runs stable.
>>>>        
>>>>
>>>      
>>>
>>>>I have an Abit NF7-S Rev2.0 with Bios 2.0.
>>>>        
>>>>
>>>      
>>>
>>>>Prakash
>>>>        
>>>>
>>>I rebooted and checked in my BIOS, I dont seem to have "CPU Disconnect"?
>>>Is there another name. I also downloaded the motherboard manual for your
>>>NF7-S and cant find it there either?
>>>      
>>>
>>th efull name should be "CPU Disconnect Function". it is an the page 
>>with "enhanced pci performance", "enable system bios caching" ".. video 
>>bios caching" and all the spread spectrums. I have forgotten the name of 
>>that page in the main menu. Should the 3 or 4 in the first column.
>>
>>Perhaps your BIOS is too old. I remember it only came with 1.8 (or 
>>alike) and later. But usually this setting should be disabled at default.
>>
>>My machine still hasn't locked, btw. :-)
>>    
>>
>
>
>Sounds great.. maybe you have come across something. Yes, the CPU
>Disconnect function arrived in your BIOS in revision of 2003/03/27
>"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset
>does not support C2 disconnect; thus, disable C2 function."
>
>For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can
>see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS
>that has been discussed.
>
>Craig
>
I don't have that in MSI K7N2 MCP2-T near the
agp and fsb spread spectrum items or anywhere
else.

