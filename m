Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUJ0AyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUJ0AyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 20:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUJ0AyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 20:54:00 -0400
Received: from relay00.pair.com ([209.68.1.20]:34573 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S261557AbUJ0Axg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 20:53:36 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <417EF18D.8010207@cybsft.com>
Date: Tue, 26 Oct 2004 19:53:33 -0500
From: "K.R. Foley" <kr@cybsft.com>
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
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu>
In-Reply-To: <20041027002455.GC31852@elte.hu>
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
>>Several things in regard to V0.2:
>>
>>1) Interactive responsiveness seems to be noticably sluggish at times on
>>all three of the systems I have tested this on.
>>2) My 450MHz UP system is definitely the worst by far. Scrolling through
>>the syslog in a telnet session produces pauses every few seconds for
>>about a second, that is while it's still responding. These problems seem
>>to be network related, but there are no indications of what the problem
>>is. This system also at times will just stop responding to network requests.
>>3) Both of the SMP systems are lacking the snappy responsiveness in X
>>that I have become accustomed to with previous patches, but the 2.6GHz
>>Xeon (w/HT) is worse than the 933MHz Xeon. Again no indications of
>>problems in the logs.
>>4) Using amlat to run the RTC at 1kHz will kill any of these systems
>>very quickly.
> 
> 
> could you try this with -V0.3 too? I believe most of these problems
> should be solved.
> 
> 	Ingo
> 

Sure will. It's building on two of the systems now (V0.3.1).

kr
