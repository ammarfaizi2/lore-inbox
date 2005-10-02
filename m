Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVJBPSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVJBPSP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVJBPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 11:18:15 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:15838 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751109AbVJBPSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 11:18:14 -0400
Date: Sun, 2 Oct 2005 17:18:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       Manfred Gruber <manfred.gruber@contec.at>,
       john cooper <john.cooper@timesys.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Clark Williams <williams@redhat.com>, Eran Mann <emann@mrv.com>,
       dwalker@mvista.com, Mark Knecht <markknecht@gmail.com>
Subject: 2.6.14-rc3-rt1
Message-ID: <20051002151817.GA7228@elte.hu>
References: <20050913100040.GA13103@elte.hu> <20050926070210.GA5157@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926070210.GA5157@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.14-rc3-rt1 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

the biggest change is the merge of the generic ARM-irq patches into the 
-rt tree, and a port of -rt to the ARM platform, by Thomas Gleixner and 
John Cooper.  There are also lots of updates and cleanups in the ktimer 
code.  Also, x64 should work again.  Plus smaller changes all around.
 
Changes since 2.6.14-rc2-rt2:

 - ARM-genirq code (Thomas Gleixner, me - testing by lots of people)

 - latency tracing on ARM (John Cooper)

 - port of -rt to ARM (Thomas Gleixner)

 - lots of ktimer updates/cleanups (Thomas Gleixner)

 - NTFS bit-spinlock fix (Eran Mann)

 - gcc4 build fix (Daniel Walker)

 - fix "No Forced Preemption (Server)" build problems
   (reported by Mark Knecht)

 - convert epca_lock to the new syntax (Daniel Walker)

 - typo fix in latency-hist prototype (Clark Williams)

 - netlink build fix (Eran Mann)

 - dccp build fix (Eran Mann)

 - x64 build fixes

 - fix audit.c compilation error

 - merge to 2.6.14-rc3

 - cpufreq build fix

 - pcmcia build fix

 - XFS build fix

to build a 2.6.14-rc3-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc3.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc3-rt1

	Ingo
