Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWJ1XOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWJ1XOm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJ1XOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 19:14:42 -0400
Received: from mail.tmr.com ([64.65.253.246]:10432 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S964911AbWJ1XOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 19:14:41 -0400
Message-ID: <4543E457.80203@tmr.com>
Date: Sat, 28 Oct 2006 19:14:31 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hardware Problem - Asus A8N-VM CSM
References: <1449F58C868D8D4E9C72945771150BDF153767@SAUSEXMB1.amd.com> <454236C0.2070805@perkel.com>
In-Reply-To: <454236C0.2070805@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> 
> 
> Langsdorf, Mark wrote:
>>>> The problem. 2 out of the 4 sees all 4 gigs of ram. The other 2 see 
>>>> only 2.8 gigs of ram. And it's hardware related because in the bios 
>>>> setup the ones that show 2.8 show it in the bios.
>>>>
>>>> The motherboards were not prchased at the same time. All have 
>>>> different brands of ram. And the processors are different. The 2 
>>>> that don't see all the ram are the newest ones.
>>>>
>>>> I tried swapping ram between one that saw 2.8 gigs and one that saw 
>>>> 4 gigs and the problem stays with the motherboard.
>>>> I haven't yet swapped out the processors.
>>>>
>>>> So - I'm a little stumped. Can someone point me in the right direction?
>>>>       
>>
>> Usually, missing memory comes from the PCI I/O hole, or the
>> IOMMU/AGP/framebuffer overlays.  Does your BIOS have an
>> options for creating a memory hole or hoisting memory?  If
>> so, are the settings between the 4G machines different from
>> the 2.8G machines?
>>
>> Also, do you have an IOMMU aperture enabled and if so, how
>> large?
>>
>> Are there any hardware differences between the systems, like
>> different AGP or PCI graphics cards?
>>
>>  
>>> Answering my own question perhaps. Could it be related to whether or 
>>> not the processor is a "revision e" chip?
>>>     
>>
>> Possibly, but I'd expect the RevE parts to see more DRAM than
>> the earlier parts.
>>
>>
>>   
> 
> I fixed the problem. It wasn't a Revision E issue after all. I just 
> pulled the battery and when it came up clean it saw all the memory. 
> Thanks for your help.
> 
Would have been interesting to use the "reset to factory defaults" 
option, just to see if some bit isn't set to known state doing that.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
