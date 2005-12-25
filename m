Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVLYP6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVLYP6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 10:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVLYP6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 10:58:19 -0500
Received: from lucidpixels.com ([66.45.37.187]:48868 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750858AbVLYP6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 10:58:18 -0500
Date: Sun, 25 Dec 2005 10:58:14 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jeff Garzik <jgarzik@pobox.com>
cc: gcoady@gmail.com, Ed Tomlinson <edt@aei.ca>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
In-Reply-To: <43AEC119.8080109@pobox.com>
Message-ID: <Pine.LNX.4.64.0512251058020.11577@p34>
References: <Pine.LNX.4.64.0512241830010.2700@p34> <43ADDD34.9020101@rtr.ca>
 <200512250937.55140.edt@aei.ca> <43AEB0CB.20403@pobox.com>
 <sfftq1lhi7dvugooro7mjthksiqc6j8mg0@4ax.com> <43AEC119.8080109@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it was my error..


On Sun, 25 Dec 2005, Jeff Garzik wrote:

> Grant Coady wrote:
>> On Sun, 25 Dec 2005 09:46:35 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
>> 
>> 
>>> Ed Tomlinson wrote:
>>> 
>>>> On Saturday 24 December 2005 18:43, Mark Lord wrote:
>>>> 
>>>> 
>>>>>> smartmontools is going to have to be updated
>>>>> 
>>>>> What for?
>>>>> 
>>>>> Use "smartctl -d ata /dev/sda"
>>>> 
>>>> 
>>>> Its not perfect:
>>>> 
>>>> grover:/poola/home/ed# smartctl -d ata /dev/sda
>>>> smartctl version 5.34 [x86_64-unknown-linux-gnu] Copyright (C) 2002-5 
>>>> Bruce Allen
>>>> Home page is http://smartmontools.sourceforge.net/
>>>> 
>>>> smartctl has problems but hddtemp works
>>> 
>>> What are the problems?  Your output gives us no clue...
>> 
>> 
>> That _is_ the clue, no output ;) 
>
> Perhaps if the poster provided a useful command line to smartctl, it would do 
> useful work.
>
> If you don't provide a command to smartctl, it won't do much of anything:
>
>> [jgarzik@sata ~]$ sudo smartctl  /dev/hda1
>> smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce 
>> Allen
>> Home page is http://smartmontools.sourceforge.net/
>
>> [jgarzik@sata ~]$ sudo smartctl -d ata /dev/sda1
>> smartctl version 5.33 [i386-redhat-linux-gnu] Copyright (C) 2002-4 Bruce 
>> Allen
>> Home page is http://smartmontools.sourceforge.net/
>
> Regards,
>
> 	Jeff
>
>
