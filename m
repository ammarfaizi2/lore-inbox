Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268735AbUJPNzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268735AbUJPNzn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 09:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268737AbUJPNzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 09:55:43 -0400
Received: from relay.pair.com ([209.68.1.20]:61714 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S268735AbUJPNzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 09:55:41 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <4171285B.8030701@cybsft.com>
Date: Sat, 16 Oct 2004 08:55:39 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rui Nuno Capela <rncbc@rncbc.org>
CC: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>        <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>        <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>        <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>        <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>        <20041015102633.GA20132@elte.hu>        <1097888438.6737.63.camel@krustophenia.net>       <1097894120.31747.1.camel@krustophenia.net>    <32812.192.168.1.5.1097922568.squirrel@192.168.1.5>    <41711A08.7040905@cybsft.com> <32819.192.168.1.5.1097934094.squirrel@192.168.1.5>
In-Reply-To: <32819.192.168.1.5.1097934094.squirrel@192.168.1.5>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:
> K.R. Foley wrote:
> 
>>Rui Nuno Capela:
>>
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
>>ACPI. I don't have the config handy so I can't do a complete comparison,
>>just going from memory.
>>
> 
> 
> Hmm. The way I see it, if I say acpi=off on kernel boot, I loose HT, and
> end in a SMP enabled kernel running on only one CPU. To keep ACPI disabled
> but rely on it to show up those hyperthreaded virtual cpus on boot, one
> should say acpi=ht, I guess.
> 
> Is that what you're asking?

Actually what I was asking was what messages, etc. you get before the 
system fails to boot. I think Ingo already pointed out why several 
people, maybe yourself included, are having problems with this patch.

As for acpi, I just disabled the power management stuff prior to 
building the kernel. Of course my ht still works.

kr
