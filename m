Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268457AbUIWNhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268457AbUIWNhM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 09:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUIWNhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 09:37:12 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:22149 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S268457AbUIWNhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 09:37:09 -0400
Message-ID: <24137.195.245.190.93.1095946528.squirrel@195.245.190.93>
In-Reply-To: <20040923122838.GA9252@elte.hu>
References: <20040907115722.GA10373@elte.hu>
    <1094597988.16954.212.camel@krustophenia.net>
    <20040908082050.GA680@elte.hu>
    <1094683020.1362.219.camel@krustophenia.net>
    <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
    <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
    <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
    <20040923122838.GA9252@elte.hu>
Date: Thu, 23 Sep 2004 14:35:28 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Sep 2004 13:37:08.0301 (UTC) FILETIME=[6BF887D0:01C4A172]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> i've released the -S4 VP patch:
>

Just tried to configure for 2.6.9-rc2-mm2-VP-S4 on my laptop. Strange
enough I don't get the PREEMPT_VOLUNTARY, PREEMPT_SOFTIRQS and
PREEMPT_HARDIRQS symbols available for Kconfig.

Not surprisingly, make stops on these messages:

 [...]
 CC      arch/i386/kernel/irq.o
arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:287: warning: implicit declaration of function
`redirect_hardirq'
arch/i386/kernel/irq.c:363: error: `noirqdebug' undeclared (first use in
this function)
arch/i386/kernel/irq.c:363: error: (Each undeclared identifier is reported
only once
arch/i386/kernel/irq.c:363: error: for each function it appears in.)
arch/i386/kernel/irq.c:364: warning: implicit declaration of function
`note_interrupt'
make[1]: *** [arch/i386/kernel/irq.o] Error 1
make: *** [arch/i386/kernel] Error 2



Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

