Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUAYDYe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 22:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUAYDYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 22:24:34 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:50697 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263661AbUAYDY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 22:24:27 -0500
X-Envelope-From: foton2@post.cz
From: David =?iso-8859-2?q?Posp=ED=B9il?= <foton2@post.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 Unable to handle kernel paging request
Date: Sun, 25 Jan 2004 04:24:09 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401250424.21533.foton2@post.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I was only listening the radio via internet, when computer totaly crashed. I 
had to restart (my uptime was 9 days :-(  )
Xfree, KDE, KMail, Mozilla, mplayer (radio),XMMS,mc and karamba were running.
This is my syslog : 
Jan 25 03:51:02 foton2 kernel: Unable to handle kernel paging request at 
virtual address 00200204
Jan 25 03:51:02 foton2 kernel:  printing eip:
Jan 25 03:51:02 foton2 kernel: c013bb35
Jan 25 03:51:02 foton2 kernel: *pde = 00000000
Jan 25 03:51:02 foton2 kernel: Oops: 0000 [#1]
Jan 25 03:51:02 foton2 kernel: CPU:    0
Jan 25 03:51:02 foton2 kernel: EIP:    0060:[<c013bb35>]    Tainted: P
Jan 25 03:51:02 foton2 kernel: EFLAGS: 00010006
Jan 25 03:51:02 foton2 kernel: EIP is at free_block+0x43/0xcb
Jan 25 03:51:02 foton2 kernel: eax: 00672c30   ebx: 00200200   ecx: e944e20c   
edx: c1000000
Jan 25 03:51:02 foton2 kernel: esi: eff3f840   edi: 00000002   ebp: eff3f84c   
esp: e21e5e98
Jan 25 03:51:02 foton2 kernel: ds: 007b   es: 007b   ss: 0068
Jan 25 03:51:02 foton2 kernel: Process karamba (pid: 844, threadinfo=e21e4000 
task=e29d2cc0)
Jan 25 03:51:02 foton2 kernel: Stack: 00000200 e21e5fc4 eff3f85c eff3d350 
d6128000 00000286 eff3e3e0 c013bcb2
Jan 25 03:51:02 foton2 kernel:        eff3f840 eff3d350 00000004 00000001 
00000001 e21e5ee0 00000004 eff3d340
Jan 25 03:51:02 foton2 kernel:        d6128000 00000286 00000000 c013be10 
eff3f840 eff3d340 c7362080 c7362080
Jan 25 03:51:02 foton2 kernel: Call Trace:
Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb
Jan 25 03:51:02 foton2 kernel:
Jan 25 03:51:02 foton2 kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 c7 43 04 00 
02 20 00 2b 4b 0c
Jan 25 03:51:02 foton2 kernel:  <6>note: karamba[844] exited with 
preempt_count 1
Jan 25 03:51:02 foton2 kernel: bad: scheduling while atomic!
Jan 25 03:51:02 foton2 kernel: Call Trace:
Jan 25 03:51:02 foton2 kernel:  [<c01193bc>] schedule+0x591/0x596
Jan 25 03:51:02 foton2 kernel:  [<c01409ed>] unmap_page_range+0x43/0x69
Jan 25 03:51:02 foton2 kernel:  [<c0140bd3>] unmap_vmas+0x1c0/0x218
Jan 25 03:51:02 foton2 kernel:  [<c0144977>] exit_mmap+0x7c/0x191
Jan 25 03:51:02 foton2 kernel:  [<c011acd4>] mmput+0x67/0xb6
Jan 25 03:51:02 foton2 kernel:  [<c011eba0>] do_exit+0x163/0x3f9
Jan 25 03:51:02 foton2 kernel:  [<c010a070>] do_divide_error+0x0/0xfb
Jan 25 03:51:02 foton2 kernel:  [<c011769e>] do_page_fault+0x1f8/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c01246cd>] update_process_times+0x46/0x52
Jan 25 03:51:02 foton2 kernel:  [<c027bd3c>] kfree_skbmem+0x24/0x2c
Jan 25 03:51:02 foton2 kernel:  [<c027bdb1>] __kfree_skb+0x6d/0xde
Jan 25 03:51:02 foton2 kernel:  [<c0138818>] buffered_rmqueue+0xc1/0x15a
Jan 25 03:51:02 foton2 kernel:  [<c01174a6>] do_page_fault+0x0/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c0109a19>] error_code+0x2d/0x38
Jan 25 03:51:02 foton2 kernel:  [<c013bb35>] free_block+0x43/0xcb
Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb
Jan 25 03:51:02 foton2 kernel:
Jan 25 03:51:02 foton2 kernel: Unable to handle kernel paging request at 
virtual address 00200204
Jan 25 03:51:02 foton2 kernel:  printing eip:
Jan 25 03:51:02 foton2 kernel: c013bb35
Jan 25 03:51:02 foton2 kernel: *pde = 00000000
Jan 25 03:51:02 foton2 kernel: Oops: 0000 [#2]
Jan 25 03:51:02 foton2 kernel: CPU:    0
Jan 25 03:51:02 foton2 kernel: EIP:    0060:[<c013bb35>]    Tainted: P
Jan 25 03:51:02 foton2 kernel: EFLAGS: 00010006
Jan 25 03:51:02 foton2 kernel: EIP is at free_block+0x43/0xcb
Jan 25 03:51:02 foton2 kernel: eax: 00672c30   ebx: 00200200   ecx: e944e20c   
edx: c1000000
Jan 25 03:51:02 foton2 kernel: esi: eff3f840   edi: 00000002   ebp: eff3f84c   
esp: e5ca9e98
Jan 25 03:51:02 foton2 kernel: ds: 007b   es: 007b   ss: 0068
Jan 25 03:51:02 foton2 kernel: Process kdeinit (pid: 790, threadinfo=e5ca8000 
task=e814b2e0)
Jan 25 03:51:02 foton2 kernel: Stack: 00000001 c01766a2 eff3f85c eff3d350 
e21e4000 00000286 eff3e3e0 c013bcb2
Jan 25 03:51:02 foton2 kernel:        eff3f840 eff3d350 00000004 e5fe7c90 
c01766a2 eff37a84 00000004 eff3d340
Jan 25 03:51:02 foton2 kernel:        e21e4000 00000286 c97c9280 c013be10 
eff3f840 eff3d340 e29d2cc0 e29d2cc0
Jan 25 03:51:02 foton2 kernel: Call Trace:
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb
Jan 25 03:51:02 foton2 kernel:
Jan 25 03:51:02 foton2 kernel: Code: 8b 53 04 8b 03 89 50 04 89 02 c7 43 04 00 
02 20 00 2b 4b 0c
Jan 25 03:51:02 foton2 kernel:  <6>note: kdeinit[790] exited with 
preempt_count 1
Jan 25 03:51:02 foton2 kernel: bad: scheduling while atomic!
Jan 25 03:51:02 foton2 kernel: Call Trace:
Jan 25 03:51:02 foton2 kernel:  [<c01193bc>] schedule+0x591/0x596
Jan 25 03:51:02 foton2 kernel:  [<c01409ed>] unmap_page_range+0x43/0x69
Jan 25 03:51:02 foton2 kernel:  [<c0140bd3>] unmap_vmas+0x1c0/0x218
Jan 25 03:51:02 foton2 kernel:  [<c0144977>] exit_mmap+0x7c/0x191
Jan 25 03:51:02 foton2 kernel:  [<c011acd4>] mmput+0x67/0xb6
Jan 25 03:51:02 foton2 kernel:  [<c011eba0>] do_exit+0x163/0x3f9
Jan 25 03:51:02 foton2 kernel:  [<c010a070>] do_divide_error+0x0/0xfb
Jan 25 03:51:02 foton2 kernel:  [<c011769e>] do_page_fault+0x1f8/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c027bb7d>] alloc_skb+0x47/0xe0
Jan 25 03:51:02 foton2 kernel:  [<c027b2c0>] sock_alloc_send_pskb+0xc3/0x1db
Jan 25 03:51:02 foton2 kernel:  [<c027d5c6>] memcpy_fromiovec+0x61/0xa8
Jan 25 03:51:02 foton2 kernel:  [<c027b407>] sock_alloc_send_skb+0x2f/0x33
Jan 25 03:51:02 foton2 kernel:  [<c0118434>] recalc_task_prio+0x92/0x19d
Jan 25 03:51:02 foton2 kernel:  [<c01174a6>] do_page_fault+0x0/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c0109a19>] error_code+0x2d/0x38
Jan 25 03:51:02 foton2 kernel:  [<c013bb35>] free_block+0x43/0xcb
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb
Jan 25 03:51:02 foton2 kernel:
Jan 25 03:51:02 foton2 kernel: bad: scheduling while atomic!
Jan 25 03:51:02 foton2 kernel: Call Trace:
Jan 25 03:51:02 foton2 kernel:  [<c01193bc>] schedule+0x591/0x596
Jan 25 03:51:02 foton2 kernel:  [<c01409ed>] unmap_page_range+0x43/0x69
Jan 25 03:51:02 foton2 kernel:  [<c0140bd3>] unmap_vmas+0x1c0/0x218
Jan 25 03:51:02 foton2 kernel:  [<c0144977>] exit_mmap+0x7c/0x191
Jan 25 03:51:02 foton2 kernel:  [<c011acd4>] mmput+0x67/0xb6
Jan 25 03:51:02 foton2 kernel:  [<c011eba0>] do_exit+0x163/0x3f9
Jan 25 03:51:02 foton2 kernel:  [<c010a070>] do_divide_error+0x0/0xfb
Jan 25 03:51:02 foton2 kernel:  [<c011769e>] do_page_fault+0x1f8/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c027bb7d>] alloc_skb+0x47/0xe0
Jan 25 03:51:02 foton2 kernel:  [<c027b2c0>] sock_alloc_send_pskb+0xc3/0x1db
Jan 25 03:51:02 foton2 kernel:  [<c027d5c6>] memcpy_fromiovec+0x61/0xa8
Jan 25 03:51:02 foton2 kernel:  [<c027b407>] sock_alloc_send_skb+0x2f/0x33
Jan 25 03:51:02 foton2 kernel:  [<c0118434>] recalc_task_prio+0x92/0x19d
Jan 25 03:51:02 foton2 kernel:  [<c01174a6>] do_page_fault+0x0/0x50a
Jan 25 03:51:02 foton2 kernel:  [<c0109a19>] error_code+0x2d/0x38
Jan 25 03:51:02 foton2 kernel:  [<c013bb35>] free_block+0x43/0xcb
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
Jan 25 03:51:02 foton2 kernel:  [<c01766a2>] proc_destroy_inode+0x1b/0x1f
Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAEzbf4RoNZR5PGMkRAg2qAKC6z9t9bSasfCXw9RBizTnY4Pt+igCgyuCA
AloUbQ1BPcYkEDQXVn2pRhY=
=qNSu
-----END PGP SIGNATURE-----

