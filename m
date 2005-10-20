Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVJTTyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVJTTyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932517AbVJTTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:54:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37048 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932516AbVJTTyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:54:09 -0400
Date: Thu, 20 Oct 2005 21:54:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: 2.6.14-rc5-rt1
Message-ID: <20051020195432.GA21903@elte.hu>
References: <20051017160536.GA2107@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017160536.GA2107@elte.hu>
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


i have released the 2.6.14-rc5-rt1 tree, which can be downloaded from 
the usual place:
 
   http://redhat.com/~mingo/realtime-preempt/

this release includes various smaller fixlets, the cycle_t u64 fix from 
Steven Rostedt which might fix the ktimer expired short bug messages, 
and lots of ktimer/clockevents updates.

Changes since 2.6.14-rc4-rt7:

- cycle_t u64 fix (Steven Rostedt)

- fix the the ktimer monotonicity check (Steven Rostedt)

- raw seqlock fix (Daniel Walker)

- scsi race fix (Steven Rostedt)

- ktimer/clockevents updates (Thomas Gleixner, me)

- PRINTK_IGNORE_LOGLEVEL fix's fix

- ktimer debugging code added

to build a 2.6.14-rc5-rt1 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc5.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc5-rt1

	Ingo
