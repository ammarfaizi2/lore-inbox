Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbTGLQdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 12:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbTGLQdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 12:33:13 -0400
Received: from [195.110.126.54] ([195.110.126.54]:53768 "HELO mail.supereva.it")
	by vger.kernel.org with SMTP id S268019AbTGLQdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 12:33:11 -0400
Date: 12 Jul 2003 16:47:53 -0000
Message-ID: <20030712164753.7847.qmail@mail.supereva.it>
X-Originating-IP: [217.133.209.145]
From: dbellucci@mybox.it
Reply-To: dbellucci@mybox.it
To: linux-kernel@vger.kernel.org
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
Subject: 2.5.75 oops when run pppd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jul 12 18:19:22 laptop kernel: Badness in local_bh_enable at kernel/softirq.c:113
Jul 12 18:19:22 laptop kernel: Call Trace:
Jul 12 18:19:22 laptop kernel:  [<c0131368>] local_bh_enable+0x8c/0x8e
Jul 12 18:19:22 laptop kernel:  [<d0959021>] ppp_sync_push+0x11f/0x3d6 [ppp_synctty]
Jul 12 18:19:22 laptop kernel:  [<c0193c73>] lookup_one_len+0x63/0x72
Jul 12 18:19:22 laptop kernel:  [<d09587f7>] ppp_sync_wakeup+0x31/0x60 [ppp_synctty]
Jul 12 18:19:22 laptop kernel:  [<c023961e>] do_tty_hangup+0x6e0/0x8c6
Jul 12 18:19:22 laptop kernel:  [<c01cb368>] devpts_pty_kill+0x40/0x5d
Jul 12 18:19:22 laptop kernel:  [<c023b75b>] release_dev+0x717/0x74e
Jul 12 18:19:22 laptop kernel:  [<c0122c21>] kernel_map_pages+0x29/0x60
Jul 12 18:19:22 laptop kernel:  [<c01cda40>] ext3_release_file+0x0/0x64
Jul 12 18:19:22 laptop kernel:  [<c023bcd2>] tty_release+0x98/0x1b8
Jul 12 18:19:22 laptop kernel:  [<c023bc3a>] tty_release+0x0/0x1b8
Jul 12 18:19:22 laptop kernel:  [<c017eeba>] __fput+0x126/0x138
Jul 12 18:19:22 laptop kernel:  [<c017cf2b>] filp_close+0x4b/0x74
Jul 12 18:19:22 laptop kernel:  [<c012dd75>] put_files_struct+0x8f/0x102
Jul 12 18:19:22 laptop kernel:  [<c012f1b6>] do_exit+0x422/0xada
Jul 12 18:19:22 laptop kernel:  [<c017d058>] sys_close+0x104/0x228
Jul 12 18:19:22 laptop kernel:  [<c012f8a1>] sys_exit+0x15/0x16
Jul 12 18:19:22 laptop kernel:  [<c010afeb>] syscall_call+0x7/0xb


this oops occour when run
pppd call ....



---------------------------------------------------------
Incontri: amicizie, relazioni, trasgressione
http://incontri.supereva.it/cgi-bin/index.chm?partner=904

messaggio inviato con Freemail by www.superEva.it
---------------------------------------------------------

