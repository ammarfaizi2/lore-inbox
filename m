Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932593AbWF3MwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbWF3MwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWF3MwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:52:04 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:57478 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932596AbWF3MwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:52:02 -0400
Message-ID: <44A51D88.70608@aitel.hist.no>
Date: Fri, 30 Jun 2006 14:48:08 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm one process gets stuck in infinite loop in the kernel.
References: <20060629013643.4b47e8bd.akpm@osdl.org>	<44A3B8A0.4070601@aitel.hist.no> <20060629104117.e96df3da.akpm@osdl.org>
In-Reply-To: <20060629104117.e96df3da.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 29 Jun 2006 13:25:20 +0200
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
>   
>> I have seen this both with mm2, m33 and mm4.
>>     
Correction, m22 and mm3 only so far.
>> Suddenly, the load meter jumps.
>> Using ps & top, I see one process using 100% cpu.
>> This is always a process that was exiting, this tend to happen
>> when I close applications, or doing debian upgrades which
>> runs lots of short-lived processes.
>>
>> I believe it is running in the kernel, ps lists it with stat "RN"
>> and it cannot be killed, not even with kill -9 from root.
>>
>> Something wrong with process termination?
>>
>>     
>
> Please generate a kernel profile when it happens so we can see
> where it got stuck.
>
> <boot with profile=1>
> <wait for it to happen>
>   
Unfortunately, I could not provoke it with profile=1.
At least, deinstalling and reinstalling texlive
a few times was not enough. 

If it bothers me more, I'll try to find a better way to reproduce it.
If it don't happen again, lets hope it was a hw hiccup.

Helge Hafting
