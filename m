Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUIIPFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUIIPFw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUIIPFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:05:52 -0400
Received: from a.smtp.visualtech.com ([208.16.19.9]:59777 "EHLO
	chons.visualtech.com") by vger.kernel.org with ESMTP
	id S265477AbUIIPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:05:44 -0400
Message-ID: <41407134.4030606@voicenet.com>
Date: Thu, 09 Sep 2004 11:05:24 -0400
From: Adam K Kirchhoff <adamk@voicenet.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam K Kirchhoff <adamk@voicenet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: irq 26: nobody cared!
References: <Pine.LNX.4.58.0409081726530.1820@thorn.ashke.com> <1094682284.12336.21.camel@localhost.localdomain> <41403848.7020305@voicenet.com>
In-Reply-To: <41403848.7020305@voicenet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam K Kirchhoff wrote:

> Alan Cox wrote:
>
>> On Mer, 2004-09-08 at 22:35, Adam K Kirchhoff wrote:
>>  
>>
>>> I have a dual P3 system (via motherboard) with 1.5 gigs of RAM (with
>>> highmem enabled in the kernel).  Under heavy networking load, I get the
>>> following error:
>>>   
>>
>>
>> Try variously turning off acpi and the apic. If the routing tables are
>> still shot try the irqfixup patch I posted, it might well rescue your
>> box.
>>
>>  
>>
>
> Booting with 'noapic' seems to have solved the problem.  At least my 
> attempts to replicate it so far (copying a large directory over nfs) 
> hasn't produced the same error.
>
> Thanks for the help, Alan!
>
> Adam
>
>

Actually, it looks like *enabling* ACPI (which had previously been 
disabled) and enabling the APIC gets it working properly as well.

Adam
