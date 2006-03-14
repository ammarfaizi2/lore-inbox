Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752034AbWCNItY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbWCNItY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWCNItY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:49:24 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42134 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752034AbWCNItX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:49:23 -0500
Date: Tue, 14 Mar 2006 09:46:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Jan Altenberg <tb10alj@tglx.de>
Subject: 2.6.16-rc6-rt3
Message-ID: <20060314084658.GA28947@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rc6-rt3 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release, which resolves a number of 2.6.16-rc6 
rebasing side-effects. The fixes are:

 - futex crash fix (reported by Michal Piotrowski)

 - PI boosting fix (Esben Nielsen)

 - printk from rt-atomic context fix (Thomas Gleixner, reported by 
   Michal Piotrowski)

 - symbol export fixes (Jan Altenberg)

 - non-debug mutex build fix (Jan Altenberg)

 - x86_64 and ppc build fix (Steven Rostedt)

 - early_printk build fix in latency.c (Steven Rostedt)

to build a 2.6.16-rc6-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt3

        Ingo
