Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTKHB15 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 20:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTKHB15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 20:27:57 -0500
Received: from web80007.mail.yahoo.com ([66.163.168.137]:25348 "HELO
	web80007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261575AbTKHB14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 20:27:56 -0500
Message-ID: <20031108012755.41882.qmail@web80007.mail.yahoo.com>
Date: Fri, 7 Nov 2003 17:27:55 -0800 (PST)
From: Oleg OREL <oleg_orel@yahoo.com>
Reply-To: oleg_orel@yahoo.com
Subject: Linux kernel preemption (kernel 2.6 of course)
To: linux-kernel@vger.kernel.org
In-Reply-To: <20031108003029.BF9DB5F711@attila.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was browsing linux kernel to undetsnand how kernel preemption does
work. I was hacking around schedulee_tick and other functions called
out of timer interrupt and was unable to found any call to schedule()
or switch_to() to peempt currently running task, instead just mangling
around current and inactive runqueues.

That leads me to a thought that currently running task wont be
preempted within time-tick, instead it might happends in the next call
to preempt_schedule out of spin_lock for instance.
 



=====
Oleg OREL

TEL: +1 925 244-1127
CELL: +1 916 337-0608
