Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbVC3UvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbVC3UvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVC3UvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:51:15 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:53008 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261863AbVC3Us3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:48:29 -0500
Message-ID: <424B109A.90908@tuleriit.ee>
Date: Wed, 30 Mar 2005 23:48:26 +0300
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>, Asfand Yar Qazi <ay1204@qazi.f2s.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com>	<20050324093032.GA14022@havoc.gtf.org>	<20050324162706.GJ17865@csclub.uwaterloo.ca>	<42432A9F.3090507@pobox.com> <m1ekdz3hz0.fsf@muc.de> <424B013B.3010109@pobox.com> <424B0946.8060909@tuleriit.ee> <424B0B38.9060809@pobox.com>
In-Reply-To: <424B0B38.9060809@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Indrek Kruusa wrote:
>
>> Jeff Garzik wrote:
>>
>>> Andi Kleen wrote:
>>>
>>>> Jeff Garzik <jgarzik@pobox.com> writes:
>>>>
>>>>> I won't disagree with your experiences.  For me, outside of one brief
>>>>> moment when the r8169 driver didn't work on Athlon64, it has worked
>>>>> flawlessly for me.
>>>>>
>>>>> RealTek 8169 is currently my favorite gigabit chip.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> It does not seem to support DAC (or rather it breaks with DAC 
>>>> enabled), which makes it not very useful on any machine with >3GB 
>>>> of memory.
>>>
>>>
>>>
>>>
>>> Driver bug.  I can futz with it and get it to do 64-bit on my Athlon64.
>>
>>
>>
>>
>> Continuing with off-topic questions: is this "checksum off-load" 
>> usable with r8169? Is there any other reason (performance?) to use 
>> hardware TCP/IP checksumming than just "cool, a little chunk of 
>> software is hardwired again"?
>
>
> It's usable, and enables "zero copy" feature.
>
>
>> I have seen you mentioned that this causes mainly troubles if you try 
>> to set it with ethtool. Is it still true?
>
>
> Not sure what you are referring to.




Sorry  - my brains interpretation was classic rumor case: discussion I 
remembered was about broken NIC not about enabling hw checksum. I 
referred to this one:

http://www.ussg.iu.edu/hypermail/linux/kernel/0503.3/0369.html


Jeff Garzik wrote:

> Evgeniy Polyakov wrote:
>
>> Noone will complain on Linux if NIC is broken and produces wrong
>> checksum
>> and HW checksum offloading is enabled using ethtools.
>
>
>
> Actually, that is a problem and people have definitely complained 
> about it in the past.



