Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUJSVg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUJSVg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUJSVbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:31:42 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:30394 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268138AbUJSVMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:12:07 -0400
Message-ID: <32839.192.168.1.5.1098220140.squirrel@192.168.1.5>
In-Reply-To: <32806.192.168.1.5.1098218772.squirrel@192.168.1.5>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>  
     <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>   
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>   
    <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>   
    <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>   
    <20041019180059.GA23113@elte.hu>
    <32806.192.168.1.5.1098218772.squirrel@192.168.1.5>
Date: Tue, 19 Oct 2004 22:09:00 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Oct 2004 21:12:05.0505 (UTC) FILETIME=[491CCF10:01C4B620]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ingo Molnar wrote:
>>
>> i have released the -U7 Real-Time Preemption patch:
>>
>>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U7
>>
>
>
> As an aside, my greatest complaint is that jackd -R doesn't work at all:
>
> JACK: unable to mlock() port buffers: Cannot allocate memory
> jack_create_thread: error -1 switching current thread to rt for
> inheritance: Unknown error 4294967295
> cannot start watchdog thread
> cannot load driver module alsa
>

Forget this. The reason is that realtime-lsm module wasn't being loaded.

Sorry.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

