Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWHKTBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWHKTBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWHKTBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:01:42 -0400
Received: from rtr.ca ([64.26.128.89]:42404 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750831AbWHKTBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:01:41 -0400
Message-ID: <44DCD411.1020403@rtr.ca>
Date: Fri, 11 Aug 2006 15:01:37 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@www.linux.org.uk,
       davej@redhat.com
Subject: Re: cpufreq stops working after a while
References: <44DCCB96.5080801@rtr.ca> <20060811114631.4a699667.akpm@osdl.org>
In-Reply-To: <20060811114631.4a699667.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Mark Lord <lkml@rtr.ca> wrote:
..
>> I use speedstep-centrino with it, and after boot all is usually okay.
>> But after a few hours of operation, it stops shifting to the highest frequency
>> even under continuous 100% load (or not).  Eventually it gets stuck at 600Mhz
>> and stays there until I reboot.
..
>> WHY?
> 
> cpufreq seems to have relatively frequent problems.
> 
>>  And how can I fix it?
> 
> You could start by telling us which kernel versions are affected ;)

Heh.  2.6.17.6 and 2.6.18-rc3-git4 are the two kernels I have for it,
and both exhibit the problem.

Dave Jones wrote:
>boot with cpufreq.debug=7, and capture dmesg output after it fails

I'll reboot with the debug options and see..

Cheers
