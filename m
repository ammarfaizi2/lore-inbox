Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267666AbTAHCHl>; Tue, 7 Jan 2003 21:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267667AbTAHCHk>; Tue, 7 Jan 2003 21:07:40 -0500
Received: from barry.mail.mindspring.net ([207.69.200.25]:16141 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267666AbTAHCHg>; Tue, 7 Jan 2003 21:07:36 -0500
Message-ID: <3E1B8A19.6070602@emageon.com>
Date: Tue, 07 Jan 2003 20:16:57 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell Leighton <russ@elegant-software.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: long stalls
References: <3E1B73F3.2070604@emageon.com> <3E1B8439.8040209@elegant-software.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Out of curiosity, which RH kernel are you using? I moved on to 2.4.19 
and 2.4.20 primarily because the RH 2.4.18 series of kernels apparently 
has a scheduler bug (at least one) that causes the heartbeat software 
from Linux-HA to loose heartbeat signals and failover. Not a good 
scenario when you are trying to provide HA systems to hospitals!


Russell Leighton wrote:

>
> I can't help, but I can echo a "me too".
>
> We only see it when I have 2 file I/O intensive processes...they both 
> will just stop for some few seconds, system seems idle...then
> they just start again. RH7.3 SMP, Dual PIII, 4GB RAM, 3com RAID 
> Controller .
>
> Brian Tinsley wrote:
>
>> We have been having terrible problems with long stalls, meaning from 
>> a couple of minutes to an hour, happening when filesystem I/O load 
>> gets high. The system time as reported by vmstat or sar will increase 
>> up to 99% and as it spreads to each procesor, the system becomes 
>> completely unresponsive (except that it responds to pings just fine - 
>> interesting!). When the system finally returns to the world of the 
>> living, the only evidence that something bad has happened is the 
>> runtime for kswapd is abnormally high. I have seen this happen with 
>> the stock 2.4.17, 2.4.19, and 2.4.20 kernels on SMP PIII and PIV 
>> machines (either 4GB or 8GB RAM, all SCSI disks, dual GigE NICs). 
>> I've searched the lkml archives and google and have found several 
>> similar postings, but there is never an explanation or resolution. 
>> Any help would be *very* much appreciated! If any info from the 
>> system in question is desired, I will be glad to provide it.
>>
>>
>>
>

-- 

-[========================]-
-[      Brian Tinsley     ]-
-[ Chief Systems Engineer ]-
-[        Emageon         ]-
-[========================]-



