Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUJPNHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUJPNHy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 09:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUJPNHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 09:07:54 -0400
Received: from relay.pair.com ([209.68.1.20]:9489 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268723AbUJPNHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 09:07:52 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <41711D27.8010408@cybsft.com>
Date: Sat, 16 Oct 2004 08:07:51 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <1097888438.6737.63.camel@krustophenia.net> <1097894120.31747.1.camel@krustophenia.net> <32812.192.168.1.5.1097922568.squirrel@192.168.1.5> <41711A08.7040905@cybsft.com> <20041016130450.GA8387@elte.hu>
In-Reply-To: <20041016130450.GA8387@elte.hu>
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
>>>>It builds fine if CONFIG_SMP is set.  Am I really the only person
>>>>running this on UP?
>>>
>>>I run both, on different machines.
>>>
>>>I'm actually running 2.6.9-rc4-mm1-U3 at this very moment, on my laptop
>>>(P4 2.53Ghz/UP, Mdk 10.1c) and also on my desktop machine (P4
>>>2.80Ghz/SMP/HT, SuSE 9.1).
>>>
>>>However, on the desktop (SMP/HT) I could only made it boot/init
>>>successfully with CONFIG_PREEMPT_REALTIME off. On my laptop (UP) is
>>>running pretty well on full RT.
>>
>>I'm curious what you get when you try to boot the SMP system with
>>REALTIME on? My SMP/HT system at the office works fine with this. 
>>Although there is one difference that jumps out at me. I have disabled
>>ACPI. I don't have the config handy so I can't do a complete
>>comparison, just going from memory.
> 
> 
> one group of complaints seems to be related to SELINUX=y: it has hooks
> all across the kernel deep within the locking hierarchy - and then
> itself it does pretty complex stuff too. IPC is certainly broken due to
> this, but some networking problems seem to be related too.
> 
> 	Ingo
> 
Well therein lies a big difference. I have disabled this on all the 
systems that I am testing on.

kr
