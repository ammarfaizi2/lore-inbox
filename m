Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267646AbTAHBtO>; Tue, 7 Jan 2003 20:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbTAHBtK>; Tue, 7 Jan 2003 20:49:10 -0500
Received: from smtp.comcast.net ([24.153.64.2]:64993 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S267646AbTAHBtI>;
	Tue, 7 Jan 2003 20:49:08 -0500
Date: Tue, 07 Jan 2003 20:51:53 -0500
From: Russell Leighton <russ@elegant-software.com>
Subject: Re: long stalls
To: Brian Tinsley <btinsley@emageon.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3E1B8439.8040209@elegant-software.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9)
 Gecko/20020311
References: <3E1B73F3.2070604@emageon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't help, but I can echo a "me too".

We only see it when I have 2 file I/O intensive processes...they both 
will just stop for some few seconds, system seems idle...then
they just start again. RH7.3 SMP, Dual PIII, 4GB RAM, 3com RAID Controller .

Brian Tinsley wrote:

> We have been having terrible problems with long stalls, meaning from a 
> couple of minutes to an hour, happening when filesystem I/O load gets 
> high. The system time as reported by vmstat or sar will increase up to 
> 99% and as it spreads to each procesor, the system becomes completely 
> unresponsive (except that it responds to pings just fine - 
> interesting!). When the system finally returns to the world of the 
> living, the only evidence that something bad has happened is the 
> runtime for kswapd is abnormally high. I have seen this happen with 
> the stock 2.4.17, 2.4.19, and 2.4.20 kernels on SMP PIII and PIV 
> machines (either 4GB or 8GB RAM, all SCSI disks, dual GigE NICs). I've 
> searched the lkml archives and google and have found several similar 
> postings, but there is never an explanation or resolution. Any help 
> would be *very* much appreciated! If any info from the system in 
> question is desired, I will be glad to provide it.
>
>
>


