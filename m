Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbTFRW0Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTFRW0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:26:25 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:4286 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S265575AbTFRW0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:26:20 -0400
Subject: [2.5.72] Oops on x86_64 running 32-bit code
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Message-Id: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 15:40:17 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried running BitKeeper under vanilla 2.5.72:

PML4 7ac6c067 PGD 7a872067 PMD 0
Oops: 0010 [1Ü
CPU 1
Pid: 3236, comm: bk Not tainted
RIP: 0010:[<0000000000000000>Ü [<0000000000000000>Ü
RSP: 0018:0000010037f88368  EFLAGS: 00010216
RAX: 0000000000004000 RBX: 000001007d4f2500 RCX: 0000000000000000
RDX: 000001007d4f2500 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 000001007a8e6000 R09: 0000000000000000
R10: 00000000009a0004 R11: 0000000000000000 R12: ffffffff80132f80
R13: 0000010037f881a8 R14: 0000010037f881a8 R15: 000001007e8e99c0
FS:  000000000054c480(0000) GS:ffffffff8041fd80(005b) knlGS:00000000a001b280
CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
CR2: 0000000000000000 CR3: 000000007ff14000 CR4: 00000000000007a0
Process bk (pid: 3236, stackpage=1007cd31a90)
Stack: 0000000000000000 0000000000000000 0000000000000441 00000000ffffbb00
       0000000000000246 0000000000000000 00000000ffffb698 00000000ffffb600
       0000000000000004 00000000ffffe405
Call Trace:<ffffffff80113b38>ädefault_do_nmi+56ü <ffffffff8011c787>ädo_nmi+87ü
       <ffffffff801126dc>änmi+112ü <ffffffff801320f2>äload_balance+34ü
                                                                                
                                                                                
Code:  Bad RIP value.


