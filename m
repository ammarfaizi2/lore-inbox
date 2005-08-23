Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVHWBtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVHWBtb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 21:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbVHWBtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 21:49:31 -0400
Received: from dns1.rivernet.net ([216.94.106.2]:57309 "EHLO dns1.rivernet.net")
	by vger.kernel.org with ESMTP id S1751131AbVHWBta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 21:49:30 -0400
Message-ID: <000401c5a784$dc23e9f0$6301a8c0@finian.net>
From: "Terry" <tmacmill@rivernet.net>
To: "Douglas McNaught" <doug@mcnaught.org>
Cc: <linux-kernel@vger.kernel.org>
References: <001001c5a6c9$7a0e1df0$6301a8c0@finian.net> <m23bp11r38.fsf@Douglas-McNaughts-Powerbook.local>
Subject: Re: PROBLEM: Incorrect RAM Detected at kernel init
Date: Mon, 22 Aug 2005 21:49:11 -0400
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have not been able to get the memory hole turned off at the 16M mark
Going through some of the Documentation files, I noticed that I can specify 
a ram map with the mem boot option. I know the mem=768M hasn't worked, so 
what about trying the memory map option? Could that be a solution to my 
problem? If so, what would be the proper way to put the command?
As well I have downloaded the 2.4.18 kernel and in the latest distro of 
Slackware, 10.1, it doesn't want to compile, I can't remember the exact 
error, but it was referenced back to one of the asm headers as the problem. 
I will dig that error up and maybe post based on that to get that kernel 
running.
As well, going to a 2.6 kernel just in not overly feasable at this time as 
it takes 24 hrs to compile with the state the machine is in right now.

Terry
----- Original Message ----- 
From: "Douglas McNaught" <doug@mcnaught.org>
To: "Terry" <tmacmill@rivernet.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, August 22, 2005 7:36 PM
Subject: Re: PROBLEM: Incorrect RAM Detected at kernel init


> "Terry" <tmacmill@rivernet.net> writes:
>
>> The kernel appears to compile perfectly, installs fine, but after reboot 
>> it
>> is only reporting 16M of RAM. I have tried with and without the mem=768M
>
> I've seen this happen with BIOSes of your vintage when there's a
> "memory hole at 16M" turned on--the kernel doesn't see anything beyond
> it.  See if you can get into the Setup program and turn that off.
>
> Since earlier kernels work, the later kernels are probably trusting
> the e820 tables which may not be set up properly...
>
> [Not that I know that much about this stuff]
>
> -Doug
>
>
>
> -- 
> No virus found in this incoming message.
> Checked by AVG Anti-Virus.
> Version: 7.0.338 / Virus Database: 267.10.13/78 - Release Date: 8/19/2005
>
> 



-- 
No virus found in this outgoing message.
Checked by AVG Anti-Virus.
Version: 7.0.338 / Virus Database: 267.10.13/78 - Release Date: 8/19/2005

