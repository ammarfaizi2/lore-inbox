Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUHWQHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUHWQHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUHWQDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:03:18 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:3085 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266006AbUHWQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:01:24 -0400
Message-ID: <2a4f155d04082309015b81c9e9@mail.gmail.com>
Date: Mon, 23 Aug 2004 19:01:24 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1-mm4 Gdb hard freezes computer
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

when I run gdb it hard freezes whole computer. I got this in syslog :

Aug 23 18:51:11 southpark kernel: bad: scheduling while atomic!
Aug 23 18:51:11 southpark kernel:  [<c028831a>] schedule+0x4da/0x4e0
Aug 23 18:51:11 southpark kernel:  [<c011f295>] __dequeue_signal+0xd5/0x170
Aug 23 18:51:11 southpark kernel:  [<c0120edc>] ptrace_notify_info+0x7c/0xd0
Aug 23 18:51:11 southpark kernel:  [<c0120ba1>] get_signal_to_deliver+0xa1/0x360
Aug 23 18:51:11 southpark kernel:  [<c0103e13>] do_signal+0x93/0x120
Aug 23 18:51:11 southpark kernel:  [<c02880b5>] schedule+0x275/0x4e0
Aug 23 18:51:11 southpark kernel:  [<c01196ba>] do_wait+0x1da/0x3a0
Aug 23 18:51:11 southpark kernel:  [<c0113010>] default_wake_function+0x0/0x10
Aug 23 18:51:11 southpark kernel:  [<c0113010>] default_wake_function+0x0/0x10
Aug 23 18:51:11 southpark kernel:  [<c0103ed7>] do_notify_resume+0x37/0x3c
Aug 23 18:51:11 southpark kernel:  [<c01040b6>] work_notifysig+0x13/0x15


Any ideas?

P.S: Gdb version is 6.2

Cheers,
ismail
-- 
Time is what you make of it
