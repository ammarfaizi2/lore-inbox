Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVARFwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVARFwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 00:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVARFwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 00:52:40 -0500
Received: from web53304.mail.yahoo.com ([206.190.39.233]:47789 "HELO
	web53304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261242AbVARFwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 00:52:38 -0500
Message-ID: <20050118055238.65649.qmail@web53304.mail.yahoo.com>
Date: Tue, 18 Jan 2005 05:52:38 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: function called when a thread gets terminated
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  dear sir 
i want to design a system moniter for linux 
could you just guide me on what will be the basic
architerture like:
i have thought of
kernel(using printk)->logfile(myfile)->application
but in order to make it real time .please correct me
on this architecture 
and i am unable to find some functions where the user
as well as kernel threads are actually exited also i
want to distinguish between the user level and kernel
level at that moment.but as i have done during the
forking of thread in fork.c in do_fork function
through the use of
if(p->mm==null)i could check the kernel thread or user
thread but i am unable do so during exit in exit.c in
do_exit function it seems that in somewhere between
execution the tsk->mm is being filled up .
so do i need to find some other place from which i can
find out about exiting threads and processes and what
will i check to see the user thread is exited or
kernel thread.
thanks sounak


________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
