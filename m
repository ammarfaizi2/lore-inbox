Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVLDWhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVLDWhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 17:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLDWhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 17:37:23 -0500
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:11727 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932369AbVLDWhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 17:37:23 -0500
Message-ID: <43936FA0.4040409@bigpond.net.au>
Date: Mon, 05 Dec 2005 09:37:20 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.1.5 for 2.6.14, 2.6.15-rc2 and 2.6.15-rc2-mm1
References: <438648F5.2010706@bigpond.net.au> <438E8C8C.7030304@bigpond.net.au> <438F7F2E.3080300@bigpond.net.au>
In-Reply-To: <438F7F2E.3080300@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sun, 4 Dec 2005 22:37:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Peter Williams wrote:
> 
>> Peter Williams wrote:
>>
>>> This version has a modified (hopefully improved) configuration 
>>> mechanism.
>>>
>>> A patch for 2.6.15-rc2-mm1 is available at:
>>>
>>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.5-for-2.6.15-rc2-mm1.patch?download> 
>>>
>>>
>>> and a patch to upgrade the 6.1.4 versions for 2.6.14 and 2.6.15-rc2 
>>> to 6.1.5 is available at:
>>>
>>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.4-to-6.1.5-for-2.6.15-rc2.patch?download> 
>>>
>>>
>>> Very Brief Documentation:
>>>
>>> You can select a default scheduler at kernel build time.  If you wish to
>>> boot with a scheduler other than the default it can be selected at boot
>>> time by adding:
>>>
>>> cpusched=<scheduler>
>>>
>>> to the boot command line where <scheduler> is one of: ingosched,
>>> nicksched, staircase, spa_no_frills, spa_ws, spa_svr or zaphod.  If you
>>> don't change the default when you build the kernel the default scheduler
>>> will be ingosched (which is the normal scheduler).
>>>
>>> The scheduler in force on a running system can be determined by the
>>> contents of:
>>>
>>> /proc/scheduler
>>>
>>> Control parameters for the scheduler can be read/set via files in:
>>>
>>> /sys/cpusched/<scheduler>/
>>>
>>> Peter
>>
>>
>>
>> Patches for 2.6.15-rc3 available at:
>>
>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.5-for-2.6.15-rc3.patch?download> 
> 
> 
> 
> This patch will also successfully apply to 2.6.15-rc4.

And 2.6.15-rc5.

> 
>>
>>
>> and 2.6.15-rc3-mm1 at:
>>
>> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.1.5-for-2.6.15-rc3-mm1.patch?download> 
>>
>>
> 
> 


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
