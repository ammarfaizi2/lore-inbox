Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbWH1KuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbWH1KuV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWH1KuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:50:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:41691 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S964788AbWH1KuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:50:19 -0400
Message-ID: <44F2C9A3.3090608@aitel.hist.no>
Date: Mon, 28 Aug 2006 12:46:59 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Aleksey Gorelov <dared1st@yahoo.com>
CC: jengelh@linux01.gwdg.de, daniel.rodrick@gmail.com,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, satinder.jeet@gmail.com
Subject: Re: Generic Disk Driver in Linux
References: <20060825170513.60108.qmail@web83113.mail.mud.yahoo.com>
In-Reply-To: <20060825170513.60108.qmail@web83113.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksey Gorelov wrote:
> --- Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
>   
>> Aleksey Gorelov wrote:
>>     
>>>> From: linux-kernel-owner@vger.kernel.org 
>>>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan Engelhardt
>>>>     
>>>>         
>>>>> I was curious that can we develop a generic disk driver that could
>>>>> handle all the kinds of hard drives - IDE, SCSI, RAID et al?
>>>>>       
>>>>>           
>>>> ide_generic
>>>> sd_mod
>>>>
>>>> All there, what more do you want?
>>>>     
>>>>         
>>> Unfortunately, not _all_. DMRAID does not support all fake raids yet. Moreover, there is
>>>       
>> usually
>>     
>>> some gap for bleeding edge hw support.
>>>   
>>>       
>> Nobody will want to use bleeding edge hardware with an int13 driver,
>> because the performance will necessarily be much worse than using more
>> moderate hardware with the generic IDE driver.
>>     
> If some one wants Linux server - I totally agree. I would probably even avoid relying purely on
> generic IDE and instead use chipset specific variant or libata.
> But if someone wants to access already installed & working other OS stuff - that's a different
> story. Bad performance is still better than no support at all.
>   
Yes, there is forensics, and there is the copying of data when
migrating a server to linux from some other OS. 

Perhaps I worry too much - I imagine salesmen claiming linux
support for their raid cards, because the int13 driver works. 
Just like they claim "linux support" with abominations like ndiswrapper.
The bad effects may be carefully hidden with "disk" tests that are
smaller than main memory in some huge-memory machine.

Then linux gets a bad reputation among ignorant purchasers,
performance went so much up with some other os .  . .

Helge Hafting

