Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVAAUTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVAAUTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 15:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVAAUTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 15:19:48 -0500
Received: from mail.tmr.com ([216.238.38.203]:39880 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261170AbVAAUTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 15:19:42 -0500
Message-ID: <41D70885.3080208@tmr.com>
Date: Sat, 01 Jan 2005 15:31:01 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: Terry Hardie <terryh@orcas.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4C800-E Deluxe and Intel Pro/1000
References: <41D5C459.8050601@tmr.com><6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com> <Pine.LNX.4.58.0412311715190.3717@orcas.net>
In-Reply-To: <Pine.LNX.4.58.0412311715190.3717@orcas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Hardie wrote:
> On Fri, 31 Dec 2004, Bill Davidsen wrote:
> 
> 
>>Terry Hardie wrote:
>>
>>>Well, this has been plauging me for months, and finally figured it out.
>>>
>>>Any 2.6 kernel on my board, would boot, then give errors (paraphrased,
>>>sorry) when I tried to bring up the ethernet:
>>>
>>>NETDEV WATCHDOG: eth0: transmit timed out
>>>IRQ #18: Nobody cared!
>>>
>>>And no ethernet conectivity.
>>>
>>>The Fix: Update bios from asus' website. I guess their ACPI was screwed
>>>up. This is the second time I've had to update this MB to fix
>>>incompatibilities with Linux. So, watch out with Asus boards on Linux.
>>>
>>>BTW - Linux 2.4's driver worked fine with the old bios. Only 2.6 didn't
>>>work.
>>
>>Some additional info, I've been investigating this for a few hours, and
>>it appears that (a) IRQ 18 on my system is shared by ide0 and ide1, and
>>that the IRQ storm seems to start the first time I use ide1 (DVD only).
>>
>>I will be posting a bunch of dmesg results when/if the system reboots,
>>but acpi={off,ht} doesn't help, pollirq doesn't help, and system
>>shutdown leaves the system unbootable without a full (pull the power
>>cord) hardware power cycle.
>>
>>Questions:
>>1 - do you have trouble rebooting after a failure?
> 
> 
> Since I flashed my bios, no more problems, so I've had no more failures

I hesitate to try that, since the web page says you must use "real DOS" 
and gives instructions for creating the FD using that. Since I lack both 
DOS and a floppy, that does present problems...

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
