Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUA1UB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266268AbUA1UB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:01:56 -0500
Received: from stone.bol.com.br ([200.221.24.18]:56966 "EHLO stone.bol.com.br")
	by vger.kernel.org with ESMTP id S266267AbUA1UBu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:01:50 -0500
Date: Wed, 28 Jan 2004 18:01:48 -0200
Message-Id: <HS7UB0$I11pQOZMlQl4ir_VnYO0gf4dUQlR2lPU85VFs@bol.com.br>
Subject: oops 2.6.1 adsl
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
From: "rollor" <rollor@bol.com.br>
To: linux-kernel@vger.kernel.org
X-XaM3-API-Version: 2.4 R3 ( B4 )
X-SenderIP: 200.102.71.169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I am testing the 2.6.1 kernel on a p4,
debian sarge. I tried to start my adsl
connection and received this:

Jan 28 17:40:54 rock pppd[913]: pppd
2.4.2 started by oot, uid 0
Jan 28 17:40:54 rock pppd[913]: Serial
connection established.
Jan 28 17:40:54 rock pppd[913]: Using
interface ppp0
Jan 28 17:40:54 rock pppd[913]:
Connect: ppp0 <--> /dev/pts/0
Jan 28 17:40:54 rock kernel: Badness
in local_bh_enable at kernel/softirq.c:121
Jan 28 17:40:54 rock kernel: Call Trace:
Jan 28 17:40:54 rock kernel: 
[local_bh_enable+133/135]
local_bh_enable+0x85/0x87     Jan 28
17:40:54 rock kernel: 
[ppp_async_push+158/373]
ppp_async_push+0x9e/0x175
Jan 28 17:40:54 rock kernel: 
[ppp_asynctty_wakeup+45/94]
ppp_asynctty_wakeup+0x2d/0x5e
Jan 28 17:40:54 rock kernel: 
[pty_unthrottle+88/90]
pty_unthrottle+0x58/0x5a         Jan
28 17:40:54 rock kernel: 
[check_unthrottle+57/59]
check_unthrottle+0x39/0x3b
Jan 28 17:40:54 rock kernel: 
[n_tty_flush_buffer+19/85]
n_tty_flush_buffer+0x13/0x55
Jan 28 17:40:54 rock kernel: 
[pty_flush_buffer+102/104]
pty_flush_buffer+0x66/0x68
Jan 28 17:40:54 rock kernel: 
[do_tty_hangup+1146/1243]
do_tty_hangup+0x47a/0x4db
Jan 28 17:40:54 rock kernel: 
[release_dev+1752/1796]
release_dev+0x6d8/0x704
Jan 28 17:40:54 rock kernel: 
[unmap_page_range+67/105]
unmap_page_range+0x43/0x69    Jan 28
17:40:54 rock pppd[913]: Modem hangup
Jan 28 17:40:54 rock kernel: 
[tty_release+45/102] tty_release+0x2d/0x66
Jan 28 17:40:54 rock pppd[913]:
Connection terminated.
Jan 28 17:40:54 rock kernel: 
[__fput+258/276] __fput+0x102/0x114
Jan 28 17:40:54 rock kernel: 
[filp_close+89/134] filp_close+0x59/0x86
Jan 28 17:40:54 rock kernel: 
[put_files_struct+132/233]
put_files_struct+0x84/0xe9   Jan 28
17:40:54 rock kernel: 
[do_exit+397/1034] do_exit+0x18d/0x40a
Jan 28 17:40:54 rock kernel: 
[do_group_exit+58/172]
do_group_exit+0x3a/0xac
Jan 28 17:40:54 rock kernel: 
[syscall_call+7/11] syscall_call+0x7/0xb

if someone needs more information,
please let me now.

PS: CC to me.

thanks.

 
__________________________________________________________________________
Acabe com aquelas janelinhas que pulam na sua tela.
AntiPop-up UOL - É grátis!
http://antipopup.uol.com.br/


