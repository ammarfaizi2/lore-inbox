Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUA3F3B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUA3F3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:29:00 -0500
Received: from joel.ist.utl.pt ([193.136.198.171]:27333 "EHLO joel.ist.utl.pt")
	by vger.kernel.org with ESMTP id S266558AbUA3F27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:28:59 -0500
Date: Fri, 30 Jan 2004 05:28:54 +0000 (WET)
From: Rui Saraiva <rmps@joel.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: [2.6.2-rc2-mm1] Badness in interruptible_sleep_on
Message-ID: <Pine.LNX.4.58.0401300524360.32732@joel.ist.utl.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Badness in interruptible_sleep_on at kernel/sched.c:2239
Call Trace:
 [<c012453e>] interruptible_sleep_on+0x32e/0x340
 [<c0123880>] default_wake_function+0x0/0x10
 [<c012385a>] preempt_schedule+0x2a/0x50
 [<d195da5b>] msp3410d_thread+0x16b/0x750 [msp3400]
 [<c03202aa>] ret_from_fork+0x6/0x14
 [<d195d8f0>] msp3410d_thread+0x0/0x750 [msp3400]
 [<d195d8f0>] msp3410d_thread+0x0/0x750 [msp3400]
 [<c0109289>] kernel_thread_helper+0x5/0xc

Config at http://joel.ist.utl.pt/~rmps/config-2.6.2-rc2-mm1
If you need more info, just ask.

Regards,
  Rui Saraiva
