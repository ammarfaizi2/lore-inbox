Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265743AbUHVCgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265743AbUHVCgS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265668AbUHVCgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:36:18 -0400
Received: from liberty.phpwebhosting.com ([69.0.209.130]:39630 "HELO
	liberty.phpwebhosting.com") by vger.kernel.org with SMTP
	id S265743AbUHVCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:36:16 -0400
Message-ID: <41283EDA.6080501@dastyle.net>
Date: Sun, 22 Aug 2004 02:36:10 -0400
From: Jonathan Bastien-Filiatrault <joe@dastyle.net>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.7.2) Gecko/20040819 Debian/1.7.2-3
X-Accept-Language: en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: Lee Revell <rlrevell@joe-job.com>, Wakko Warner <wakko@animx.eu.org>,
       "David N. Welton" <davidw@dedasys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Incompatibility List
References: <87r7q0th2n.fsf@dedasys.com>	 <20040821201632.GA7622@digitasaru.net> <20040821202058.GA9218@animx.eu.org> <1093120274.854.145.camel@krustophenia.net> <41282F4C.9060305@dastyle.net> <4127FD5A.90605@superbug.demon.co.uk>
In-Reply-To: <4127FD5A.90605@superbug.demon.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:

> Jonathan Bastien-Filiatrault wrote:
>
>>>
>> Vendors should understand that ACTUALLY supporting linux means 
>> adopting the free software philosophy. In many cases, vendors think 
>> that they should be the only one to be able to write drivers, since 
>> 99% of desktop users dont care about their software freedom. Vendors 
>> should not try to obscure the workings of their devices, they should 
>> show the world how they are innovating in hardware design by 
>> releasing specs on a freely-redistributable basis. This would greatly 
>> improve competiveness and innovation in the domain of hardware 
>> design. Give me a binary driver and i will  buy from you once, give 
>> me the specs and i'll appreciate the effort you put in designing the 
>> device.
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
> I remember a computer from pre ibm-pc days. It came with a manual that 
> included a detailed circuit diagram, so the user could make any 
> repairs they wished. It also gave details regarding CPU instruction 
> set, and memory layout, so that anyone could write any OS they liked 
> for it.

My dad had a thing like that(quick reference card) for an old motorola 
6800(not 68000) processor. It only had 2 8-bit general purpose registers 
if I remember correctly. Doesn't even begin to compare with modern ppc 
processors.

>  
> If we do create a nice long list, we should also include Linux 
> compatible hardware as well.
> E.g. Latest XYZ laptop, it would list all the chips in the laptop, 
> together with what level of support linux has for each one.
> The problem comes with actually identifying the parts.
> For example, Creative have lots of different sound cards, all called 
> the  SB Live, but they all have very different chips in them, with 
> some supported by linux, and some not. Don't you just love those 
> Marketing people. :-(
> We can use PCI IDs and PCI subsystem IDs, to identify Motherboards, 
> and PCI cards. We might also have to identify revision numbers.
> We can use USB IDs to identify USB devices.

Good idea, we should have something like two lists one for "chips" and 
one for "containers of chips" aka whole systems. That way it could be 
cross-referenced in a database-like way with a nice gtk frontend. The 
project probably ressemble the pci-ids project. That would pave the way 
for a free(as in speech) hardware purchasing guide.
