Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbUJ0Rrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbUJ0Rrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbUJ0RpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:45:14 -0400
Received: from mail3.utc.com ([192.249.46.192]:26589 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S262518AbUJ0Rk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:40:28 -0400
Message-ID: <417FDD73.5000206@cybsft.com>
Date: Wed, 27 Oct 2004 12:40:03 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com>	 <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com>	 <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>	 <20041027132926.GA7171@elte.hu> <417FB7F0.4070300@cybsft.com>	 <20041027150548.GA11233@elte.hu>	 <1098889994.1448.14.camel@krustophenia.net>	 <20041027151701.GA11736@elte.hu> <1098897241.8596.5.camel@krustophenia.net>	 <417FD915.304@cybsft.com> <1098898017.8596.9.camel@krustophenia.net>
In-Reply-To: <1098898017.8596.9.camel@krustophenia.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2004-10-27 at 12:21 -0500, K.R. Foley wrote:
> 
>>>Anyway I am generating a cleaned up version of the patch agaqinst
>>>2.6.9-mm1.
>>>
>>>Lee
>>>
>>
>>Actually if you are cleaning it up anyway, could you fix it to work with 
>>Ingo's changes to rtc.c? If not I will be glad to do it. Up until one of 
>>the last couple of versions of RT PREEMPT it applied cleanly, but I just 
>>tried it and it failed.
> 
> 
> Yup, here it is against 2.6.9-mm1-V0.4.1.  Not yet tested (building now)
> but should work.  I took out the show_trace_smp part because that never
> worked, I always get "Stack pointer is garbage".  So now the patch is
> smaller and only touches rtc.c.
> 

You've also eliminated the stack trace altogether then, right? Not that 
I really need it. :-)

kr
