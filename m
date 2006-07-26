Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWGZAvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWGZAvK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWGZAvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:51:09 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:45748 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030300AbWGZAvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:51:08 -0400
Message-ID: <44C6BC76.8010808@bigpond.net.au>
Date: Wed, 26 Jul 2006 10:51:02 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
References: <200607241857.52389.a1426z@gawab.com> <200607250757.10722.a1426z@gawab.com> <44C5AFC3.4020405@bigpond.net.au> <200607252127.14024.a1426z@gawab.com>
In-Reply-To: <200607252127.14024.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 26 Jul 2006 00:51:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> Peter Williams wrote:
>>>> Al Boldi wrote:
[bits deleted]
>>>>> It may be really great, to allow schedulers perPid parent, thus
>>>>> allowing the stacking of different scheduler semantics.  This could
>>>>> aid flexibility a lot.
>>>> I'm don't understand what you mean here.  Could you elaborate?
>>> i.e:  Boot the kernel with spa_no_frills, then start X with spa_ws.
>> It's probably not a good idea to have different schedulers managing the
>> same resource.  The way to do different scheduling per process is to use
>> the scheduling policy mechanism i.e. SCHED_FIFO, SCHED_RR, etc.
>> (possibly extended) within each scheduler.  On the other hand, on an SMP
>> system, having a different scheduler on each run queue (or sub set of
>> queues) might be interesting :-).  
> 
> What's wrong with multiple run-queues on UP?

A really high likelihood of starvation of some tasks.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
