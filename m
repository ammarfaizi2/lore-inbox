Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270660AbTGURXK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270662AbTGURXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:23:09 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:17327 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S270660AbTGURWt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:22:49 -0400
From: Nicolas <linux@1g6.biz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more oops 2.6.0-test1
Date: Mon, 21 Jul 2003 19:37:48 +0200
User-Agent: KMail/1.5
References: <200307181508.54365.linux@1g6.biz>
In-Reply-To: <200307181508.54365.linux@1g6.biz>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307211937.48772.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am replying to myself,

Maybe a clue, I switched off snmpd and mrtg,
and no more oops since 3 days.
It was "network stats", "cats in /proc/apci" and "free",
I will try to reactivate each one after another...

Regards.

Nicolas.

Le Vendredi 18 Juillet 2003 15:08, vous avez écrit :
> Since I bought this computer,I am trying to use 2.5.x branch( 3 april
> 2.5.66), I do not got any stable 2.5x kernel ...,
> and I cannot use 2.4 because my networks cards didn't works with it.
> (sis900 + epro100, none of them can send packets with 2.4)
>
> My best uptime is 3 days.
>
> I am very tired of this, don't know what to do ... :(
> Is it gcc ? 		gcc (GCC) 3.2.2
> Is it hardware ? 	memtest is ok, not overclocked, XP seems stable...(but
> not tested more than one day)
> Is it me ?  		(selftest passed)
>
> I sent many oops there, but they seems randoms ones...
> (except for the netstat one)
>
>
> I can resend my config or everything, it is pretty the same since 2.5.66.
> (added, nmi_watchdog=1 and CONFIG_DEBUG_SPINLOCK &
> CONFIG_DEBUG_SPINLOCK_SLEEP)
>
> snip
>
> Nicolas.
>
> One series
>
> Jul 18 02:30:00 hal9003 kernel: Bad page state at free_hot_cold_page
> Jul 18 02:30:00 hal9003 kernel: flags:0x01010010 mapping:00000000 mapped:1
> count:0
> Jul 18 02:30:00 hal9003 kernel: Backtrace:
> Jul 18 02:30:00 hal9003 kernel: Call Trace:
> Jul 18 02:30:00 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 02:30:00 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 02:30:00 hal9003 kernel:  [free_hot_cold_page+108/243]
> free_hot_cold_page+0x6c/0xf3
> Jul 18 02:30:00 hal9003 kernel:  [<c0147bdc>] free_hot_cold_page+0x6c/0xf3
> Jul 18 02:30:00 hal9003 kernel:  [zap_pte_range+336/409]
> zap_pte_range+0x150/0x199
> Jul 18 02:30:00 hal9003 kernel:  [<c0155661>] zap_pte_range+0x150/0x199
> Jul 18 02:30:00 hal9003 kernel:  [zap_pmd_range+75/103]
> zap_pmd_range+0x4b/0x67
> Jul 18 02:30:00 hal9003 kernel:  [<c01556f5>] zap_pmd_range+0x4b/0x67
> Jul 18 02:30:00 hal9003 kernel:  [unmap_page_range+65/103]
> unmap_page_range+0x41/0x67
> Jul 18 02:30:00 hal9003 kernel:  [<c0155752>] unmap_page_range+0x41/0x67
> Jul 18 02:30:00 hal9003 kernel:  [unmap_vmas+203/820] unmap_vmas+0xcb/0x334
> Jul 18 02:30:00 hal9003 kernel:  [<c0155843>] unmap_vmas+0xcb/0x334
> Jul 18 02:30:00 hal9003 kernel:  [exit_mmap+193/654] exit_mmap+0xc1/0x28e
> Jul 18 02:30:00 hal9003 kernel:  [<c015ad9c>] exit_mmap+0xc1/0x28e
> Jul 18 02:30:00 hal9003 kernel:  [mmput+165/299] mmput+0xa5/0x12b
> Jul 18 02:30:00 hal9003 kernel:  [<c011f594>] mmput+0xa5/0x12b
> Jul 18 02:30:00 hal9003 kernel:  [exec_mmap+526/932] exec_mmap+0x20e/0x3a4
> Jul 18 02:30:00 hal9003 kernel:  [<c01779f9>] exec_mmap+0x20e/0x3a4
> Jul 18 02:30:00 hal9003 kernel:  [flush_old_exec+492/4526]
> flush_old_exec+0x1ec/0x11ae
> Jul 18 02:30:00 hal9003 kernel:  [<c0177d7b>] flush_old_exec+0x1ec/0x11ae
> Jul 18 02:30:00 hal9003 kernel:  [kernel_read+74/87] kernel_read+0x4a/0x57
> Jul 18 02:30:00 hal9003 kernel:  [<c01777de>] kernel_read+0x4a/0x57
> Jul 18 02:30:00 hal9003 kernel:  [load_elf_binary+739/3195]
> load_elf_binary+0x2e3/0xc7b
> Jul 18 02:30:00 hal9003 kernel:  [<c019dc86>] load_elf_binary+0x2e3/0xc7b
> Jul 18 02:30:00 hal9003 kernel:  [generic_file_read+144/167]
> generic_file_read+0x90/0xa7
> Jul 18 02:30:00 hal9003 kernel:  [<c0144663>] generic_file_read+0x90/0xa7
> Jul 18 02:30:00 hal9003 kernel:  [__change_page_attr+38/455]
> __change_page_attr+0x26/0x1c7
> Jul 18 02:30:00 hal9003 kernel:  [<c011afc8>] __change_page_attr+0x26/0x1c7
> Jul 18 02:30:00 hal9003 kernel:  [buffered_rmqueue+174/545]
> buffered_rmqueue+0xae/0x221
> Jul 18 02:30:00 hal9003 kernel:  [<c0147d2a>] buffered_rmqueue+0xae/0x221
> Jul 18 02:30:00 hal9003 kernel:  [kmap+32/67] kmap+0x20/0x43
> Jul 18 02:30:00 hal9003 kernel:  [<c011b550>] kmap+0x20/0x43
> Jul 18 02:30:00 hal9003 kernel:  [search_binary_handler+245/423]
> search_binary_handler+0xf5/0x1a7
> Jul 18 02:30:00 hal9003 kernel:  [<c017922b>]
> search_binary_handler+0xf5/0x1a7 Jul 18 02:30:00 hal9003 kernel: 
> [do_execve+388/435] do_execve+0x184/0x1b3 Jul 18 02:30:00 hal9003 kernel: 
> [<c0179461>] do_execve+0x184/0x1b3 Jul 18 02:30:00 hal9003 kernel: 
> [sys_execve+75/122] sys_execve+0x4b/0x7a Jul 18 02:30:00 hal9003 kernel: 
> [<c0107abe>] sys_execve+0x4b/0x7a Jul 18 02:30:00 hal9003 kernel: 
> [syscall_call+7/11] syscall_call+0x7/0xb Jul 18 02:30:00 hal9003 kernel: 
> [<c0109ddb>] syscall_call+0x7/0xb Jul 18 02:30:00 hal9003 kernel:
> Jul 18 02:30:00 hal9003 kernel: Trying to fix it up, but a reboot is needed
> Jul 18 02:30:00 hal9003 kernel: Bad page state at prep_new_page
> Jul 18 02:30:00 hal9003 kernel: flags:0x01010000 mapping:00000000 mapped:1
> count:0
> Jul 18 02:30:00 hal9003 kernel: Backtrace:
> Jul 18 02:30:00 hal9003 kernel: Call Trace:
> Jul 18 02:30:00 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 02:30:00 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 02:30:00 hal9003 kernel:  [prep_new_page+51/74]
> prep_new_page+0x33/0x4a Jul 18 02:30:00 hal9003 kernel:  [<c01478ca>]
> prep_new_page+0x33/0x4a Jul 18 02:30:00 hal9003 kernel: 
> [buffered_rmqueue+174/545]
> buffered_rmqueue+0xae/0x221
> Jul 18 02:30:00 hal9003 kernel:  [<c0147d2a>] buffered_rmqueue+0xae/0x221
> Jul 18 02:30:00 hal9003 kernel:  [rcu_check_quiescent_state+355/441]
> rcu_check_quiescent_state+0x163/0x1b9
> Jul 18 02:30:00 hal9003 kernel:  [<c0136f6f>]
> rcu_check_quiescent_state+0x163/0x1b9
> Jul 18 02:30:00 hal9003 kernel:  [__alloc_pages+138/857]
> __alloc_pages+0x8a/0x359
> Jul 18 02:30:00 hal9003 kernel:  [<c0147f27>] __alloc_pages+0x8a/0x359
> Jul 18 02:30:00 hal9003 kernel:  [__get_free_pages+39/64]
> __get_free_pages+0x27/0x40
> Jul 18 02:30:00 hal9003 kernel:  [<c014821d>] __get_free_pages+0x27/0x40
> Jul 18 02:30:00 hal9003 kernel:  [cache_grow+327/1145]
> cache_grow+0x147/0x479 Jul 18 02:30:00 hal9003 kernel:  [<c014c38e>]
> cache_grow+0x147/0x479 Jul 18 02:30:00 hal9003 kernel: 
> [__change_page_attr+38/455]
> __change_page_attr+0x26/0x1c7
> Jul 18 02:30:00 hal9003 kernel:  [<c011afc8>] __change_page_attr+0x26/0x1c7
> Jul 18 02:30:00 hal9003 kernel:  [cache_alloc_refill+386/1101]
> cache_alloc_refill+0x182/0x44d
> Jul 18 02:30:00 hal9003 kernel:  [<c014c842>]
> cache_alloc_refill+0x182/0x44d Jul 18 02:30:00 hal9003 kernel: 
> [__kmalloc+463/508] __kmalloc+0x1cf/0x1fc Jul 18 02:30:00 hal9003 kernel: 
> [<c014d2e2>] __kmalloc+0x1cf/0x1fc Jul 18 02:30:00 hal9003 kernel: 
> [alloc_skb+35/225] alloc_skb+0x23/0xe1 Jul 18 02:30:00 hal9003 kernel: 
> [<c02855cd>] alloc_skb+0x23/0xe1
> Jul 18 02:30:00 hal9003 kernel:  [alloc_skb+72/225] alloc_skb+0x48/0xe1
> Jul 18 02:30:00 hal9003 kernel:  [<c02855f2>] alloc_skb+0x48/0xe1
> Jul 18 02:30:00 hal9003 kernel:  [sock_alloc_send_pskb+207/504]
> sock_alloc_send_pskb+0xcf/0x1f8
> Jul 18 02:30:00 hal9003 kernel:  [<c0284bb0>]
> sock_alloc_send_pskb+0xcf/0x1f8 Jul 18 02:30:00 hal9003 kernel: 
> [sock_alloc_send_skb+46/50]
> sock_alloc_send_skb+0x2e/0x32
> Jul 18 02:30:00 hal9003 kernel:  [<c0284d07>] sock_alloc_send_skb+0x2e/0x32
> Jul 18 02:30:00 hal9003 kernel:  [unix_dgram_sendmsg+349/1472]
> unix_dgram_sendmsg+0x15d/0x5c0
> Jul 18 02:30:00 hal9003 kernel:  [<c02ed0f4>]
> unix_dgram_sendmsg+0x15d/0x5c0 Jul 18 02:30:00 hal9003 kernel: 
> [update_wall_time+15/58]
> update_wall_time+0xf/0x3a
> Jul 18 02:30:00 hal9003 kernel:  [<c012bb35>] update_wall_time+0xf/0x3a
> Jul 18 02:30:00 hal9003 kernel:  [sock_aio_write+189/217]
> sock_aio_write+0xbd/0xd9
> Jul 18 02:30:00 hal9003 kernel:  [<c02819ef>] sock_aio_write+0xbd/0xd9
> Jul 18 02:30:00 hal9003 kernel:  [do_sync_write+137/180]
> do_sync_write+0x89/0xb4
> Jul 18 02:30:00 hal9003 kernel:  [<c0169254>] do_sync_write+0x89/0xb4
> Jul 18 02:30:00 hal9003 kernel:  [do_syslog+1064/2170]
> do_syslog+0x428/0x87a Jul 18 02:30:00 hal9003 kernel:  [<c0122274>]
> do_syslog+0x428/0x87a Jul 18 02:30:00 hal9003 kernel: 
> [default_wake_function+0/46]
> default_wake_function+0x0/0x2e
> Jul 18 02:30:00 hal9003 kernel:  [<c011c672>]
> default_wake_function+0x0/0x2e Jul 18 02:30:00 hal9003 kernel: 
> [__kfree_skb+129/246] __kfree_skb+0x81/0xf6 Jul 18 02:30:00 hal9003 kernel:
>  [<c0285843>] __kfree_skb+0x81/0xf6 Jul 18 02:30:00 hal9003 kernel: 
> [vfs_write+233/281] vfs_write+0xe9/0x119 Jul 18 02:30:00 hal9003 kernel: 
> [<c0169368>] vfs_write+0xe9/0x119 Jul 18 02:30:00 hal9003 kernel: 
> [sys_write+63/93] sys_write+0x3f/0x5d Jul 18 02:30:00 hal9003 kernel: 
> [<c0169434>] sys_write+0x3f/0x5d
> Jul 18 02:30:00 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jul 18 02:30:00 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
> Jul 18 02:30:00 hal9003 kernel:
> Jul 18 02:30:00 hal9003 kernel: Trying to fix it up, but a reboot is needed
> Jul 18 02:30:10 hal9003 kernel: Bad page state at free_hot_cold_page
> Jul 18 02:30:10 hal9003 kernel: flags:0x01010000 mapping:00000000 mapped:1
> count:0
> Jul 18 02:30:10 hal9003 kernel: Backtrace:
> Jul 18 02:30:10 hal9003 kernel: Call Trace:
> Jul 18 02:30:10 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 02:30:10 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 02:30:10 hal9003 kernel:  [free_hot_cold_page+108/243]
> free_hot_cold_page+0x6c/0xf3
> Jul 18 02:30:10 hal9003 kernel:  [<c0147bdc>] free_hot_cold_page+0x6c/0xf3
> Jul 18 02:30:10 hal9003 kernel:  [slab_destroy+340/476]
> slab_destroy+0x154/0x1dc
> Jul 18 02:30:10 hal9003 kernel:  [<c014b2bb>] slab_destroy+0x154/0x1dc
> Jul 18 02:30:10 hal9003 kernel:  [reap_timer_fnc+685/1058]
> reap_timer_fnc+0x2ad/0x422
> Jul 18 02:30:10 hal9003 kernel:  [<c014e509>] reap_timer_fnc+0x2ad/0x422
> Jul 18 02:30:10 hal9003 kernel:  [update_process_times+70/80]
> update_process_times+0x46/0x50
> Jul 18 02:30:10 hal9003 kernel:  [<c012bcb7>]
> update_process_times+0x46/0x50 Jul 18 02:30:10 hal9003 kernel: 
> [reap_timer_fnc+0/1058]
> reap_timer_fnc+0x0/0x422
> Jul 18 02:30:10 hal9003 kernel:  [<c014e25c>] reap_timer_fnc+0x0/0x422
> Jul 18 02:30:10 hal9003 kernel:  [run_timer_softirq+349/976]
> run_timer_softirq+0x15d/0x3d0
> Jul 18 02:30:10 hal9003 kernel:  [<c012be38>] run_timer_softirq+0x15d/0x3d0
> Jul 18 02:30:10 hal9003 kernel:  [timer_interrupt+338/877]
> timer_interrupt+0x152/0x36d
> Jul 18 02:30:10 hal9003 kernel:  [<c0111ce0>] timer_interrupt+0x152/0x36d
> Jul 18 02:30:10 hal9003 kernel:  [__crc_remap_page_range+3246481/3990783]
> e100intr+0x24a/0x2ef [e100]
> Jul 18 02:30:10 hal9003 kernel:  [<f8fb0465>] e100intr+0x24a/0x2ef [e100]
> Jul 18 02:30:10 hal9003 kernel:  [do_softirq+161/163] do_softirq+0xa1/0xa3
> Jul 18 02:30:10 hal9003 kernel:  [<c01271cd>] do_softirq+0xa1/0xa3
> Jul 18 02:30:10 hal9003 kernel:  [do_IRQ+526/840] do_IRQ+0x20e/0x348
> Jul 18 02:30:10 hal9003 kernel:  [<c010c71c>] do_IRQ+0x20e/0x348
> Jul 18 02:30:10 hal9003 kernel:  [do_nmi+82/84] do_nmi+0x52/0x54
> Jul 18 02:30:10 hal9003 kernel:  [<c010b882>] do_nmi+0x52/0x54
> Jul 18 02:30:10 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [<c0107009>] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [<c0107009>] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [common_interrupt+24/32]
> common_interrupt+0x18/0x20
> Jul 18 02:30:10 hal9003 kernel:  [<c010a748>] common_interrupt+0x18/0x20
> Jul 18 02:30:10 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [<c0107009>] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [default_idle+0/44] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [<c0107009>] default_idle+0x0/0x2c
> Jul 18 02:30:10 hal9003 kernel:  [default_idle+39/44]
> default_idle+0x27/0x2c Jul 18 02:30:10 hal9003 kernel:  [<c0107030>]
> default_idle+0x27/0x2c Jul 18 02:30:10 hal9003 kernel:  [cpu_idle+49/58]
> cpu_idle+0x31/0x3a Jul 18 02:30:10 hal9003 kernel:  [<c01070a1>]
> cpu_idle+0x31/0x3a
> Jul 18 02:30:10 hal9003 kernel:  [_stext+0/42] rest_init+0x0/0x2a
> Jul 18 02:30:10 hal9003 kernel:  [<c0105000>] rest_init+0x0/0x2a
> Jul 18 02:30:10 hal9003 kernel:  [start_kernel+312/314]
> start_kernel+0x138/0x13a
> Jul 18 02:30:10 hal9003 kernel:  [<c038a6a5>] start_kernel+0x138/0x13a
> Jul 18 02:30:10 hal9003 kernel:  [unknown_bootoption+0/250]
> unknown_bootoption+0x0/0xfa
> Jul 18 02:30:10 hal9003 kernel:  [<c038a43f>] unknown_bootoption+0x0/0xfa
> Jul 18 02:30:10 hal9003 kernel:
> Jul 18 02:30:10 hal9003 kernel: Trying to fix it up, but a reboot is needed
> Jul 18 02:30:10 hal9003 kernel: Bad page state at prep_new_page
> Jul 18 02:30:10 hal9003 kernel: flags:0x01010000 mapping:00000000 mapped:1
> count:0
> Jul 18 02:30:10 hal9003 kernel: Backtrace:
> Jul 18 02:30:10 hal9003 kernel: Call Trace:
> Jul 18 02:30:10 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 02:30:10 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 02:30:10 hal9003 kernel:  [prep_new_page+51/74]
> prep_new_page+0x33/0x4a Jul 18 02:30:10 hal9003 kernel:  [<c01478ca>]
> prep_new_page+0x33/0x4a Jul 18 02:30:10 hal9003 kernel: 
> [buffered_rmqueue+174/545]
> buffered_rmqueue+0xae/0x221
> Jul 18 02:30:10 hal9003 kernel:  [<c0147d2a>] buffered_rmqueue+0xae/0x221
> Jul 18 02:30:10 hal9003 kernel:  [__alloc_pages+138/857]
> __alloc_pages+0x8a/0x359
> Jul 18 02:30:10 hal9003 kernel:  [<c0147f27>] __alloc_pages+0x8a/0x359
> Jul 18 02:30:10 hal9003 kernel:  [__get_free_pages+39/64]
> __get_free_pages+0x27/0x40
> Jul 18 02:30:10 hal9003 kernel:  [<c014821d>] __get_free_pages+0x27/0x40
> Jul 18 02:30:10 hal9003 kernel:  [cache_grow+327/1145]
> cache_grow+0x147/0x479 Jul 18 02:30:10 hal9003 kernel:  [<c014c38e>]
> cache_grow+0x147/0x479 Jul 18 02:30:10 hal9003 kernel: 
> [__change_page_attr+38/455]
> __change_page_attr+0x26/0x1c7
> Jul 18 02:30:10 hal9003 kernel:  [<c011afc8>] __change_page_attr+0x26/0x1c7
> Jul 18 02:30:10 hal9003 kernel:  [cache_alloc_refill+386/1101]
> cache_alloc_refill+0x182/0x44d
> Jul 18 02:30:10 hal9003 kernel:  [<c014c842>]
> cache_alloc_refill+0x182/0x44d Jul 18 02:30:10 hal9003 kernel: 
> [__kmalloc+463/508] __kmalloc+0x1cf/0x1fc Jul 18 02:30:10 hal9003 kernel: 
> [<c014d2e2>] __kmalloc+0x1cf/0x1fc Jul 18 02:30:10 hal9003 kernel: 
> [alloc_skb+35/225] alloc_skb+0x23/0xe1 Jul 18 02:30:10 hal9003 kernel: 
> [<c02855cd>] alloc_skb+0x23/0xe1
> Jul 18 02:30:10 hal9003 kernel:  [alloc_skb+72/225] alloc_skb+0x48/0xe1
> Jul 18 02:30:10 hal9003 kernel:  [<c02855f2>] alloc_skb+0x48/0xe1
> Jul 18 02:30:10 hal9003 kernel:  [sock_alloc_send_pskb+207/504]
> sock_alloc_send_pskb+0xcf/0x1f8
> Jul 18 02:30:10 hal9003 kernel:  [<c0284bb0>]
> sock_alloc_send_pskb+0xcf/0x1f8 Jul 18 02:30:10 hal9003 kernel: 
> [sock_alloc_send_skb+46/50]
> sock_alloc_send_skb+0x2e/0x32
> Jul 18 02:30:10 hal9003 kernel:  [<c0284d07>] sock_alloc_send_skb+0x2e/0x32
> Jul 18 02:30:10 hal9003 kernel:  [unix_dgram_sendmsg+349/1472]
> unix_dgram_sendmsg+0x15d/0x5c0
> Jul 18 02:30:10 hal9003 kernel:  [<c02ed0f4>]
> unix_dgram_sendmsg+0x15d/0x5c0 Jul 18 02:30:10 hal9003 kernel: 
> [update_wall_time+15/58]
> update_wall_time+0xf/0x3a
> Jul 18 02:30:10 hal9003 kernel:  [<c012bb35>] update_wall_time+0xf/0x3a
> Jul 18 02:30:10 hal9003 kernel:  [sock_aio_write+189/217]
> sock_aio_write+0xbd/0xd9
> Jul 18 02:30:10 hal9003 kernel:  [<c02819ef>] sock_aio_write+0xbd/0xd9
> Jul 18 02:30:10 hal9003 kernel:  [do_sync_write+137/180]
> do_sync_write+0x89/0xb4
> Jul 18 02:30:10 hal9003 kernel:  [<c0169254>] do_sync_write+0x89/0xb4
> Jul 18 02:30:10 hal9003 kernel:  [vfs_write+233/281] vfs_write+0xe9/0x119
> Jul 18 02:30:10 hal9003 kernel:  [<c0169368>] vfs_write+0xe9/0x119
> Jul 18 02:30:10 hal9003 kernel:  [sys_write+63/93] sys_write+0x3f/0x5d
> Jul 18 02:30:10 hal9003 kernel:  [<c0169434>] sys_write+0x3f/0x5d
> Jul 18 02:30:10 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jul 18 02:30:10 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
> Jul 18 02:30:10 hal9003 kernel:
> Jul 18 02:30:10 hal9003 kernel: Trying to fix it up, but a reboot is needed
>
> reboot at 8,
>
> and
>
> Jul 18 14:08:58 hal9003 kernel: Bad page state at free_hot_cold_page
> Jul 18 14:08:58 hal9003 kernel: flags:0x01010010 mapping:00000000 mapped:1
> count:0
> Jul 18 14:08:58 hal9003 kernel: Backtrace:
> Jul 18 14:08:58 hal9003 kernel: Call Trace:
> Jul 18 14:08:58 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 14:08:58 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 14:08:58 hal9003 kernel:  [free_hot_cold_page+108/243]
> free_hot_cold_page+0x6c/0xf3
> Jul 18 14:08:58 hal9003 kernel:  [<c0147bdc>] free_hot_cold_page+0x6c/0xf3
> Jul 18 14:08:58 hal9003 kernel:  [zap_pte_range+336/409]
> zap_pte_range+0x150/0x199
> Jul 18 14:08:58 hal9003 kernel:  [<c0155661>] zap_pte_range+0x150/0x199
> Jul 18 14:08:58 hal9003 kernel:  [invalidate_vcache+39/448]
> invalidate_vcache+0x27/0x1c0
> Jul 18 14:08:58 hal9003 kernel:  [<c0150ab3>] invalidate_vcache+0x27/0x1c0
> Jul 18 14:08:58 hal9003 kernel:  [zap_pmd_range+75/103]
> zap_pmd_range+0x4b/0x67
> Jul 18 14:08:58 hal9003 kernel:  [<c01556f5>] zap_pmd_range+0x4b/0x67
> Jul 18 14:08:58 hal9003 kernel:  [unmap_page_range+65/103]
> unmap_page_range+0x41/0x67
> Jul 18 14:08:58 hal9003 kernel:  [<c0155752>] unmap_page_range+0x41/0x67
> Jul 18 14:08:58 hal9003 kernel:  [unmap_vmas+203/820] unmap_vmas+0xcb/0x334
> Jul 18 14:08:58 hal9003 kernel:  [<c0155843>] unmap_vmas+0xcb/0x334
> Jul 18 14:08:58 hal9003 kernel:  [exit_mmap+193/654] exit_mmap+0xc1/0x28e
> Jul 18 14:08:58 hal9003 kernel:  [<c015ad9c>] exit_mmap+0xc1/0x28e
> Jul 18 14:08:58 hal9003 kernel:  [mmput+165/299] mmput+0xa5/0x12b
> Jul 18 14:08:58 hal9003 kernel:  [<c011f594>] mmput+0xa5/0x12b
> Jul 18 14:08:58 hal9003 kernel:  [do_exit+613/2457] do_exit+0x265/0x999
> Jul 18 14:08:58 hal9003 kernel:  [<c012514f>] do_exit+0x265/0x999
> Jul 18 14:08:58 hal9003 kernel:  [filp_close+75/116] filp_close+0x4b/0x74
> Jul 18 14:08:58 hal9003 kernel:  [<c01688b8>] filp_close+0x4b/0x74
> Jul 18 14:08:58 hal9003 kernel:  [do_group_exit+434/479]
> do_group_exit+0x1b2/0x1df
> Jul 18 14:08:58 hal9003 kernel:  [<c0125a89>] do_group_exit+0x1b2/0x1df
> Jul 18 14:08:58 hal9003 kernel:  [do_nmi+82/84] do_nmi+0x52/0x54
> Jul 18 14:08:58 hal9003 kernel:  [<c010b882>] do_nmi+0x52/0x54
> Jul 18 14:08:58 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jul 18 14:08:58 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
> Jul 18 14:08:58 hal9003 kernel:
> Jul 18 14:08:58 hal9003 kernel: Trying to fix it up, but a reboot is needed
> Jul 18 14:10:00 hal9003 kernel: Bad page state at prep_new_page
> Jul 18 14:10:00 hal9003 kernel: flags:0x01010000 mapping:00000000 mapped:1
> count:0
> Jul 18 14:10:00 hal9003 kernel: Backtrace:
> Jul 18 14:10:00 hal9003 kernel: Call Trace:
> Jul 18 14:10:00 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 14:10:00 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 14:10:00 hal9003 kernel:  [prep_new_page+51/74]
> prep_new_page+0x33/0x4a Jul 18 14:10:00 hal9003 kernel:  [<c01478ca>]
> prep_new_page+0x33/0x4a Jul 18 14:10:00 hal9003 kernel: 
> [buffered_rmqueue+174/545]
> buffered_rmqueue+0xae/0x221
> Jul 18 14:10:00 hal9003 kernel:  [<c0147d2a>] buffered_rmqueue+0xae/0x221
> Jul 18 14:10:00 hal9003 kernel:  [update_atime+127/208]
> update_atime+0x7f/0xd0 Jul 18 14:10:00 hal9003 kernel:  [<c018c419>]
> update_atime+0x7f/0xd0 Jul 18 14:10:00 hal9003 kernel: 
> [__alloc_pages+138/857]
> __alloc_pages+0x8a/0x359
> Jul 18 14:10:00 hal9003 kernel:  [<c0147f27>] __alloc_pages+0x8a/0x359
> Jul 18 14:10:00 hal9003 kernel:  [file_read_actor+0/242]
> file_read_actor+0x0/0xf2
> Jul 18 14:10:00 hal9003 kernel:  [<c0144295>] file_read_actor+0x0/0xf2
> Jul 18 14:10:00 hal9003 kernel:  [do_anonymous_page+191/1254]
> do_anonymous_page+0xbf/0x4e6
> Jul 18 14:10:00 hal9003 kernel:  [<c01574fa>] do_anonymous_page+0xbf/0x4e6
> Jul 18 14:10:00 hal9003 kernel:  [pte_alloc_map+289/441]
> pte_alloc_map+0x121/0x1b9
> Jul 18 14:10:00 hal9003 kernel:  [<c0154acf>] pte_alloc_map+0x121/0x1b9
> Jul 18 14:10:00 hal9003 kernel:  [handle_mm_fault+302/724]
> handle_mm_fault+0x12e/0x2d4
> Jul 18 14:10:00 hal9003 kernel:  [<c0158060>] handle_mm_fault+0x12e/0x2d4
> Jul 18 14:10:00 hal9003 kernel:  [do_page_fault+349/1189]
> do_page_fault+0x15d/0x4a5
> Jul 18 14:10:00 hal9003 kernel:  [<c011a2a1>] do_page_fault+0x15d/0x4a5
> Jul 18 14:10:00 hal9003 kernel:  [do_brk+315/527] do_brk+0x13b/0x20f
> Jul 18 14:10:00 hal9003 kernel:  [<c015abc2>] do_brk+0x13b/0x20f
> Jul 18 14:10:00 hal9003 kernel:  [sys_brk+240/276] sys_brk+0xf0/0x114
> Jul 18 14:10:00 hal9003 kernel:  [<c0158f83>] sys_brk+0xf0/0x114
> Jul 18 14:10:00 hal9003 kernel:  [do_nmi+82/84] do_nmi+0x52/0x54
> Jul 18 14:10:00 hal9003 kernel:  [<c010b882>] do_nmi+0x52/0x54
> Jul 18 14:10:00 hal9003 kernel:  [do_page_fault+0/1189]
> do_page_fault+0x0/0x4a5
> Jul 18 14:10:00 hal9003 kernel:  [<c011a144>] do_page_fault+0x0/0x4a5
> Jul 18 14:10:00 hal9003 kernel:  [error_code+45/56] error_code+0x2d/0x38
> Jul 18 14:10:00 hal9003 kernel:  [<c010a805>] error_code+0x2d/0x38
> Jul 18 14:10:00 hal9003 kernel:
> Jul 18 14:10:00 hal9003 kernel: Trying to fix it up, but a reboot is needed
> Jul 18 14:10:00 hal9003 ucd-snmp[1183]: Connection from 127.0.0.1
> Jul 18 14:10:01 hal9003 last message repeated 11 times
> Jul 18 14:10:02 hal9003 kernel: Bad page state at free_hot_cold_page
> Jul 18 14:10:02 hal9003 kernel: flags:0x01000014 mapping:00000000 mapped:1
> count:0
> Jul 18 14:10:02 hal9003 kernel: Backtrace:
> Jul 18 14:10:02 hal9003 kernel: Call Trace:
> Jul 18 14:10:02 hal9003 kernel:  [bad_page+93/132] bad_page+0x5d/0x84
> Jul 18 14:10:02 hal9003 kernel:  [<c01474c7>] bad_page+0x5d/0x84
> Jul 18 14:10:02 hal9003 kernel:  [free_hot_cold_page+108/243]
> free_hot_cold_page+0x6c/0xf3
> Jul 18 14:10:02 hal9003 kernel:  [<c0147bdc>] free_hot_cold_page+0x6c/0xf3
> Jul 18 14:10:02 hal9003 kernel:  [zap_pte_range+336/409]
> zap_pte_range+0x150/0x199
> Jul 18 14:10:02 hal9003 kernel:  [<c0155661>] zap_pte_range+0x150/0x199
> Jul 18 14:10:02 hal9003 kernel:  [zap_pmd_range+75/103]
> zap_pmd_range+0x4b/0x67
> Jul 18 14:10:02 hal9003 kernel:  [<c01556f5>] zap_pmd_range+0x4b/0x67
> Jul 18 14:10:02 hal9003 kernel:  [unmap_page_range+65/103]
> unmap_page_range+0x41/0x67
> Jul 18 14:10:02 hal9003 kernel:  [<c0155752>] unmap_page_range+0x41/0x67
> Jul 18 14:10:02 hal9003 kernel:  [unmap_vmas+203/820] unmap_vmas+0xcb/0x334
> Jul 18 14:10:02 hal9003 kernel:  [<c0155843>] unmap_vmas+0xcb/0x334
> Jul 18 14:10:02 hal9003 kernel:  [exit_mmap+193/654] exit_mmap+0xc1/0x28e
> Jul 18 14:10:02 hal9003 kernel:  [<c015ad9c>] exit_mmap+0xc1/0x28e
> Jul 18 14:10:02 hal9003 kernel:  [mmput+165/299] mmput+0xa5/0x12b
> Jul 18 14:10:02 hal9003 kernel:  [<c011f594>] mmput+0xa5/0x12b
> Jul 18 14:10:02 hal9003 kernel:  [do_exit+613/2457] do_exit+0x265/0x999
> Jul 18 14:10:02 hal9003 kernel:  [<c012514f>] do_exit+0x265/0x999
> Jul 18 14:10:02 hal9003 kernel:  [do_group_exit+434/479]
> do_group_exit+0x1b2/0x1df
> Jul 18 14:10:02 hal9003 kernel:  [<c0125a89>] do_group_exit+0x1b2/0x1df
> Jul 18 14:10:02 hal9003 kernel:  [do_nmi+82/84] do_nmi+0x52/0x54
> Jul 18 14:10:02 hal9003 kernel:  [<c010b882>] do_nmi+0x52/0x54
> Jul 18 14:10:02 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jul 18 14:10:02 hal9003 kernel:  [<c0109ddb>] syscall_call+0x7/0xb
> Jul 18 14:10:02 hal9003 kernel:
> Jul 18 14:10:02 hal9003 kernel: Trying to fix it up, but a reboot is needed

