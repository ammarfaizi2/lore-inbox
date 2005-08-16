Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbVHPIlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVHPIlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbVHPIlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:41:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56460 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S965145AbVHPIlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:41:15 -0400
Date: Tue, 16 Aug 2005 10:41:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com
Subject: 2.6.13-rc6-rt1
Message-ID: <20050816084116.GA16772@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <20050815111804.GA26161@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050815111804.GA26161@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've released the 2.6.13-rc6-rt1 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

as the name already suggests, i've switched to a new, simplified naming 
scheme, which follows the usual naming convention of trees tracking the 
mainline kernel. The numbering will be restarted for every new upstream 
kernel the -RT tree is merged to.

the 2.6.13-rc6-rt1 release includes a number of fixes. Changes since 
-53-11:

 - more HRT fixes (Thomas Gleixner)

 - more RCU-tasklist-lock fixes (Paul E. McKenney)

 - IPC message-queue and IPC messages wakeup fixes (Daniel Walker)

 - VIA VT8237 southbridge quirks to fix IOAPIC issues (Karsten Wiese)

 - NMI preemption-count fix (George Anzinger)

 - various latency tracer fixes: lost trace entries, SMP weirdnesses (me)

to build a 2.6.13-rc6-rt1 tree, the following patches should to be 
applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt1

	Ingo
