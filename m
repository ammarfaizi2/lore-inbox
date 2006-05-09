Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWEIOo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWEIOo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWEIOo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:44:26 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:52813 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751038AbWEIOoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:44:25 -0400
Message-ID: <4460AAC5.8090703@atipa.com>
Date: Tue, 09 May 2006 09:44:21 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Madhukar Mythri <madhukar.mythri@wipro.com>
CC: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: How to read BIOS information
References: <445F5228.7060006@wipro.com> <1147099994.2888.32.camel@laptopd505.fenrus.org> <445F5DF1.3020606@wipro.com> <1147101329.2888.39.camel@laptopd505.fenrus.org> <445F63B3.2010501@wipro.com> <20060508152659.GG1875@harddisk-recovery.com> <4460273E.5040608@wipro.com>
In-Reply-To: <4460273E.5040608@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2006 14:36:02.0403 (UTC) FILETIME=[E56B7330:01C67375]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Madhukar Mythri wrote:
> Erik Mouw wrote:
> 
>> On Mon, May 08, 2006 at 08:58:51PM +0530, Madhukar Mythri wrote:
>>  
>>
>>> I forgot mention, that my Kernel is NONSMP based kernel....
>>>   
>>
>> Then your application can't use HT anyway, so why bother?
>>
>>
>> Erik
>>
>>  
>>
>  yeah, your are correct. but, the thing is my superiors want, even if 
> kernel not reconize/use HT, we have to capture it from BIOS...
> Thats why i asked as, how to read BIOS information?
> 
> 

Each motherboard/bios *VERSION* can and sometimes does change the location
of the internal bits that define what and where each bios setting is.

I know upgrading major bios version on a motherboard will often leave
the motherboard needing a full cmos clear because what the bits mean
changed and the new usage of the bits does not allow the motherboard
to post.

I don't believe that they actually document the internal settings, and
even if they did, the number of motherboard/bios combinations is way
too high for it to work easily.

This is why there (in general) are no programs that change the bios
settings from the OS, there is no general solution that works for all,
and there are too many combinations, and too little documentation.

                          Roger
