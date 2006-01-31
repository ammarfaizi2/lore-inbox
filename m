Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAaRqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAaRqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWAaRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:46:12 -0500
Received: from war.OCF.Berkeley.EDU ([192.58.221.244]:54956 "EHLO
	war.OCF.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751302AbWAaRqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:46:11 -0500
Date: Tue, 31 Jan 2006 09:45:47 -0800 (PST)
From: chris perkins <cperkins@OCF.Berkeley.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rt16
In-Reply-To: <1138646561.7088.1.camel@localhost.localdomain>
Message-ID: <Pine.SOL.4.63.0601310944420.8770@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU> 
 <1138640592.12625.0.camel@localhost.localdomain> 
 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
 <1138646561.7088.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it
>>>> keeps crashing in kmem_cache_init during bootup. i've tried older
>>>> 2.6.15-rtX patches and they all crash during startup but vanilla 2.6.15
>>>> works fine for me. anyone else seen this happen with realtime-preempt
>>>> patches? here's the message:
>>>
>>> Can you please send me your .config file ?
>>>
>
> [...]
>
>> CONFIG_PREEMPT_BKL=y
>> CONFIG_PREEMPT_RCU=y
>> CONFIG_RCU_STATS=y
>> CONFIG_NUMA=y
>
> The -rt patch currently doesn't support NUMA.  Please turn in off for
> now (do you really need it?).
>
> -- Steve
>

thanks, this worked
   -chris
