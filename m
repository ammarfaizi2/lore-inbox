Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWCWWxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWCWWxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWCWWxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:53:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:4506 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161003AbWCWWxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:53:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-mm1
Date: Thu, 23 Mar 2006 23:51:53 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org>
In-Reply-To: <20060323014046.2ca1d9df.akpm@osdl.org>
MIME-Version: 1.0
Message-Id: <200603232351.53574.rjw@sisk.pl>
X-Length: 137009
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I messed up this post, so I'm resending with the log trimmed etc.
Sorry for any inconvenience.]

On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/

On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
just fine):

}-- snip --{
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1795.400 MHz processor.
disabling early console
Console: colour dummy device 80x25
time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x64/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:__do_softirq+0x66/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x46/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x49/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x4b/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:__do_softirq+0x4d/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x50/0xc0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:run_timer_softirq+0x0/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:run_timer_softirq+0x1/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:run_timer_softirq+0x4/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:run_timer_softirq+0xc/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:run_timer_softirq+0xd/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:run_timer_softirq+0x11/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:run_timer_softirq+0x18/0x1f0
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:hrtimer_run_queues+0x54/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:hrtimer_run_queues+0x54/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:hrtimer_run_queues+0x58/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:hrtimer_run_queues+0x5f/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:hrtimer_run_queues+0x65/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:hrtimer_run_queues+0x73/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:hrtimer_run_queues+0x77/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:hrtimer_run_queues+0x82/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:hrtimer_run_queues+0x86/0x120
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:_spin_lock_irq+0x0/0x30
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:_spin_lock_irq+0x1/0x30
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__local_irq_disable+0x1/0x20
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__local_irq_disable+0x1/0x20
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:__local_irq_disable+0x1/0x20
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__local_irq_disable+0xf/0x20
last cli 0x0
last cli caller 0x0
time.c: Lost 4 timer tick(s)! rip 10:__local_irq_disable+0xf/0x20
last cli 0x0
last cli caller 0x0
time.c: Lost 3 timer tick(s)! rip 10:__local_irq_disable+0x16/0x20
last cli 0x0
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:_spin_unlock_irq+0xf/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:_spin_unlock_irq+0xf/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0x0/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:sub_preempt_count+0x1/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0xd/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:sub_preempt_count+0x13/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0x26/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:sub_preempt_count+0x31/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0x38/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0x4d/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:sub_preempt_count+0x53/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:sub_preempt_count+0x54/0x60
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:_spin_unlock_irq+0x14/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:_spin_unlock_irq+0x31/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:_spin_unlock_irq+0x31/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:_spin_unlock_irq+0x31/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:hrtimer_run_queues+0x105/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:hrtimer_run_queues+0x73/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:hrtimer_run_queues+0x73/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:hrtimer_run_queues+0x77/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:hrtimer_run_queues+0x82/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:hrtimer_run_queues+0x86/0x120
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:_spin_lock_irq+0x0/0x30
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:_spin_lock_irq+0x1/0x30
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:__local_irq_disable+0x5/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:__local_irq_disable+0x6/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:__local_irq_disable+0x6/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:__local_irq_disable+0xf/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:__local_irq_disable+0x16/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:__local_irq_disable+0x1d/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 5 timer tick(s)! rip 10:__local_irq_disable+0x1d/0x20
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
time.c: Lost 6 timer tick(s)! rip 10:_spin_unlock_irq+0xf/0x40
last cli _spin_lock_irq+0x15/0x30
last cli caller hrtimer_run_queues+0x8e/0x120
}-- cut --{
