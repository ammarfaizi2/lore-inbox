Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUATRHd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUATRHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:07:33 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:19226 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S265581AbUATRH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:07:29 -0500
Message-ID: <3E132023.10206@mindspring.com>
Date: Wed, 01 Jan 2003 09:06:43 -0800
From: manu <hislen@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugo Mills <hugo-lkml@carfax.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: SiI2112 + Seagate + nFroce2: no DMA!
References: <3E1282EF.30300@mindspring.com> <20040120085800.GB31330@carfax.org.uk>
In-Reply-To: <20040120085800.GB31330@carfax.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wonderful, so there is hope!

Yep my date was wrong because I was just coming back from flashing the 
BIOS with a new version and clearing CMOS, which did not change a darn 
thing and pushed me to send this mail :-)

RedHat seems to be releasing relatively old kernel so (what I have is 
the latest from them), must say I never paid attention to it, now I will.

Thanks so much,

Emmanuel.

Hugo Mills wrote:

>On Tue, Dec 31, 2002 at 09:55:59PM -0800, manu wrote:
>
>   Incidentally, did you know that the date on your computer is very,
>very wrong?
>
>  
>
>>I'm about to give up on my SATA drive as I can't get it to work properly.
>>So I thought I may try asking the experts before falling back to PATA.
>>
>>I have seen many mails reporting the same issue, some of them 6-month old:
>>
>>- SATA drive comes up in pio mode, not in dma
>>- trying to turn on dma with hdparm is a nightmare: I/O errors, crash 
>>with data corruption... I tried both:
>>
>> hddarm -d1 /dev/hde
>>
>>and:
>>
>> hdparm -u1 -c3 -d1 -X66 /dev/hde
>>
>>crash in both cases :-((
>>
>>
>>Here's my equipment:
>>
>>
>>ABIT AN7 motherboard (nForce2 chipset, SiI3112 SATA controller)
>>AMD Athlon XP 2600+ (+ 512 DDR / 400 MHz)
>>SATA HD Seagate Barracuda 160 Gb
>>
>>The SATA HD is my only drive. The only thing connected to my IDE 
>>controllers is a DVD/CD combo.
>>
>>Running Linux Redhat 9.0
>>kernel 2.4.20-28.9
>>    
>>
>  ^^^^^^^^^^^^^^^^^^
>   This is your problem. There have been a number of bug-fixes to the
>SiI drivers since 2.4.20. Try it again with a newer kernel -- such as
>2.4.24.
>
>  
>
>>I've been googling for days now and could not come accross a solution, 
>>on the contrary I came under the impression that the combination of 
>>SiI3112 +and Seagate was doomed.
>>    
>>
>
>   Not so. I have a SiI3112 controller and a 120GiB Seagate drive, and
>they work very well together. I'm using 2.6.1, although 2.4.23 also
>worked well for me.
>
>[snip]
>  
>
>>Isn't there a solution??
>>
>>I am willing to try patches of experimental code. At this point I am 
>>looking at reinstalling everything on a PATA drive anyway, so  I have 
>>nothing to loose.
>>    
>>
>
>   Try using 2.4.24 or 2.6.1.
>
>   Hugo.
>
>  
>


