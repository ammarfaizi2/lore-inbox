Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265133AbUGCOos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbUGCOos (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 10:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUGCOos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 10:44:48 -0400
Received: from lucidpixels.com ([66.45.37.187]:1000 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265133AbUGCOoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 10:44:46 -0400
Date: Sat, 3 Jul 2004 10:44:44 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: 4K vs 8K stacks- Which to use?
In-Reply-To: <Pine.LNX.4.44.0407031038310.32173-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.60.0407031043070.13543@p500>
References: <Pine.LNX.4.44.0407031038310.32173-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> does it matter?
Well the option is available :)

> why do you think it would be processor-specific?
Well I know IA32 is limited to a 4096 byte page size in the Linux Kernel; 
hence filesystems can only use 4KB blocks on IA32, therefore I was 
wondering if anything might change in 64bit land?

  On Sat, 3 Jul 2004, Mark 
Hahn wrote:

>> I use an array of machines with all sorts of CPU's (but no 64bit CPU's
>> yet):
>>
>> Which should I use for each CPU?
>
> does it matter?  4k stacks are primarily for benchmark machines
> under high load, where smaller stacks mean more threads available,
> and less chance of failing to allocate two contiguous pages.
>
>> Which is better and why?
>
> can't possibly matter for any normal use.
>
>> Pentium 1 CPU's
>> Cyrix P150 (120MHZ)
>> Pentium 2 CPU's
>> Pentium 3 CPU's
>> Pentium 4 W/HT
>> Pentium 4 W/OUT HT
>
> why do you think it would be processor-specific?
>
