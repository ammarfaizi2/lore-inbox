Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUBXNqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbUBXNqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:46:35 -0500
Received: from ulm.bund.de ([194.95.179.208]:28135 "EHLO Ulm.bund.de")
	by vger.kernel.org with ESMTP id S261967AbUBXNq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:46:26 -0500
Message-Id: <403B559C.7050704@bundeskartellamt.bund.de>
Date: Tue, 24 Feb 2004 14:46:04 +0100
From: Juergen Moll <juergen.moll@bundeskartellamt.bund.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: de, de-at, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with kernel 2.6.2
Content-Type: multipart/mixed;
 boundary="------------050402000008040100070703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402000008040100070703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I encountered a problem with kernel 2.6.2, which I am using in a 
productive environment in conjunction with samba 3.0.2.

The system was running quite nicely till it stopeed with the syslog in 
the attachment. The only way to recover was to reboot the system.

Does anybody have an idea about the reason?

Greetings Juergen



--------------050402000008040100070703
Content-Type: text/plain;
 name="prob-list"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="prob-list"

Feb 24 12:36:54 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:54 hell-5 kernel: Call Trace:
Feb 24 12:36:54 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:54 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c0159d7d>] __getblk+0x1d/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:54 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:54 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:54 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:54 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:54 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:54 hell-5 kernel:
Feb 24 12:36:54 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:54 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:54 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:54 hell-5 kernel: Call Trace:
Feb 24 12:36:54 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:54 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:54 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:54 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:54 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:54 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:54 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:54 hell-5 kernel:
Feb 24 12:36:54 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:54 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:54 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:54 hell-5 kernel: Call Trace:
Feb 24 12:36:54 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:54 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:54 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:54 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:54 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:54 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:54 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:54 hell-5 kernel:
Feb 24 12:36:54 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:54 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:54 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:54 hell-5 kernel: Call Trace:
Feb 24 12:36:54 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:54 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:54 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:54 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:54 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:54 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:54 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:54 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:54 hell-5 kernel:
Feb 24 12:36:54 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:54 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:54 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:54 hell-5 kernel: Call Trace:
Feb 24 12:36:54 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:54 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:54 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:54 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:54 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:54 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:55 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:55 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:55 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:55 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:55 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:55 hell-5 kernel:
Feb 24 12:36:55 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:55 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:55 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:55 hell-5 kernel: Call Trace:
Feb 24 12:36:55 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:55 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:55 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:55 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:55 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:55 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:55 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:55 hell-5 kernel:
Feb 24 12:36:55 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:55 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:55 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:55 hell-5 kernel: Call Trace:
Feb 24 12:36:55 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:55 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:55 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:55 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:55 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:55 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:55 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:55 hell-5 kernel:
Feb 24 12:36:55 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:55 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:55 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:55 hell-5 kernel: Call Trace:
Feb 24 12:36:55 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:55 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:55 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:55 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:55 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:55 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:55 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc
Feb 24 12:36:55 hell-5 kernel:
Feb 24 12:36:55 hell-5 kernel: block=8192, b_blocknr=18446744073709551615
Feb 24 12:36:55 hell-5 kernel: b_state=0x00000000, b_size=1024
Feb 24 12:36:55 hell-5 kernel: buffer layer error at fs/buffer.c:430
Feb 24 12:36:55 hell-5 kernel: Call Trace:
Feb 24 12:36:55 hell-5 kernel:  [<c0158d6b>] __find_get_block_slow+0xbb/0x150
Feb 24 12:36:55 hell-5 kernel:  [<c0159cf1>] __find_get_block+0xa1/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c01598ed>] __getblk_slow+0x1d/0x110
Feb 24 12:36:55 hell-5 kernel:  [<c0159d99>] __getblk+0x39/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c01a512b>] journal_get_descriptor_buffer+0x3b/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c01a23c1>] journal_commit_transaction+0xf01/0x10fd
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a295>] __mod_timer+0xa5/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c012a3c0>] mod_timer+0x30/0x50
Feb 24 12:36:55 hell-5 kernel:  [<c02f39bd>] neigh_periodic_timer+0xcd/0x170
Feb 24 12:36:55 hell-5 kernel:  [<c02dddfa>] i8042_controller_init+0x3a/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c02ddbd6>] i8042_interrupt+0x46/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011eb78>] schedule+0x308/0x680
Feb 24 12:36:55 hell-5 kernel:  [<c012a479>] del_timer_sync+0x29/0x120
Feb 24 12:36:55 hell-5 kernel:  [<c011ef8d>] __wake_up+0x1d/0x30
Feb 24 12:36:55 hell-5 kernel:  [<c01a4777>] kjournald+0xc7/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c0120d00>] autoremove_wake_function+0x0/0x40
Feb 24 12:36:55 hell-5 kernel:  [<c010af06>] ret_from_fork+0x6/0x14
Feb 24 12:36:55 hell-5 kernel:  [<c01a4690>] commit_timeout+0x0/0x10
Feb 24 12:36:55 hell-5 kernel:  [<c01a46b0>] kjournald+0x0/0x250
Feb 24 12:36:55 hell-5 kernel:  [<c0109009>] kernel_thread_helper+0x5/0xc

--------------050402000008040100070703--

