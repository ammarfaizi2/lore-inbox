Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUJPNng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUJPNng (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 09:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJPNng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 09:43:36 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:60677 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268730AbUJPNne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 09:43:34 -0400
Message-ID: <32819.192.168.1.5.1097934094.squirrel@192.168.1.5>
In-Reply-To: <41711A08.7040905@cybsft.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>    
    <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>    
    <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>    
    <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>    
    <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>    
    <20041015102633.GA20132@elte.hu>    
    <1097888438.6737.63.camel@krustophenia.net>   
    <1097894120.31747.1.camel@krustophenia.net>
    <32812.192.168.1.5.1097922568.squirrel@192.168.1.5>
    <41711A08.7040905@cybsft.com>
Date: Sat, 16 Oct 2004 14:41:34 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "Daniel Walker" <dwalker@mvista.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Andrew Morton" <akpm@osdl.org>,
       "Adam Heath" <doogie@debian.org>,
       "Lorenzo Allegrucci" <l_allegrucci@yahoo.it>,
       "Andrew Rodland" <arodland@entermail.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 16 Oct 2004 13:43:33.0173 (UTC) FILETIME=[20DF9650:01C4B386]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
>Rui Nuno Capela:
>>
>> I run both, on different machines.
>>
>> I'm actually running 2.6.9-rc4-mm1-U3 at this very moment, on my laptop
>> (P4 2.53Ghz/UP, Mdk 10.1c) and also on my desktop machine (P4
>> 2.80Ghz/SMP/HT, SuSE 9.1).
>>
>> However, on the desktop (SMP/HT) I could only made it boot/init
>> successfully with CONFIG_PREEMPT_REALTIME off. On my laptop (UP) is
>> running pretty well on full RT.
>
> I'm curious what you get when you try to boot the SMP system with
> REALTIME on? My SMP/HT system at the office works fine with this.
> Although there is one difference that jumps out at me. I have disabled
> ACPI. I don't have the config handy so I can't do a complete comparison,
> just going from memory.
>

Hmm. The way I see it, if I say acpi=off on kernel boot, I loose HT, and
end in a SMP enabled kernel running on only one CPU. To keep ACPI disabled
but rely on it to show up those hyperthreaded virtual cpus on boot, one
should say acpi=ht, I guess.

Is that what you're asking?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

