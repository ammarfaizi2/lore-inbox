Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbUKHRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbUKHRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUKHRPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:15:12 -0500
Received: from mail.001hosting.com.br ([200.186.45.36]:29844 "EHLO
	001admin.com.br") by vger.kernel.org with ESMTP id S261855AbUKHQyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:54:09 -0500
X-Qmail-Scanner-Mail-From: mike@001admin.com.br via 001mail
X-Qmail-Scanner: 1.23st (Clear:RC:0(200.146.76.38):SA:0(0.0/5.0):. Processed in 0.174288 secs Process 23521)
Subject: error on kern.log
From: Mike Tesliuk <mike@001admin.com.br>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1099932798.9491.47.camel@001linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 08 Nov 2004 14:54:01 -0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello for all!!!

I have a kernel messages like this every time: 

printk: 9 messages suppressed.
perl5.6.1: page allocation failure. order:3, mode:0x20
Call Trace:
 [<c01351c5>] __alloc_pages+0x2dd/0x2ec
 [<c01351f1>] __get_free_pages+0x1d/0x38
 [<c0137d5d>] cache_grow+0xc5/0x2f8
 [<c013815b>] cache_alloc_refill+0x1cb/0x214
 [<c0138468>] __kmalloc+0x60/0x7c
 [<c02eb2cc>] alloc_skb+0x3c/0xd8
 [<c0312ec5>] tcp_fragment+0x6d/0x2ac
 [<c0315291>] tcp_write_wakeup+0xd9/0x20c
 [<c03153d7>] tcp_send_probe0+0x13/0xfc
 [<c0315f16>] tcp_probe_timer+0xa2/0xac
 [<c03163be>] tcp_write_timer+0xae/0xe4
 [<c0316310>] tcp_write_timer+0x0/0xe4
 [<c0123075>] run_timer_softirq+0x129/0x15c
 [<c011f2bc>] do_softirq+0x6c/0xcc
 [<c01131d3>] smp_apic_timer_interrupt+0x13f/0x144
 [<c010afa2>] apic_timer_interrupt+0x1a/0x20


( Im using a kernel 2.6.4 )

somebody can help me! i have this messages every time!!

what is this?

Thanks!!

Mike Tesliuk (from Brasil)



