Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbVJBPmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbVJBPmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 11:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbVJBPmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 11:42:24 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:40716 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751113AbVJBPmY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 11:42:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BjLQcab9UvuNyWu4gGqZ7QAUcZkMBgh0Ce7Tpt8GWjYhTBybrw8UBl8KBKcuG7FXX0wUTapnTEwHCYE2QnZBhr6GR+0zc7dcemrUH994+ENesv96/UXTIpHyTcseQkpYpWNHlPgULmKRID34WcUuihADshAvkY/cHZYOq9H5WDc=
Message-ID: <5bdc1c8b0510020842p6035b4c0ibbe9aaa76789187d@mail.gmail.com>
Date: Sun, 2 Oct 2005 08:42:23 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051002151817.GA7228@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
	 <20051002151817.GA7228@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ingo. 2.6.14-rc2-rt7 on AMD64 has been working well for me the
last few days. (After finally getting it to build!) I expect that I'll
build 2.6.14-rc3-rt1 today.

Cheers,
Mark

On 10/2/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> i have released the 2.6.14-rc3-rt1 tree, which can be downloaded from
> the usual place:
>
>   http://redhat.com/~mingo/realtime-preempt/
>
> the biggest change is the merge of the generic ARM-irq patches into the
> -rt tree, and a port of -rt to the ARM platform, by Thomas Gleixner and
> John Cooper.  There are also lots of updates and cleanups in the ktimer
> code.  Also, x64 should work again.  Plus smaller changes all around.
>
> Changes since 2.6.14-rc2-rt2:
>
>  - ARM-genirq code (Thomas Gleixner, me - testing by lots of people)
>
>  - latency tracing on ARM (John Cooper)
>
>  - port of -rt to ARM (Thomas Gleixner)
>
>  - lots of ktimer updates/cleanups (Thomas Gleixner)
>
>  - NTFS bit-spinlock fix (Eran Mann)
>
>  - gcc4 build fix (Daniel Walker)
>
>  - fix "No Forced Preemption (Server)" build problems
>    (reported by Mark Knecht)
>
>  - convert epca_lock to the new syntax (Daniel Walker)
>
>  - typo fix in latency-hist prototype (Clark Williams)
>
>  - netlink build fix (Eran Mann)
>
>  - dccp build fix (Eran Mann)
>
>  - x64 build fixes
>
>  - fix audit.c compilation error
>
>  - merge to 2.6.14-rc3
>
>  - cpufreq build fix
>
>  - pcmcia build fix
>
>  - XFS build fix
>
> to build a 2.6.14-rc3-rt1 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc3.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc3-rt1
>
>         Ingo
>
