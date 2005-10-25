Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVJYJRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVJYJRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbVJYJRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:17:42 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:20884 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932105AbVJYJRm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:17:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AaawGqVBqHX6R2hF16q/WksTgJJYpos8Gwpei3m8r9baH1aMc97aF7hX+G2M5FsgakGYIMeP55M+dmd/29Z5okhdVH4kg1+0RajiWVj9zkncYmegeOQAV2RDw3DzQ9AmB3wjpIfHLuuhFTjCXMuqqcWG5MLoXXnwVquZS+CtmoU=
Message-ID: <5486cca80510250217x223e4d44t@mail.gmail.com>
Date: Tue, 25 Oct 2005 11:17:41 +0200
From: Antonio <tritemio@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <1130183199.27168.296.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a similar message with a 2.6.14-rc5-rt3 kernel (compiled
choosing doing a make oldconfig from the vanilla rc5 and choosing all
no and Complete Preemption):

ACPI: PCI Interrupt 0000:01:05.0[A] -> Link [LNKA] -> GSI 10 (level,
low) -> IRQ 10
radeonfb: Found Intel x86 BIOS ROM Image
Time: tsc clocksource has been installed.
WARNING: non-monotonic time!
softirq-timer/0/3[CPU#0]: BUG in ktime_get at kernel/ktimers.c:101
 [<c011b058>] __WARN_ON+0x68/0xa0 (8)
 [<c0133435>] ktime_get+0xe5/0x100 (48)
 [<c0133ff2>] ktimer_run_queues+0x22/0x120 (40)
 [<c0115ba8>] __wake_up+0x48/0x80 (12)
 [<c0124027>] run_timer_softirq+0xc7/0x410 (44)
 [<c0322935>] schedule+0x85/0x120 (12)
  [<c011fccd>] ksoftirqd+0xad/0x110 (28)
  [<c011fc20>] ksoftirqd+0x0/0x110 (32)
  [<c012fa45>] kthread+0xb5/0xc0 (4)
  [<c012f990>] kthread+0x0/0xc0 (24)
 [<c0101105>] kernel_thread_helper+0x5/0x10 (16)
radeonfb: Retreived PLL infos from BIOS

I don't have any strange behaviour though.

Cheers,

  ~ Antonio
