Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSKLVsg>; Tue, 12 Nov 2002 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbSKLVsg>; Tue, 12 Nov 2002 16:48:36 -0500
Received: from attila.bofh.it ([213.92.8.2]:45264 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S266983AbSKLVsB>;
	Tue, 12 Nov 2002 16:48:01 -0500
Date: Tue, 12 Nov 2002 22:54:40 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 oops in __d_lookup
Message-ID: <20021112215440.GA489@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened every time I tried running multi-gnome-terminal, then the
kernel crashed while rebooting. This was decoded on the next boot.

ksymoops 2.4.6 on i686 2.5.47.  Options used
     -V (default)
     -k /var/log/ksymoops/20021112220914.ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47/ (default)
     -m /boot/System.map-2.5.47 (default)

Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol __xfrm_policy_check_R__ver___xfrm_policy_check not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __xfrm_policy_destroy_R__ver___xfrm_policy_destroy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __xfrm_route_forward_R__ver___xfrm_route_forward not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __xfrm_state_destroy_R__ver___xfrm_state_destroy not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol crypto_alg_available_R__ver_crypto_alg_available not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol crypto_hmac_R__ver_crypto_hmac not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol crypto_hmac_final_R__ver_crypto_hmac_final not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol crypto_hmac_init_R__ver_crypto_hmac_init not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol crypto_hmac_update_R__ver_crypto_hmac_update not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol do_select_R__ver_do_select not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol find_trylock_page_R__ver_find_trylock_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol inet_peer_idlock_R__ver_inet_peer_idlock not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_bus_find_capability_R__ver_pci_bus_find_capability not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_bus_max_busnr_R__ver_pci_bus_max_busnr not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_find_bus_R__ver_pci_find_bus not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol pci_max_busnr_R__ver_pci_max_busnr not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol read_cache_pages_R__ver_read_cache_pages not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm4_rcv_R__ver_xfrm4_rcv not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_alloc_spi_R__ver_xfrm_alloc_spi not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_check_selectors_R__ver_xfrm_check_selectors not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_find_acq_R__ver_xfrm_find_acq not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_find_acq_byseq_R__ver_xfrm_find_acq_byseq not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_get_type_R__ver_xfrm_get_type not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_lookup_R__ver_xfrm_lookup not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_alloc_R__ver_xfrm_policy_alloc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_byid_R__ver_xfrm_policy_byid not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_delete_R__ver_xfrm_policy_delete not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_flush_R__ver_xfrm_policy_flush not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_insert_R__ver_xfrm_policy_insert not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_kill_R__ver_xfrm_policy_kill not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_list_R__ver_xfrm_policy_list not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_lookup_R__ver_xfrm_policy_lookup not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_policy_walk_R__ver_xfrm_policy_walk not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_register_km_R__ver_xfrm_register_km not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_register_type_R__ver_xfrm_register_type not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_replay_advance_R__ver_xfrm_replay_advance not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_replay_check_R__ver_xfrm_replay_check not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_alloc_R__ver_xfrm_state_alloc not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_check_expire_R__ver_xfrm_state_check_expire not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_check_space_R__ver_xfrm_state_check_space not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_delete_R__ver_xfrm_state_delete not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_find_R__ver_xfrm_state_find not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_flush_R__ver_xfrm_state_flush not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_insert_R__ver_xfrm_state_insert not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_lookup_R__ver_xfrm_state_lookup not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_state_walk_R__ver_xfrm_state_walk not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_unregister_km_R__ver_xfrm_unregister_km not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol xfrm_unregister_type_R__ver_xfrm_unregister_type not found in System.map.  Ignoring ksyms_base entry
Nov 12 22:43:03 wonderland kernel: Unable to handle kernel paging request at virtual address 11727000
Nov 12 22:43:03 wonderland kernel: c0151fc8
Nov 12 22:43:03 wonderland kernel: *pde = 00000000
Nov 12 22:43:03 wonderland kernel: Oops: 0000
Nov 12 22:43:03 wonderland kernel: CPU:    0
Nov 12 22:43:03 wonderland kernel: EIP:    0060:[<c0151fc8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 12 22:43:03 wonderland kernel: EFLAGS: 00010203
Nov 12 22:43:03 wonderland kernel: eax: dff79c50   ebx: 11726ff0   ecx: 00000010   edx: 01b9bab5
Nov 12 22:43:03 wonderland kernel: esi: d3fedf18   edi: d3fedf80   ebp: 11727000   esp: d3fede8c
Nov 12 22:43:03 wonderland kernel: ds: 0068   es: 0068   ss: 0068
Nov 12 22:43:03 wonderland kernel: Stack: d3fedf08 d3fedf18 d3fedf80 dffe6500 dff79c50 dc3f8005 01b9bab5 00000004 
Nov 12 22:43:03 wonderland kernel:        c0148c4b dfceff40 d3fedf18 d3fedf08 d3fedf18 d3fedf80 d3fedf24 dfceeec8 
Nov 12 22:43:03 wonderland kernel:        c01493ce d3fedf80 d3fedf18 d3fedf08 d3fedf10 00000000 d3fec000 d3fedf80 
Nov 12 22:43:03 wonderland kernel: Call Trace:
Nov 12 22:43:03 wonderland kernel:  [<c0148c4b>] do_lookup+0x1b/0x210
Nov 12 22:43:03 wonderland kernel:  [<c01493ce>] link_path_walk+0x58e/0x8f0
Nov 12 22:43:03 wonderland kernel:  [<c0149a1f>] path_lookup+0x11f/0x130
Nov 12 22:43:03 wonderland kernel:  [<c0149fcb>] open_namei+0x8b/0x440
Nov 12 22:43:03 wonderland kernel:  [<c011fbdb>] update_wall_time+0xb/0x40
Nov 12 22:43:03 wonderland kernel:  [<c013d42b>] filp_open+0x3b/0x60
Nov 12 22:43:03 wonderland kernel:  [<c013d817>] sys_open+0x37/0x80
Nov 12 22:43:03 wonderland kernel:  [<c0108a3b>] syscall_call+0x7/0xb
Nov 12 22:43:03 wonderland kernel: Code: 8b 6d 00 8b 54 24 18 39 53 44 75 4d 8b 44 24 24 39 43 0c 75 


>>EIP; c0151fc8 <__d_lookup+58/d0>   <=====

>>eax; dff79c50 <_end+1fb5d3c8/2042c7d8>
>>esi; d3fedf18 <_end+13bd1690/2042c7d8>
>>edi; d3fedf80 <_end+13bd16f8/2042c7d8>
>>esp; d3fede8c <_end+13bd1604/2042c7d8>

Trace; c0148c4b <do_lookup+1b/210>
Trace; c01493ce <link_path_walk+58e/8f0>
Trace; c0149a1f <path_lookup+11f/130>
Trace; c0149fcb <open_namei+8b/440>
Trace; c011fbdb <update_wall_time+b/40>
Trace; c013d42b <filp_open+3b/60>
Trace; c013d817 <sys_open+37/80>
Trace; c0108a3b <syscall_call+7/b>

Code;  c0151fc8 <__d_lookup+58/d0>
00000000 <_EIP>:
Code;  c0151fc8 <__d_lookup+58/d0>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c0151fcb <__d_lookup+5b/d0>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0151fcf <__d_lookup+5f/d0>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c0151fd2 <__d_lookup+62/d0>
   a:   75 4d                     jne    59 <_EIP+0x59>
Code;  c0151fd4 <__d_lookup+64/d0>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c0151fd8 <__d_lookup+68/d0>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c0151fdb <__d_lookup+6b/d0>
  13:   75 00                     jne    15 <_EIP+0x15>


50 warnings issued.  Results may not be reliable.


-- 
ciao,
Marco
