Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSGBRJI>; Tue, 2 Jul 2002 13:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316852AbSGBRJH>; Tue, 2 Jul 2002 13:09:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1782 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316851AbSGBRJG>; Tue, 2 Jul 2002 13:09:06 -0400
Subject: [PATCH] O(1) scheduler for 2.4.19-rc1
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Jul 2002 10:11:35 -0700
Message-Id: <1025629895.990.996.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-O1-rml-2.4.19-rc1-1.patch

and mirrors.  Aside from the resync to 2.4.19-rc1, the following changes
are new since the last release (most all pulled from 2.5):

	- reintroduce sync wake ups
	- whitespace cleanup, trivial cleanups
	- remove frozen lock and introduce new arch-specific
	  switch_mm() logic
	- new rq_lock and rq_unlock methods
	- wake_up optimization
	- nr_uninterruptible optimization for count_active_tasks
	- merge the task CPU affinity system calls
	- sched_yield bugfix
	- minor fixes

Compiles on x86 UP and SMP.

Since Ingo recently posted 2.4-ac resyncs, I will refrain.

As I am the one doing these 2.4 patches, I will invariably be asked
whether I intend for the O(1) scheduler to be merged into 2.4.  The
answer is a strong NO.

Enjoy,

	Robert Love



