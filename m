Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271700AbTHHQq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 12:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271702AbTHHQq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 12:46:26 -0400
Received: from ece-238-208.ece.gatech.edu ([130.207.238.208]:55426 "EHLO
	bharati") by vger.kernel.org with ESMTP id S271700AbTHHQoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 12:44:46 -0400
Date: Fri, 8 Aug 2003 12:48:00 -0400
From: Dheeraj <dheeraj@ece.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM : Strange logs while using Scroll-Lock key
Message-ID: <20030808164800.GA2952@bharati>
Reply-To: dheeraj@ece.gatech.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Just Home
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) I got these strange logs while i was using the console and tried to remap
    my caplock key to control key using loadkeys.
2) attached are the logs from dmesg output. 
   i got them repeated ly when i pressed scroll-lock key
3) console, scroll-lock, character i/o
4) Linux version 2.6.0-test2 (root@bharati) (gcc version 3.3.1 20030728 (Debian prerelease)) #2 Wed Aug 6 18:26:10 EDT 2003

5) 

============================================================================
Aug  8 12:18:53 bharati kernel: a3 00000000 c015cdbe 00000246 c0e59c80 
Aug  8 12:18:53 bharati kernel:        d89b8de8 00000000 7fffffff ce1d5f60 7fffffff c012393a c0380060 c0263ff7 
Aug  8 12:18:53 bharati kernel:        de6c9300 c1a16500 ce1d5fa0 00000145 c015d6c9 de6c9300 ce1d5fa0 d89b8de0 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:53 bharati kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:53 bharati kernel:  [do_pollfd+79/144] do_pollfd+0x4f/0x90
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: mozilla-bin   S C0135FA3 4290835376  1105    985          1255  1104 (NOTLB)
Aug  8 12:18:53 bharati kernel: ce1d3f08 00000086 d34e3c98 c0135fa3 00000000 c015cdbe 00000246 c0e59680 
Aug  8 12:18:53 bharati kernel:        d89b8c48 00000000 7fffffff ce1d3f60 7fffffff c012393a c0380060 c0263ff7 
Aug  8 12:18:53 bharati kernel:        de6c9100 d34e3c80 ce1d3fa0 00000145 c015d6c9 de6c9100 ce1d3fa0 d89b8c40 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:53 bharati kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:53 bharati kernel:  [do_pollfd+79/144] do_pollfd+0x4f/0x90
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: java_vm       S B443FEA5 4291484080  1106   1091          1107  1103 (NOTLB)
Aug  8 12:18:53 bharati kernel: ce271d80 00000086 ac1ff52d b443fea5 e5b7fabf 00000001 ce271d84 c01182f0 
Aug  8 12:18:53 bharati kernel:        d4047c3f ce270000 7fffffff ffffe000 7fffffff c012393a c0118d1e d27b9380 
Aug  8 12:18:53 bharati kernel:        00000001 00000000 00000000 ce271dbc d27b9380 00000001 ce271dc4 00000246 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [default_wake_function+42/46] default_wake_function+0x2a/0x2e
Aug  8 12:18:53 bharati kernel:  [unix_stream_data_wait+199/272] unix_stream_data_wait+0xc7/0x110
Aug  8 12:18:53 bharati kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Aug  8 12:18:53 bharati kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Aug  8 12:18:53 bharati kernel:  [unix_stream_recvmsg+1325/1415] unix_stream_recvmsg+0x52d/0x587
Aug  8 12:18:53 bharati kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43
Aug  8 12:18:53 bharati kernel:  [sock_aio_read+184/208] sock_aio_read+0xb8/0xd0
Aug  8 12:18:53 bharati kernel:  [do_sync_read+139/183] do_sync_read+0x8b/0xb7
Aug  8 12:18:53 bharati kernel:  [do_page_fault+594/1110] do_page_fault+0x252/0x456
Aug  8 12:18:53 bharati kernel:  [run_timer_softirq+271/430] run_timer_softirq+0x10f/0x1ae
Aug  8 12:18:53 bharati kernel:  [do_timer+223/228] do_timer+0xdf/0xe4
Aug  8 12:18:53 bharati kernel:  [vfs_read+232/281] vfs_read+0xe8/0x119
Aug  8 12:18:53 bharati kernel:  [schedule+433/944] schedule+0x1b1/0x3b0
Aug  8 12:18:53 bharati kernel:  [sys_read+66/99] sys_read+0x42/0x63
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: java_vm       S 00000000 4294951216  1107   1091          1108  1106 (NOTLB)
Aug  8 12:18:53 bharati kernel: ce1fdf8c 00000086 00000000 00000000 c0110fad bddff110 000000a0 cfba7b00 
Aug  8 12:18:53 bharati kernel:        bddff0b8 00000000 ce1fdfc4 ce1fc000 00000000 c0109a7d ce1fdfa8 bddff3ac 
Aug  8 12:18:53 bharati kernel:        00000008 80000004 00000000 00000004 00000000 bddff3ac 4002605c bddff3ac 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [restore_i387+122/124] restore_i387+0x7a/0x7c
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: java_vm       S CE163F20 4294321968  1108   1091                1107 (NOTLB)
Aug  8 12:18:53 bharati kernel: ce163ef8 00000086 000f41a8 ce163f20 00000000 00000246 ce162000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 ce162000 ce163f68 00000000 00000000 c012cfbd ce163f68 ce163f18 
Aug  8 12:18:53 bharati kernel:        00000000 ce163f20 c03dd540 ce16201c 0000001d 3b8b7050 04a35550 00000001 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [dput+34/511] dput+0x22/0x1ff
Aug  8 12:18:53 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: mozilla-bin   S CBC4E180 8051120  1255    985                1105 (NOTLB)
Aug  8 12:18:53 bharati kernel: cf673f8c 00000086 c03dff10 cbc4e180 00001000 d4348800 c014b7a9 d51ef680 
Aug  8 12:18:53 bharati kernel:        00000001 00000000 cf673fc4 cf672000 00000000 c0109a7d cf673fa8 bf1ff8ac 
Aug  8 12:18:53 bharati kernel:        00000008 80000000 00000000 00000000 00000000 bf1ff8ac 400ce05c bf1ff8ac 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [vfs_read+201/281] vfs_read+0xc9/0x119
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: aterm         S 00000000 4101246256  2552      1  2554    2560   978 (NOTLB)
Aug  8 12:18:53 bharati kernel: c2941eb4 00000086 c033ed84 00000000 000000d0 00000246 000000d0 ccd8dd80 
Aug  8 12:18:53 bharati kernel:        c2941f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:53 bharati kernel:        cca50000 cca50920 c2941f44 ce149280 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [sock_ioctl+0/649] sock_ioctl+0x0/0x289
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: tcsh          S C22EBFC4 4001787184  2554   2552  2555               (NOTLB)
Aug  8 12:18:53 bharati kernel: c22ebf8c 00000082 bfff591c c22ebfc4 80000002 00000000 c22ebfa8 c0126671 
Aug  8 12:18:53 bharati kernel:        c22ebfa8 00000000 c22ebfc4 c22ea000 00000000 c0109a7d c22ebfa8 bfff5840 
Aug  8 12:18:53 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5840 00000101 80000002 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: irssi         S 00000246 102168880  2555   2554                     (NOTLB)
Aug  8 12:18:53 bharati kernel: d9bf3f08 00000086 00000246 00000246 ded56100 00000246 d9bf2000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2f0ea d9bf3f1c d9bf3f60 000001c8 c01238e8 d9bf3f1c c0263ff7 
Aug  8 12:18:53 bharati kernel:        ccd8d700 c03dc5a8 dfd87f64 04a2f0ea 4b87ad6e c0123880 d3a82100 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: aterm         S 00000000 4218169136  2560      1  2561    2568  2552 (NOTLB)
Aug  8 12:18:53 bharati kernel: db44deb4 00000082 c033ed84 00000000 000000d0 00000246 000000d0 ce149700 
Aug  8 12:18:53 bharati kernel:        db44df44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:53 bharati kernel:        da9b8000 da9b8920 db44df44 ce149380 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [sock_ioctl+0/649] sock_ioctl+0x0/0x289
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: tcsh          S DB3DBFC4 127230256  2561   2560  2562               (NOTLB)
Aug  8 12:18:53 bharati kernel: db3dbf8c 00000086 bfff591c db3dbfc4 80000002 00000000 db3dbfa8 c0126671 
Aug  8 12:18:53 bharati kernel:        db3dbfa8 00000000 db3dbfc4 db3da000 00000000 c0109a7d db3dbfa8 bfff5840 
Aug  8 12:18:53 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5840 00000101 80000002 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: irssi         S 00000246 132828336  2562   2561                     (NOTLB)
Aug  8 12:18:53 bharati kernel: db143f08 00000082 00000246 00000246 da1e5b00 00000246 db142000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2efe6 db143f1c db143f60 000001f5 c01238e8 db143f1c c0263ff7 
Aug  8 12:18:53 bharati kernel:        d0b4ba00 c03dc358 c03dc358 04a2efe6 4b87ad6e c0123880 d3294d80 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: emacs         S 00000000 425741744  2568      1          2571  2560 (NOTLB)
Aug  8 12:18:53 bharati kernel: daeebeb4 00000086 c033ed84 00000000 000000d0 00000246 daeea000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 0a98d036 daeebec8 00000005 00000005 c01238e8 daeebec8 00000010 
Aug  8 12:18:53 bharati kernel:        00000004 c03dca38 c03dca38 0a98d036 4b87ad6e c0123880 c18e4c80 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xterm         S 00000000 25438128  2571      1  2572    2615  2568 (NOTLB)
Aug  8 12:18:53 bharati kernel: c3129eb4 00000086 c033ed84 00000000 000000d0 c3129f2c 000000d0 d0b4b880 
Aug  8 12:18:53 bharati kernel:        c3129f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:53 bharati kernel:        c334a000 c334a920 c3129f44 d82d1e80 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: tcsh          S C30EBFC4 25182640  2572   2571  2575               (NOTLB)
Aug  8 12:18:53 bharati kernel: c30ebf8c 00000082 bfff594c c30ebfc4 80000002 00000000 c30ebfa8 c0126671 
Aug  8 12:18:53 bharati kernel:        c30ebfa8 00000000 c30ebfc4 c30ea000 00000000 c0109a7d c30ebfa8 bfff5870 
Aug  8 12:18:53 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5870 00000101 80000002 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: wmclock       S DD5E5F20 242345904  2575   2572          2655       (NOTLB)
Aug  8 12:18:53 bharati kernel: dd5e5ef8 00000082 000f41a8 dd5e5f20 00000000 00000246 dd5e4000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 dd5e4000 dd5e5f68 00000000 00000000 c012cfbd dd5e5f68 dd5e5f18 
Aug  8 12:18:53 bharati kernel:        00000000 dd5e5f20 c03dd540 dd5e401c 00000000 02faf080 04a2efa3 00000001 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [sys_select+552/1199] sys_select+0x228/0x4af
Aug  8 12:18:53 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xterm         S 00000000 3026352  2615      1  2616    2636  2571 (NOTLB)
Aug  8 12:18:53 bharati kernel: cf1a9eb4 00000082 c033ed84 00000000 000000d0 d2a20680 000000d0 d0750d80 
Aug  8 12:18:53 bharati kernel:        cf1a9f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:53 bharati kernel:        d02d3000 d02d3920 cf1a9f44 d0750b80 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: tcsh          S D0FA5FC4 34468784  2616   2615  2627               (NOTLB)
Aug  8 12:18:53 bharati kernel: d0fa5f8c 00000086 bfff594c d0fa5fc4 80000002 00000000 d0fa5fa8 c0126671 
Aug  8 12:18:53 bharati kernel:        d0fa5fa8 00000000 d0fa5fc4 d0fa4000 00000000 c0109a7d d0fa5fa8 bfff5870 
Aug  8 12:18:53 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5870 00000101 80000002 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: mutt          S CF868000 4275696436  2627   2616                     (NOTLB)
Aug  8 12:18:53 bharati kernel: ccf9ff08 00000082 00000246 cf868000 ccf9ffa0 00000246 ccf9e000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a3461e ccf9ff1c ccf9ff60 000927c1 c01238e8 ccf9ff1c 00000000 
Aug  8 12:18:53 bharati kernel:        c01d29f0 ce163f68 c03dc690 04a3461e 4b87ad6e c0123880 ce1fe700 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S C0135FA3 4290904368  2636      1  2637          2615 (NOTLB)
Aug  8 12:18:53 bharati kernel: c8731f08 00000082 c1a16e18 c0135fa3 00000000 00000246 c8730000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2ef78 c8731f1c c8731f60 0000000a c01238e8 c8731f1c d07f7c80 
Aug  8 12:18:53 bharati kernel:        d890f780 cb64fec8 c03dbfe8 04a2ef78 4b87ad6e c0123880 c8b0f900 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S 000000D0 44144944  2637   2636  2638               (NOTLB)
Aug  8 12:18:53 bharati kernel: d0c19f08 00000082 c010c37c 000000d0 d07f7e00 00000246 d0c18000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2f073 d0c19f1c d0c19f60 000007d1 c01238e8 d0c19f1c d07f7e00 
Aug  8 12:18:53 bharati kernel:        ce7039c0 dfd87f64 c03dc5a8 04a2f073 4b87ad6e c0123880 ce1fe100 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [do_IRQ+258/309] do_IRQ+0x102/0x135
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:53 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S 00000000 143009584  2638   2637          2641       (NOTLB)
Aug  8 12:18:53 bharati kernel: d1373eb4 00000082 c033ed84 00000000 000000d0 00000246 d1372000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2efc9 d1373ec8 00000005 00000005 c01238e8 d1373ec8 00000010 
Aug  8 12:18:53 bharati kernel:        00000004 c03dc270 c03dc270 04a2efc9 4b87ad6e c0123880 c8b0f300 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S CC381F20 59182384  2641   2637          2642  2638 (NOTLB)
Aug  8 12:18:53 bharati kernel: cc381ef8 00000082 000f41a8 cc381f20 00000000 00000246 cc380000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 cc380000 cc381f68 00000000 00000000 c012cfbd cc381f68 cc381f18 
Aug  8 12:18:53 bharati kernel:        00000000 cc381f20 c03dd540 cc38001c 00000000 1dcd6500 04a2effc 00000001 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S CC157F20 56914736  2642   2637          2643  2641 (NOTLB)
Aug  8 12:18:53 bharati kernel: cc157ef8 00000082 000f41a8 cc157f20 00000000 00000246 cc156000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 cc156000 cc157f68 00000000 00000000 c012cfbd cc157f68 cc157f18 
Aug  8 12:18:53 bharati kernel:        00000000 cc157f20 c03dd540 cc15601c 00000000 00989680 04a2ef75 00000001 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          S 000000D0 47077680  2643   2637          2644  2642 (NOTLB)
Aug  8 12:18:53 bharati kernel: cb7f5eb4 00000082 00000000 000000d0 ceeb1880 00000246 cb7f4000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2ef7f cb7f5ec8 0000000b 0000000b c01238e8 cb7f5ec8 ceeb1880 
Aug  8 12:18:53 bharati kernel:        c92efb18 c03dc020 d37e7f1c 04a2ef7f 4b87ad6e c0123880 c8b0e100 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [sys_socketcall+475/652] sys_socketcall+0x1db/0x28c
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: xmms          R C033ED84 4293238960  2644   2637                2643 (NOTLB)
Aug  8 12:18:53 bharati kernel: cb64feb4 00000082 00000010 c033ed84 00000000 00000246 cb64e000 00000246 
Aug  8 12:18:53 bharati kernel:        c03dbc20 04a2ef78 cb64fec8 0000000d 0000000d c01238e8 cb64fec8 df486680 
Aug  8 12:18:53 bharati kernel:        df486680 c03dbfe8 c8731f1c 04a2ef78 4b87ad6e c0123880 cb7f3980 c03dbc20 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:53 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:53 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:53 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:53 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:53 bharati kernel: vi            S 00000000 133923248  2655   2572                2575 (NOTLB)
Aug  8 12:18:53 bharati kernel: d6e7fe80 00000086 c3349000 00000000 d6e7fe68 00000020 30335b1b 444f5464 
Aug  8 12:18:53 bharati kernel:        75203a4f d82d1780 7fffffff d6e7e000 000000ff c012393a 6120554e 736d6f74 
Aug  8 12:18:53 bharati kernel:        206f7320 74616874 74626220 736c6f6f 6262202c 666e6f63 485b1b2c 00000246 
Aug  8 12:18:53 bharati kernel: Call Trace:
Aug  8 12:18:53 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:53 bharati kernel:  [read_chan+1766/2146] read_chan+0x6e6/0x862
Aug  8 12:18:53 bharati kernel:  [write_chan+354/549] write_chan+0x162/0x225
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:53 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:53 bharati kernel:  [read_chan+0/2146] read_chan+0x0/0x862
Aug  8 12:18:53 bharati kernel:  [tty_read+290/325] tty_read+0x122/0x145
Aug  8 12:18:53 bharati kernel:  [sys_rt_sigaction+163/277] sys_rt_sigaction+0xa3/0x115
Aug  8 12:18:53 bharati kernel:  [vfs_read+176/281] vfs_read+0xb0/0x119
Aug  8 12:18:53 bharati kernel:  [sys_read+66/99] sys_read+0x42/0x63
Aug  8 12:18:53 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:53 bharati kernel: 
Aug  8 12:18:57 bharati kernel: a3 00000000 c015cdbe 00000246 c0e59c80 
Aug  8 12:18:57 bharati kernel:        d89b8de8 00000000 7fffffff ce1d5f60 7fffffff c012393a c0380060 c0263ff7 
Aug  8 12:18:57 bharati kernel:        de6c9300 c1a16500 ce1d5fa0 00000145 c015d6c9 de6c9300 ce1d5fa0 d89b8de0 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:57 bharati kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:57 bharati kernel:  [do_pollfd+79/144] do_pollfd+0x4f/0x90
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: mozilla-bin   S C0135FA3 4290835376  1105    985          1255  1104 (NOTLB)
Aug  8 12:18:57 bharati kernel: ce1d3f08 00000086 d34e3c98 c0135fa3 00000000 c015cdbe 00000246 c0e59680 
Aug  8 12:18:57 bharati kernel:        d89b8c48 00000000 7fffffff ce1d3f60 7fffffff c012393a c0380060 c0263ff7 
Aug  8 12:18:57 bharati kernel:        de6c9100 d34e3c80 ce1d3fa0 00000145 c015d6c9 de6c9100 ce1d3fa0 d89b8c40 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:57 bharati kernel:  [__pollwait+133/198] __pollwait+0x85/0xc6
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:57 bharati kernel:  [do_pollfd+79/144] do_pollfd+0x4f/0x90
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: java_vm       S B443FEA5 4291484080  1106   1091          1107  1103 (NOTLB)
Aug  8 12:18:57 bharati kernel: ce271d80 00000086 ac1ff52d b443fea5 e5b7fabf 00000001 ce271d84 c01182f0 
Aug  8 12:18:57 bharati kernel:        d4047c3f ce270000 7fffffff ffffe000 7fffffff c012393a c0118d1e d27b9380 
Aug  8 12:18:57 bharati kernel:        00000001 00000000 00000000 ce271dbc d27b9380 00000001 ce271dc4 00000246 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [try_to_wake_up+173/331] try_to_wake_up+0xad/0x14b
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [default_wake_function+42/46] default_wake_function+0x2a/0x2e
Aug  8 12:18:57 bharati kernel:  [unix_stream_data_wait+199/272] unix_stream_data_wait+0xc7/0x110
Aug  8 12:18:57 bharati kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Aug  8 12:18:57 bharati kernel:  [autoremove_wake_function+0/79] autoremove_wake_function+0x0/0x4f
Aug  8 12:18:57 bharati kernel:  [unix_stream_recvmsg+1325/1415] unix_stream_recvmsg+0x52d/0x587
Aug  8 12:18:57 bharati kernel:  [preempt_schedule+42/67] preempt_schedule+0x2a/0x43
Aug  8 12:18:57 bharati kernel:  [sock_aio_read+184/208] sock_aio_read+0xb8/0xd0
Aug  8 12:18:57 bharati kernel:  [do_sync_read+139/183] do_sync_read+0x8b/0xb7
Aug  8 12:18:57 bharati kernel:  [do_page_fault+594/1110] do_page_fault+0x252/0x456
Aug  8 12:18:57 bharati kernel:  [run_timer_softirq+271/430] run_timer_softirq+0x10f/0x1ae
Aug  8 12:18:57 bharati kernel:  [do_timer+223/228] do_timer+0xdf/0xe4
Aug  8 12:18:57 bharati kernel:  [vfs_read+232/281] vfs_read+0xe8/0x119
Aug  8 12:18:57 bharati kernel:  [schedule+433/944] schedule+0x1b1/0x3b0
Aug  8 12:18:57 bharati kernel:  [sys_read+66/99] sys_read+0x42/0x63
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: java_vm       S 00000000 4294951216  1107   1091          1108  1106 (NOTLB)
Aug  8 12:18:57 bharati kernel: ce1fdf8c 00000086 00000000 00000000 c0110fad bddff110 000000a0 cfba7b00 
Aug  8 12:18:57 bharati kernel:        bddff0b8 00000000 ce1fdfc4 ce1fc000 00000000 c0109a7d ce1fdfa8 bddff3ac 
Aug  8 12:18:57 bharati kernel:        00000008 80000004 00000000 00000004 00000000 bddff3ac 4002605c bddff3ac 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [restore_i387+122/124] restore_i387+0x7a/0x7c
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: java_vm       S CE163F20 4294321968  1108   1091                1107 (NOTLB)
Aug  8 12:18:57 bharati kernel: ce163ef8 00000086 000f41a8 ce163f20 00000000 00000246 ce162000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 ce162000 ce163f68 00000000 00000000 c012cfbd ce163f68 ce163f18 
Aug  8 12:18:57 bharati kernel:        00000000 ce163f20 c03dd540 ce16201c 0000001d 3b8b7050 04a35550 00000001 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [dput+34/511] dput+0x22/0x1ff
Aug  8 12:18:57 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: mozilla-bin   S CBC4E180 8051120  1255    985                1105 (NOTLB)
Aug  8 12:18:57 bharati kernel: cf673f8c 00000086 c03dff10 cbc4e180 00001000 d4348800 c014b7a9 d51ef680 
Aug  8 12:18:57 bharati kernel:        00000001 00000000 cf673fc4 cf672000 00000000 c0109a7d cf673fa8 bf1ff8ac 
Aug  8 12:18:57 bharati kernel:        00000008 80000000 00000000 00000000 00000000 bf1ff8ac 400ce05c bf1ff8ac 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [vfs_read+201/281] vfs_read+0xc9/0x119
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: aterm         S 00000000 4101246256  2552      1  2554    2560   978 (NOTLB)
Aug  8 12:18:57 bharati kernel: c2941eb4 00000086 c033ed84 00000000 000000d0 00000246 000000d0 ccd8dd80 
Aug  8 12:18:57 bharati kernel:        c2941f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:57 bharati kernel:        cca50000 cca50920 c2941f44 ce149280 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [sock_ioctl+0/649] sock_ioctl+0x0/0x289
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: tcsh          S C22EBFC4 4001787184  2554   2552  2555               (NOTLB)
Aug  8 12:18:57 bharati kernel: c22ebf8c 00000082 bfff591c c22ebfc4 80000002 00000000 c22ebfa8 c0126671 
Aug  8 12:18:57 bharati kernel:        c22ebfa8 00000000 c22ebfc4 c22ea000 00000000 c0109a7d c22ebfa8 bfff5840 
Aug  8 12:18:57 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5840 00000101 80000002 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: irssi         S 00000246 102168880  2555   2554                     (NOTLB)
Aug  8 12:18:57 bharati kernel: d9bf3f08 00000086 00000246 00000246 ded56100 00000246 c7efb000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a3008d d9bf3f1c d9bf3f60 000001c4 c01238e8 d9bf3f1c c0263ff7 
Aug  8 12:18:57 bharati kernel:        ccd8d700 c03dc428 cc381f68 04a3008d 4b87ad6e c0123880 d3a82100 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: aterm         S 00000000 4218169136  2560      1  2561    2568  2552 (NOTLB)
Aug  8 12:18:57 bharati kernel: db44deb4 00000082 c033ed84 00000000 000000d0 00000246 000000d0 ce149700 
Aug  8 12:18:57 bharati kernel:        db44df44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:57 bharati kernel:        da9b8000 da9b8920 db44df44 ce149380 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [sock_ioctl+0/649] sock_ioctl+0x0/0x289
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: tcsh          S DB3DBFC4 127230256  2561   2560  2562               (NOTLB)
Aug  8 12:18:57 bharati kernel: db3dbf8c 00000086 bfff591c db3dbfc4 80000002 00000000 db3dbfa8 c0126671 
Aug  8 12:18:57 bharati kernel:        db3dbfa8 00000000 db3dbfc4 db3da000 00000000 c0109a7d db3dbfa8 bfff5840 
Aug  8 12:18:57 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5840 00000101 80000002 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: irssi         S 00000246 132828336  2562   2561                     (NOTLB)
Aug  8 12:18:57 bharati kernel: db143f08 00000082 00000246 00000246 da1e5b00 00000246 db142000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a3007e db143f1c db143f60 000001f4 c01238e8 db143f1c c0263ff7 
Aug  8 12:18:57 bharati kernel:        d0b4ba00 cc381f68 dfd87f64 04a3007e 4b87ad6e c0123880 d3294d80 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [sock_poll+41/49] sock_poll+0x29/0x31
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: emacs         S 00000000 425741744  2568      1          2571  2560 (NOTLB)
Aug  8 12:18:57 bharati kernel: daeebeb4 00000086 c033ed84 00000000 000000d0 00000246 daeea000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 0a98e071 daeebec8 00000005 00000005 c01238e8 daeebec8 00000010 
Aug  8 12:18:57 bharati kernel:        00000004 c03dca38 c03dca38 0a98e071 4b87ad6e c0123880 c18e4c80 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xterm         S 00000000 25438128  2571      1  2572    2615  2568 (NOTLB)
Aug  8 12:18:57 bharati kernel: c3129eb4 00000086 c033ed84 00000000 000000d0 c3129f2c 000000d0 d0b4b880 
Aug  8 12:18:57 bharati kernel:        c3129f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:57 bharati kernel:        c334a000 c334a920 c3129f44 d82d1e80 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: tcsh          S C30EBFC4 25182640  2572   2571  2575               (NOTLB)
Aug  8 12:18:57 bharati kernel: c30ebf8c 00000082 bfff594c c30ebfc4 80000002 00000000 c30ebfa8 c0126671 
Aug  8 12:18:57 bharati kernel:        c30ebfa8 00000000 c30ebfc4 c30ea000 00000000 c0109a7d c30ebfa8 bfff5870 
Aug  8 12:18:57 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5870 00000101 80000002 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: wmclock       S DD5E5F20 242345904  2575   2572          2655       (NOTLB)
Aug  8 12:18:57 bharati kernel: dd5e5ef8 00000082 000f41a8 dd5e5f20 00000000 00000246 dd5e4000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 dd5e4000 dd5e5f68 00000000 00000000 c012cfbd dd5e5f68 dd5e5f18 
Aug  8 12:18:57 bharati kernel:        00000000 dd5e5f20 c03dd540 dd5e401c 00000000 02faf080 04a2ffac 00000001 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [sys_select+552/1199] sys_select+0x228/0x4af
Aug  8 12:18:57 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xterm         S 00000000 3026352  2615      1  2616    2636  2571 (NOTLB)
Aug  8 12:18:57 bharati kernel: cf1a9eb4 00000082 c033ed84 00000000 000000d0 d2a20680 000000d0 d0750d80 
Aug  8 12:18:57 bharati kernel:        cf1a9f44 00000000 7fffffff 00000005 00000005 c012393a 00000000 c01d6f03 
Aug  8 12:18:57 bharati kernel:        d02d3000 d02d3920 cf1a9f44 d0750b80 00000010 00000004 00000004 c01d29f0 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [normal_poll+237/317] normal_poll+0xed/0x13d
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: tcsh          S D0FA5FC4 34468784  2616   2615  2627               (NOTLB)
Aug  8 12:18:57 bharati kernel: d0fa5f8c 00000086 bfff594c d0fa5fc4 80000002 00000000 d0fa5fa8 c0126671 
Aug  8 12:18:57 bharati kernel:        d0fa5fa8 00000000 d0fa5fc4 d0fa4000 00000000 c0109a7d d0fa5fa8 bfff5870 
Aug  8 12:18:57 bharati kernel:        00000008 80010002 00000000 80000002 00000000 bfff5870 00000101 80000002 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [sigprocmask+65/180] sigprocmask+0x41/0xb4
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigsuspend+190/259] sys_rt_sigsuspend+0xbe/0x103
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: mutt          S CF868000 4275696436  2627   2616                     (NOTLB)
Aug  8 12:18:57 bharati kernel: ccf9ff08 00000082 00000246 cf868000 ccf9ffa0 00000246 ccf9e000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a3461e ccf9ff1c ccf9ff60 000927c1 c01238e8 ccf9ff1c 00000000 
Aug  8 12:18:57 bharati kernel:        c01d29f0 ce163f68 c03dc690 04a3461e 4b87ad6e c0123880 ce1fe700 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S C0135FA3 4290904368  2636      1  2637          2615 (NOTLB)
Aug  8 12:18:57 bharati kernel: c8731f08 00000082 c1a16e18 c0135fa3 00000000 00000246 c8730000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a2ff80 c8731f1c c8731f60 0000000a c01238e8 c8731f1c d07f7c80 
Aug  8 12:18:57 bharati kernel:        d890f780 c03dc028 c03dc028 04a2ff80 4b87ad6e c0123880 c8b0f900 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [__get_free_pages+31/65] __get_free_pages+0x1f/0x41
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S 000000D0 44144944  2637   2636  2638               (NOTLB)
Aug  8 12:18:57 bharati kernel: d0c19f08 00000082 c010c37c 000000d0 d07f7e00 00000246 d0c18000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a3007a d0c19f1c d0c19f60 000007d1 c01238e8 d0c19f1c d07f7e00 
Aug  8 12:18:57 bharati kernel:        ce7039c0 dfd87f64 d37e7f1c 04a3007a 4b87ad6e c0123880 ce1fe100 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [do_IRQ+258/309] do_IRQ+0x102/0x135
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_poll+161/192] do_poll+0xa1/0xc0
Aug  8 12:18:57 bharati kernel:  [sys_poll+412/654] sys_poll+0x19c/0x28e
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S 00000000 143009584  2638   2637          2641       (NOTLB)
Aug  8 12:18:57 bharati kernel: d1373eb4 00000082 c033ed84 00000000 000000d0 00000246 d1372000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a2ffb0 d1373ec8 00000005 00000005 c01238e8 d1373ec8 00000010 
Aug  8 12:18:57 bharati kernel:        00000004 c03dc1a8 c03dc1a8 04a2ffb0 4b87ad6e c0123880 c8b0f300 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S CC381F20 59182384  2641   2637          2642  2638 (NOTLB)
Aug  8 12:18:57 bharati kernel: cc381ef8 00000082 000f41a8 cc381f20 00000000 00000246 cc380000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 cc380000 cc381f68 00000000 00000000 c012cfbd cc381f68 cc381f18 
Aug  8 12:18:57 bharati kernel:        00000000 cc381f20 c03dd540 cc38001c 00000000 1dcd6500 04a30088 00000001 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S CC157F20 56914736  2642   2637          2643  2641 (NOTLB)
Aug  8 12:18:57 bharati kernel: cc157ef8 00000082 000f41a8 cc157f20 00000000 00000246 cc156000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 cc156000 cc157f68 00000000 00000000 c012cfbd cc157f68 cc157f18 
Aug  8 12:18:57 bharati kernel:        00000000 cc157f20 c03dd540 cc15601c 00000000 00989680 04a2ff83 00000001 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [do_clock_nanosleep+412/749] do_clock_nanosleep+0x19c/0x2ed
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [nanosleep_wake_up+0/9] nanosleep_wake_up+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [sys_nanosleep+125/252] sys_nanosleep+0x7d/0xfc
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          S 000000D0 47077680  2643   2637          2644  2642 (NOTLB)
Aug  8 12:18:57 bharati kernel: cb7f5eb4 00000082 00000000 000000d0 ceeb1880 00000246 cb7f4000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a2ff8f cb7f5ec8 0000000b 0000000b c01238e8 cb7f5ec8 ceeb1880 
Aug  8 12:18:57 bharati kernel:        c92efb18 c03dc0a0 c03dc0a0 04a2ff8f 4b87ad6e c0123880 c8b0e100 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [sys_socketcall+475/652] sys_socketcall+0x1db/0x28c
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: xmms          R C033ED84 4293238960  2644   2637                2643 (NOTLB)
Aug  8 12:18:57 bharati kernel: cb64feb4 00000082 00000010 c033ed84 00000000 00000246 cb64e000 00000246 
Aug  8 12:18:57 bharati kernel:        c03dbc20 04a2ff83 cb64fec8 0000000d 0000000d c01238e8 cb64fec8 df486680 
Aug  8 12:18:57 bharati kernel:        df486680 c03dc040 cc157f68 04a2ff83 4b87ad6e c0123880 cb7f3980 c03dbc20 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+95/179] schedule_timeout+0x5f/0xb3
Aug  8 12:18:57 bharati kernel:  [process_timeout+0/9] process_timeout+0x0/0x9
Aug  8 12:18:57 bharati kernel:  [do_select+398/712] do_select+0x18e/0x2c8
Aug  8 12:18:57 bharati kernel:  [__pollwait+0/198] __pollwait+0x0/0xc6
Aug  8 12:18:57 bharati kernel:  [sys_select+691/1199] sys_select+0x2b3/0x4af
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 
Aug  8 12:18:57 bharati kernel: vi            S 00000000 133923248  2655   2572                2575 (NOTLB)
Aug  8 12:18:57 bharati kernel: d6e7fe80 00000086 c3349000 00000000 d6e7fe68 00000020 30335b1b 444f5464 
Aug  8 12:18:57 bharati kernel:        75203a4f d82d1780 7fffffff d6e7e000 000000ff c012393a 6120554e 736d6f74 
Aug  8 12:18:57 bharati kernel:        206f7320 74616874 74626220 736c6f6f 6262202c 666e6f63 485b1b2c 00000246 
Aug  8 12:18:57 bharati kernel: Call Trace:
Aug  8 12:18:57 bharati kernel:  [schedule_timeout+177/179] schedule_timeout+0xb1/0xb3
Aug  8 12:18:57 bharati kernel:  [read_chan+1766/2146] read_chan+0x6e6/0x862
Aug  8 12:18:57 bharati kernel:  [write_chan+354/549] write_chan+0x162/0x225
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [tty_poll+96/116] tty_poll+0x60/0x74
Aug  8 12:18:57 bharati kernel:  [default_wake_function+0/46] default_wake_function+0x0/0x2e
Aug  8 12:18:57 bharati kernel:  [read_chan+0/2146] read_chan+0x0/0x862
Aug  8 12:18:57 bharati kernel:  [tty_read+290/325] tty_read+0x122/0x145
Aug  8 12:18:57 bharati kernel:  [sys_rt_sigaction+163/277] sys_rt_sigaction+0xa3/0x115
Aug  8 12:18:57 bharati kernel:  [vfs_read+176/281] vfs_read+0xb0/0x119
Aug  8 12:18:57 bharati kernel:  [sys_read+66/99] sys_read+0x42/0x63
Aug  8 12:18:57 bharati kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 12:18:57 bharati kernel: 

========================================================================
6) I could not reproduce the problem reliably.

7) Debian Unstable; XFree86 running on tty7

7.1) 
Linux bharati 2.6.0-test2 #2 Wed Aug 6 18:26:10 EDT 2003 i686 GNU/Linux
 
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34-WIP
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd nvidia

7.2) 
  
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping	: 4
cpu MHz		: 1994.608
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3932.16


7.3) 

snd_seq_oss 33920 0 - Live 0xe0937000
snd_seq_midi_event 7552 1 snd_seq_oss, Live 0xe08d7000
snd_seq 54032 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0928000
snd_pcm_oss 52260 0 - Live 0xe08e0000
snd_mixer_oss 18944 1 snd_pcm_oss, Live 0xe08da000
snd_intel8x0 30372 0 - Live 0xe08c2000
snd_ac97_codec 50052 1 snd_intel8x0, Live 0xe0909000
snd_pcm 96164 2 snd_pcm_oss,snd_intel8x0, Live 0xe08f0000
snd_timer 25220 2 snd_seq,snd_pcm, Live 0xe08cb000
snd_page_alloc 10372 2 snd_intel8x0,snd_pcm, Live 0xe08a1000
snd_mpu401_uart 7808 1 snd_intel8x0, Live 0xe08bf000
snd_rawmidi 24608 1 snd_mpu401_uart, Live 0xe08a9000
snd_seq_device 8200 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe08a5000
snd 49892 12 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device, Live 0xe08b1000
nvidia 1701228 0 - Live 0xe0a72000

7.4)
   
/proc/ioports:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
d800-d8ff : Intel Corp. 82801BA/BAM AC'97 Au
  d800-d8ff : Intel 82801BA-ICH2 - AC'97
dc40-dc7f : Intel Corp. 82801BA/BAM AC'97 Au
  dc40-dc7f : Intel 82801BA-ICH2 - Controller
dcd0-dcdf : Intel Corp. 82801BA/BAM SMBus
ec80-ecff : 3Com Corporation 3c905C-TX/TX-M [Torn
  ec80-ecff : 0000:02:0c.0
ff60-ff7f : Intel Corp. 82801BA/BAM USB (Hub
ff80-ff9f : Intel Corp. 82801BA/BAM USB (Hub
ffa0-ffaf : Intel Corp. 82801BA IDE U100
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

/proc/iomem:

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000ca800-000cbfff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ff76fff : System RAM
  00100000-002e68e6 : Kernel code
  002e68e7-003aa5ff : Kernel data
1ff77000-1ff78fff : ACPI Non-volatile Storage
1ff79000-1fffffff : reserved
e8000000-efffffff : Intel Corp. 82850 850 (Tehama) C
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV11 [GeForce2 MXR]
fc000000-fdffffff : PCI Bus #01
  fc000000-fcffffff : nVidia Corporation NV11 [GeForce2 MXR]
fe1ffc00-fe1ffc7f : 3Com Corporation 3c905C-TX/TX-M [Torn
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

7.5) 
  
00:00.0 Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH) (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fe100000-fe2fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80 [Master])
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at dcd0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04) (prog-if 00 [UHCI])
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at ff60 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 04)
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at d800 [size=256]
	Region 1: I/O ports at dc40 [size=64]

01:00.0 VGA compatible controller: nVidia Corporation NV11GL [Quadro2 MXR/EX] (rev b2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 0070
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at 80000000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

02:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 010d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec80 [size=128]
	Region 1: Memory at fe1ffc00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at fe200000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-



7.6)
 /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: _NEC     Model: CD-RW NR-9100A   Rev: 108A
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj7.7) ,,,,
7.8)  
     unknown


truely
dheeraj
-- 
It is better to be silent and be thought a fool than to speak and remove all doubt
