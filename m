Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbUJ0PQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUJ0PQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUJ0PQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:16:57 -0400
Received: from mail4.utc.com ([192.249.46.193]:39347 "EHLO mail4.utc.com")
	by vger.kernel.org with ESMTP id S262485AbUJ0PQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:16:23 -0400
Message-ID: <417FBBB7.3070200@cybsft.com>
Date: Wed, 27 Oct 2004 10:16:07 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com> <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com> <20041027150548.GA11233@elte.hu>
In-Reply-To: <20041027150548.GA11233@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * K.R. Foley <kr@cybsft.com> wrote:
> 
> 
>>I use the rtc-debug and amlat to generate histograms of latencies
>>which is what I was trying to do when I found the rtc problem the
>>first time.  I believe that rtc-debug/amlat is much more accurate for
>>generating histograms of latencies than realfeel is because the
>>instrumentation is in the kernel rather than a userspace program.
> 
> 
> ah, ok - nice. So rtc-debug+amlat is the only known-reliable way to
> produce latency histograms?

Don't know that for sure, but it is the most reliable way that I am 
aware of.

> 
> Btw., rtc-debug's latency results could now be cross-validated with
> -V0.4's wakeup tracer (and vice versa), because the two are totally
> independent mechanisms.

Agreed. :)

> 
> 	Ingo
> 

kr
