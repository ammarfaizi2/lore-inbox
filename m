Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWEZQKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWEZQKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWEZQKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:10:55 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:22665 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750976AbWEZQKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:10:54 -0400
Message-Id: <20060526160651.870725515@goodmis.org>
User-Agent: quilt/0.44-1
Date: Fri, 26 May 2006 12:06:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: [PATCH -rt 0/2] Get x86_64 running with PREEMPT_RT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following two patches get PREEMPT_RT running on x86_64.  I'm currently
writing this from my x86_64 box running 2.6.16-rt23.

The first patch probably only affected me, since it was caused by
having clocksource=XXX in the command line.

The other patch simply fixes a bad condition in the default_idle
which prevented the idle task from ever scheduling (that was bad!)

-- Steve
