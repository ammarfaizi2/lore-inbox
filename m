Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWEWFWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEWFWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 01:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWEWFWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 01:22:43 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:37454 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750726AbWEWFWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 01:22:42 -0400
Message-ID: <44729C1F.1060008@bigpond.net.au>
Date: Tue, 23 May 2006 15:22:39 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Mike Galbraith <efault@gmx.de>, Con Kolivas <kernel@kolivas.org>,
       Rene Herman <rene.herman@keyaccess.nl>,
       Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl>	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>	 <200605221243.54100.kernel@kolivas.org> <1148267426.21765.15.camel@homer>	 <4471305F.40105@bigpond.net.au> <1148273580.9914.3.camel@homer>	 <44714E4F.8000801@bigpond.net.au> <1148277658.10520.9.camel@homer> <44715B5F.6060205@bigpond.net.au>
In-Reply-To: <44715B5F.6060205@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 23 May 2006 05:22:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Mike Galbraith wrote:
>> On Mon, 2006-05-22 at 15:38 +1000, Peter Williams wrote:
>>
>>> In my schedulers I generalize background to "soft cpu rate caps" with 
>>> a cap of zero being the same as background.  I have patches to add 
>>> both soft and hard cpu rate caps to the standard scheduler but I'm 
>>> sitting on them until things settle down a bit.
>>
>> I look forward to seeing them.  Any chance of a preview?
>>
> 
> I'll post them as a "request for comment" tomorrow.  I'm still undecided 
> about the best user space interface for using them.  At the moment, I 
> have mechanisms to set them via /proc which is very handy for testing 
> but not necessarily the best interface for general use.  Other options 
> are via rlimits or a syscall.

There'll be a delay in this posting as I've discovered uses of MAX_PRIO 
(in 2.7.17-rc4-mm3) that would be broken by my current patches.  I'll 
fix that problem and hopefully post the patches in the near future.

Sorry
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
