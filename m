Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030599AbVLWSyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbVLWSyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbVLWSyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:54:46 -0500
Received: from mtao02.charter.net ([209.225.8.187]:37827 "EHLO
	mtao02.charter.net") by vger.kernel.org with ESMTP id S1030599AbVLWSyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:54:45 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Message-ID: <43AC474D.60703@cybsft.com>
Date: Fri, 23 Dec 2005 12:51:57 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, John Rigg <lk@sound-man.co.uk>
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost	a	preemption
 check!
References: <1135306534.4473.1.camel@mindpipe> <43AB6B89.8020409@cybsft.com>	 <1135352277.6652.2.camel@localhost.localdomain>	 <43AC2607.1050707@cybsft.com> <1135363500.6652.8.camel@localhost.localdomain>
In-Reply-To: <1135363500.6652.8.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Fri, 2005-12-23 at 10:29 -0600, K.R. Foley wrote:
> 
>> OK. The BUG still exists (output below) but it does boot now with the
>> above patch applied (THANKS Steven!), which would seem to imply the two
>> weren't related. ARGH! :)
>>
>> Dec 23 10:16:27 porky kernel: Event source lapic installed with caps set: 06
>> Dec 23 10:16:27 porky kernel: BUG: swapper:0 task might have lost a
>> preemption check!
>> Dec 23 10:16:27 porky kernel: Brought up 2 CPUs
>> Dec 23 10:16:27 porky kernel: checking if image is initramfs... it is
>> Dec 23 10:16:27 porky kernel:  [<c010424e>] dump_stack+0x1e/0x20 (20)
>> Dec 23 10:16:27 porky kernel:  [<c011c9cf>]
>> preempt_enable_no_resched+0x5f/0x70 (20)
>> Dec 23 10:16:27 porky kernel:  [<c0100ff2>] cpu_idle+0xb2/0x100 (40)
>> Dec 23 10:16:27 porky kernel:  [<c0111446>]
>> start_secondary+0x296/0x340<6>Freeing initrd memory: 452k freed
>>
> 
> Yeah, I've seen the "might have lost a preemption check" too. But since
> this didn't seem to cause a problem booting my kernel (yet), it went to
> the end of the todo list.
> 
> Does this cause any other problems?
> 
> -- Steve
> 
> 
> 
No. Hasn't for me, yet and Lee said it's harmless for him also.

Thanks again.

-- 
   kr
