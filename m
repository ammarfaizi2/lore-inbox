Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVCCPJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVCCPJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVCCPJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:09:47 -0500
Received: from web53301.mail.yahoo.com ([206.190.39.230]:4223 "HELO
	web53301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261211AbVCCPJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:09:05 -0500
Message-ID: <20050303150901.71989.qmail@web53301.mail.yahoo.com>
Date: Thu, 3 Mar 2005 15:09:01 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: architecture to implement communication between static kernel with dynamic module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there is one my_own module
which i will insert whenever i like through 
insmod.
thus when the module is loaded it will create a proc
file 

now i want to send the structure variable of
task_struct
i.e p to the module from the kernel at point when the
execution passes
through forking a new process i.e 
at the function do_fork() in fork.c in linux/kernel
folder

how to do this

how can i call the module from that point  (i.e in
do_fork())
and pass the task_struct *p as parameter to the module

can i declare an arbitary name in fork.c of my module
and compile the new kernel?
i think i cannot since i am inserting a dynamic module
to a static kernel executable
and how does the kernel will know that this module
will be attached later to it.
it will show errors while compiling the new modified
kernel

can you help me ?
what path i must take
thanks 
sounak 



________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
