Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWDDXUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWDDXUK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 19:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWDDXUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 19:20:10 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:6213 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750934AbWDDXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 19:20:08 -0400
Message-ID: <4432FF26.6050207@bigpond.net.au>
Date: Wed, 05 Apr 2006 09:20:06 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: linux-kernel@vger.kernel.org, Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
References: <200604031459.51542.a1426z@gawab.com> <4431AF69.1000708@bigpond.net.au> <200604041627.14871.a1426z@gawab.com>
In-Reply-To: <200604041627.14871.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 4 Apr 2006 23:20:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Peter Williams wrote:
>> Al Boldi wrote:
>>> The default values for spa make it really easy to lock up the system.
>>> Is there a module to autotune these values according to cpu/mem/ctxt
>>> performance?
>> Jake Moilanen had a genetic algorithm autotuner for Zaphod at one time
>> which I believe he ported over to PlugSched
> 
> Would this be a load-adaptive dynamic tuner?

Yes.

> 
> What I meant was a lock-preventive static tuner.  Something that would take 
> hw-latencies into account at boot and set values for non-locking console 
> operation.

I'm not sure what you mean here.  Can you elaborate?

> 
>> I could generate a patch to gather the statistic again and make them
>> available via /proc if you would like to try a user space version of
>> Jake's work (his was in kernel).
> 
> That would be great!

OK, I'll put it on my "to do" list.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
