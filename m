Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbTCSJ7A>; Wed, 19 Mar 2003 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTCSJ7A>; Wed, 19 Mar 2003 04:59:00 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.29]:41139 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262964AbTCSJ6i>; Wed, 19 Mar 2003 04:58:38 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Latest 2.5 BK: oops in timer.c
Date: Wed, 19 Mar 2003 11:09:27 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303191109.27359.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copied from the screen, so minimal.
Note: nmi_watchdog=1

timer_interrupt+0x1a3/0x3f0
do_softirq+0xa1/0xb0
do_IRQ+0x23f/0x380
do_nmi+0x4f/0x60
common_interrupt+0x18/0x20
open_namei+0x5b/0x650
check_poison_obj+0x3b/0x1a0
filp_open+0x41/0x70
getname+0x8a/0xc0
sys_open+0x53/0x90
syscall_call+0x7/0xb
code: 89 50 04 89 02 c7 ...
timer.c:312: spin_lock already locked by kernel/timer.c/406
