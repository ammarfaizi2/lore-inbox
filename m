Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUBRNti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267029AbUBRNti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:49:38 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:7638 "EHLO
	gaimboi.tmr.com") by vger.kernel.org with ESMTP id S266807AbUBRNtg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:49:36 -0500
Message-ID: <4033691F.7070804@tmr.com>
Date: Wed, 18 Feb 2004 08:31:11 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: JG <jg@cms.ac>, linux-kernel@vger.kernel.org
Subject: Re: could someone plz explain those ext3/hard disk errors
References: <20040209095227.AF4261A9ACF@23.cms.ac> <200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
>>now...hm, it all started when i upgraded from kernel 2.4.19 to 2.6.0
>>in late decemeber, the system worked very fine for a week or so
>>(having great response times!) but then all of a sudden the problems
>>started. 2 disks died. then my gigabit network card was only able to
>>transmit 200kb/s (but this was really a hardware problem, a new card
>>is working fine again, well...). a week later the next disks are
>>having problems and i have yet to RMA three disks. and now the next
>>two disks..., i'm getting insane ;) i can't see any EXT3 error anymore
>>*g* the next disks will be reiserfs only to see other error messages
>>;) well, but that doesn't solve the problem of 6 disks within 2
>>months...this is so unlikely.
> 
> 
> Please read the FAQ, fix your mail application - you are sending long
> lines, and don't break the CC list.
> 
> As to your problem, look at the LBA sector addresses in the error
> message:
> 
> 280923064991615
> 
> is your drive really over 100 EB?  No...

I think we could assume that (a) he never told the kernel the disk was 
"over 100 EB" and (b) the kernel was trying to use that LBA anyway. 
Which could be due to either a kernel bug or memory corruption (or CPU 
problems, but unlikely).

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
