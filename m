Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUJOS36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUJOS36 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 14:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUJOS36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 14:29:58 -0400
Received: from mail8.spymac.net ([195.225.149.8]:12482 "EHLO mail8")
	by vger.kernel.org with ESMTP id S268282AbUJOS34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 14:29:56 -0400
Message-ID: <4170333D.8000006@spymac.com>
Date: Fri, 15 Oct 2004 22:29:49 +0200
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
In-Reply-To: <20041015102633.GA20132@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -U3 PREEMPT_REALTIME patch:
>
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
>
>this is a buildfixes-only release, and it is still experimental code.
>
>Changes since -U2:
>
> - build fix: fixes the latency.c compilation error reported by Adam 
>   Heath.
>
> - build fix: fixes !HIGHMEM compilation, patch from Andrew Rodland
>
>to create a -U3 tree from scratch the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
> + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
> + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
> + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
>
>	Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hey,

I get lockups a few second after i issue the dhcpcd command for my 
wireless pcmcia network card (cisco).
These lockups go away when i disable PREEMPT_REALTIME. Are there any 
logs or information you want?
