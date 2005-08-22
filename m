Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVHVWaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVHVWaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVHVWaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:30:01 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21129 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751429AbVHVWZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:23 -0400
Date: Mon, 22 Aug 2005 10:32:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Adrian Bunk <bunk@stusta.de>
Subject: 2.6.13-rc6-rt10
Message-ID: <20050822083206.GA21465@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


i have released the 2.6.13-rc6-rt10 tree, which can be downloaded from 
the usual place:

  http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release. Changes since 2.6.13-rc6-rt9:

 - fix/improve the timer PI logic (Thomas Gleixner)

 - fix tty race (Steven Rostedt)

 - fix disable_IO_APIC() crash during reboot (Karsten Wiese)

 - fix DECNET compilation error (Adrian Bunk)

 - enable NMI watchdog on P4 CPUs too (Steven Rostedt)

 - fix x86 XT-PIC lockup (Thomas Gleixner)

 - fix PPC slowdown (Thomas Gleixner)

 - identify and port netpoll RCU fix (Steven Rostedt)

 - fix latency tracer deadlock on WAKEUP_TIMING (Steven Rostedt)

to build a 2.6.13-rc6-rt10 tree, the following patches should be 
applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc6.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.13-rc6-rt10

	Ingo
