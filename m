Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965087AbWHWRzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965087AbWHWRzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHWRzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:55:48 -0400
Received: from 8.ctyme.com ([69.50.231.8]:1697 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932324AbWHWRzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:55:47 -0400
Message-ID: <44EC9699.3040001@perkel.com>
Date: Wed, 23 Aug 2006 10:55:37 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
Subject: Re: Hardware vs. Software Raid Speed
References: <44EBFB3E.8070905@perkel.com> <44EC02FD.7050207@tomt.net> <44EC94A9.4010903@gmail.com>
In-Reply-To: <44EC94A9.4010903@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tejun Heo wrote:
> Andre Tomt wrote:
>> Marc Perkel wrote:
>>> Running Linux on an AMD AM2 nVidia chip ser that supports Raid 0 
>>> striping on the motherboard. Just wondering if hardware raid (SATA2) 
>
> SATA2 has nothing to do with hardware RAID.
>
>>> is going to be faster that software raid and why?
>>
>> Beeing a consumer type board (AM2), the "raid on the motherboard" is 
>> in 99.999% of the cases just software raid implemented in their 
>> Windows drivers, a bootup setup screen plus some BIOS magic to get 
>> the OS booting.
>
> And, yeah, they're all software RAID.  Also, there isn't much to be 
> gained from making RAID0/1 hardware.  The software overhead isn't that 
> big.  For RAID5, having XOR done in hardware helps.
>

Thanks - I suspected that Raid 0 didn't gain anything in hardware unless 
they provided additional buffering or something but I just thought I'd 
ask in case there was something I was overlooking.
