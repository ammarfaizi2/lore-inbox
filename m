Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbTC1XGQ>; Fri, 28 Mar 2003 18:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263194AbTC1XGQ>; Fri, 28 Mar 2003 18:06:16 -0500
Received: from smtp-out.comcast.net ([24.153.64.116]:41515 "EHLO
	smtp.comcast.net") by vger.kernel.org with ESMTP id <S263190AbTC1XGP>;
	Fri, 28 Mar 2003 18:06:15 -0500
Date: Fri, 28 Mar 2003 18:14:37 -0500
From: J S <webnews@comcast.net>
Subject: Tasklets vs. Task Queues for Deferred Processing
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1048893277.4058.11.camel@localhost.localdomain>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to defer some processing to a later point.  I'm in a softirq,
so in_interrupt() returns true.  I need to schedule some work for later,
in process context.  I have read in the O'Reilly linux device drivers
book that tasklets always run in interrupt time.  Also, I guess the only
task_queue that is in process context is the scheduler task queue.  I've
seen in a few places that task queues are on their way out and tasklets
are being used instead.  Is this completely true?  Should I consider
task queues as a deprecated method of deferred processing?`  What other
deferred processing methods can I use that will run in process context?

Thanks,
	Josh



