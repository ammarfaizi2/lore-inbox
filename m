Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbVKZGwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbVKZGwP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 01:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbVKZGwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 01:52:15 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:14531 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422645AbVKZGwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 01:52:15 -0500
Subject: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 26 Nov 2005 01:52:08 -0500
Message-Id: <1132987928.4896.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get tons of these errors:

  CC      arch/i386/kernel/i386_ksyms.o
In file included from include/linux/spinlock.h:97,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from arch/i386/kernel/i386_ksyms.c:2:
include/linux/rt_lock.h:386: warning: 'struct semaphore' declared inside
parameter list
include/linux/rt_lock.h:386: warning: its scope is only this definition
or declaration, which is probably not what you want

Lee

