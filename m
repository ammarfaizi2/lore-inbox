Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUHDOfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUHDOfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUHDOfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:35:12 -0400
Received: from smtp.nedstat.nl ([194.109.98.184]:53933 "HELO smtp.nedstat.nl")
	by vger.kernel.org with SMTP id S266075AbUHDOeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:34:44 -0400
Message-ID: <4110F403.1010200@chello.nl>
Date: Wed, 04 Aug 2004 16:34:43 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rudo Thomas <rudo@matfyz.cz>
Cc: Ingo Molnar <mingo@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-mm2-O3
References: <1091459297.2573.10.camel@mars> <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com> <20040804112201.GA7842@ss1000.ms.mff.cuni.cz>
In-Reply-To: <20040804112201.GA7842@ss1000.ms.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudo Thomas wrote:

>>thx - i fixed this in -O3.
>>    
>>
>
>Hi, Ingo.
>
>I just wanted to report that O3 (+preempt-timing-O2) locks up hard at random
>occasions, even with voluntary-preempt=2 preempt=1 set at boot time.
>I never changed any of /proc/irq/*/threaded.
>
>I will provide any information needed to hunt this down.
>
>Rudo.
>  
>
Hi Igno,

I have the same troubles with O3 at home on my SMP machine, however
since the same kernel (2.6.8-rc2-mm2-O3) works flawlessly here at work
on a UP P4 I thought it to be SMP related.

I also tried booting my dual athlon with noapic but that did not solve
the problem.

I have not had enough time yet to file a proper bug report but seeing
this message I wanted to second it.

Are there any known SMP related problems with your patches?

and would my dmesg and .config from home be enough ?

kind regards,

Peter Zijlstra
