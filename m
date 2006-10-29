Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWJ2EFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWJ2EFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 00:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWJ2EFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 00:05:19 -0400
Received: from 8.ctyme.com ([69.50.231.8]:58276 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S964987AbWJ2EFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 00:05:18 -0400
Message-ID: <4544287C.409@perkel.com>
Date: Sat, 28 Oct 2006 21:05:16 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Problem - Asus A8N-VM CSM
References: <1449F58C868D8D4E9C72945771150BDF153767@SAUSEXMB1.amd.com> <454236C0.2070805@perkel.com> <4543E457.80203@tmr.com>
In-Reply-To: <4543E457.80203@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:
> Marc Perkel wrote:
>>
>>
>> Langsdorf, Mark wrote:
>>>>> The problem. 2 out of the 4 sees all 4 gigs of ram. The other 2 
>>>>> see only 2.8 gigs of ram. And it's hardware related because in the 
>>>>> bios setup the ones that show 2.8 show it in the bios.
>>>>>
>>>>> The motherboards were not prchased at the same time. All have 
>>>>> different brands of ram. And the processors are different. The 2 
>>>>> that don't see all the ram are the newest ones.
>>>>>
>>>>> I tried swapping ram between one that saw 2.8 gigs and one that 
>>>>> saw 4 gigs and the problem stays with the motherboard.
>>>>> I haven't yet swapped out the processors.
>>>>>
>>>>> So - I'm a little stumped. Can someone point me in the right 
>>>>> direction?
>>>>>       
>>>
>>> Usually, missing memory comes from the PCI I/O hole, or the
>>> IOMMU/AGP/framebuffer overlays.  Does your BIOS have an
>>> options for creating a memory hole or hoisting memory?  If
>>> so, are the settings between the 4G machines different from
>>> the 2.8G machines?
>>>
>>> Also, do you have an IOMMU aperture enabled and if so, how
>>> large?
>>>
>>> Are there any hardware differences between the systems, like
>>> different AGP or PCI graphics cards?
>>>
>>>  
>>>> Answering my own question perhaps. Could it be related to whether 
>>>> or not the processor is a "revision e" chip?
>>>>     
>>>
>>> Possibly, but I'd expect the RevE parts to see more DRAM than
>>> the earlier parts.
>>>
>>>
>>>   
>>
>> I fixed the problem. It wasn't a Revision E issue after all. I just 
>> pulled the battery and when it came up clean it saw all the memory. 
>> Thanks for your help.
>>
> Would have been interesting to use the "reset to factory defaults" 
> option, just to see if some bit isn't set to known state doing that.
>

Actually that's what it tuened out to be. It had nothing to do with 
Revision E.
