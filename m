Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbTFEWdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTFEWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:33:24 -0400
Received: from 141.catv67.balcab.ch ([213.207.67.141]:25740 "EHLO
	maniac.pfeifer.ch") by vger.kernel.org with ESMTP id S265226AbTFEWdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:33:20 -0400
Date: Fri, 6 Jun 2003 00:46:37 +0200
Message-Id: <200306052246.h55MkbES006588@maniac.pfeifer.ch>
From: Patrick Pfeifer <patrickpfeifer_at_netscape_dot_net@netscape.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Oops's anyone
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello - these requiered me to reboot 2.4.20

ver_linux:
===File /tmp/fifo===========================================
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux maniac 2.4.20 #10 Sat May 3 17:31:39 CEST 2003 i586 unknown
 
Gnu C                  3.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.25
e2fsprogs              1.27
Dynamic linker (ldd)   2.2.4
Linux C++ Library      5.0.1
Procps                 3.1.9
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         serial sg sr_mod cdrom scsi_mod lirc_i2c lirc_dev cs46xx ac97_codec soundcore w83781d i2c-ali15x3 i2c-proc i2c-core
============================================================

oopses:
===File /tmp/fifo===========================================
==> first <==
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c013cecc
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[cached_lookup+12/96]    Not tainted
 EFLAGS: 00010286
 eax: 00000000   ebx: cba6f005   ecx: 0000000f   edx: cbf80000
 esi: cba6f00c   edi: 00000000   ebp: c8561f98   esp: c8561f28
 ds: 0018   es: 0018   ss: 0018
 Process bash (pid: 177, stackpage=c8561000)
 Stack: c121fa20 c8561f50 cba6f005 c013d43e c121fa20 c8561f50 00000000 00000009 
        cbf36900 00000000 cba6f005 00000007 73e1a862 00000009 c8561f98 cba6f000 
        00000000 00000009 c013d8e9 cba6f000 cba6f000 c8561f98 c013db4a c8560000 
 Call Trace:    [link_path_walk+862/1632] [path_lookup+41/64] [__user_walk+42/64] [sys_stat64+23/128] [system_call+51/64]
 
 Code: 00 00 59 89 c3 58 85 db 74 0d 8b 43 4c 85 c0 74 06 8b 00 85 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c013cecc
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[cached_lookup+12/96]    Not tainted
 EFLAGS: 00010286
 eax: 00000000   ebx: cbf39005   ecx: 0000000f   edx: cbf80000
 esi: cbf3900c   edi: 00000000   ebp: c8551f98   esp: c8551f28
 ds: 0018   es: 0018   ss: 0018
 Process bash (pid: 179, stackpage=c8551000)
 Stack: c121fa20 c8551f50 cbf39005 c013d43e c121fa20 c8551f50 00000000 00000009 
        cbf36900 00000000 cbf39005 00000007 73e1a862 00000009 c8551f98 cbf39000 
        00000000 00000009 c013d8e9 cbf39000 cbf39000 c8551f98 c013db4a c8550000 
 Call Trace:    [link_path_walk+862/1632] [path_lookup+41/64] [__user_walk+42/64] [sys_stat64+23/128] [system_call+51/64]
 
 Code: 00 00 59 89 c3 58 85 db 74 0d 8b 43 4c 85 c0 74 06 8b 00 85 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c013cecc
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[cached_lookup+12/96]    Not tainted
 EFLAGS: 00010286
 eax: 00000000   ebx: cbf3c005   ecx: 0000000f   edx: cbf80000
 esi: cbf3c00c   edi: 00000000   ebp: c8975f98   esp: c8975f28
 ds: 0018   es: 0018   ss: 0018
 Process bash (pid: 185, stackpage=c8975000)
 Stack: c121fa20 c8975f50 cbf3c005 c013d43e c121fa20 c8975f50 00000000 00000009 
        cbf36900 00000000 cbf3c005 00000007 73e1a862 00000009 c8975f98 cbf3c000 
        00000000 00000009 c013d8e9 cbf3c000 cbf3c000 c8975f98 c013db4a c8974000 
 Call Trace:    [link_path_walk+862/1632] [path_lookup+41/64] [__user_walk+42/64] [sys_stat64+23/128] [system_call+51/64]
 
 Code: 00 00 59 89 c3 58 85 db 74 0d 8b 43 4c 85 c0 74 06 8b 00 85 

==> second <==
 Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c013cecc
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[cached_lookup+12/96]    Not tainted
 EFLAGS: 00210286
 eax: 00000000   ebx: cb498005   ecx: 0000000f   edx: cbf80000
 esi: cb49800c   edi: 00000000   ebp: c8979f98   esp: c8979f28
 ds: 0018   es: 0018   ss: 0018
 Process bash (pid: 185, stackpage=c8979000)
 Stack: c121fa20 c8979f50 cb498005 c013d43e c121fa20 c8979f50 00000000 00000009 
        cbf36900 00000000 cb498005 00000007 73e1a862 00000009 c8979f98 cb498000 
        00000000 00000009 c013d8e9 cb498000 cb498000 c8979f98 c013db4a c8978000 
 Call Trace:    [link_path_walk+862/1632] [path_lookup+41/64] [__user_walk+42/64] [sys_stat64+23/128] [system_call+51/64]
 
 Code: 00 00 59 89 c3 58 85 db 74 0d 8b 43 4c 85 c0 74 06 8b 00 85 
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
 c013cecc
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[cached_lookup+12/96]    Not tainted
 EFLAGS: 00210286
 eax: 00000000   ebx: cbf39005   ecx: 0000000f   edx: cbf80000
 esi: cbf3900c   edi: 00000000   ebp: c84b5f98   esp: c84b5f28
 ds: 0018   es: 0018   ss: 0018
 Process bash (pid: 197, stackpage=c84b5000)
 Stack: c121fa20 c84b5f50 cbf39005 c013d43e c121fa20 c84b5f50 00000000 00000009 
        cbf36900 00000000 cbf39005 00000007 73e1a862 00000009 c84b5f98 cbf39000 
        00000000 00000009 c013d8e9 cbf39000 cbf39000 c84b5f98 c013db4a c84b4000 
 Call Trace:    [link_path_walk+862/1632] [path_lookup+41/64] [__user_walk+42/64] [sys_stat64+23/128] [system_call+51/64]
 
 Code: 00 00 59 89 c3 58 85 db 74 0d 8b 43 4c 85 c0 74 06 8b 00 85 

==> third <==
 Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
 c01459e4
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[d_instantiate+36/64]    Not tainted
 EFLAGS: 00210282
 eax: 00000000   ebx: c943a780   ecx: c437aef0   edx: c943a790
 esi: c437aec0   edi: c437aec0   ebp: fffffff4   esp: c474df48
 ds: 0018   es: 0018   ss: 0018
 Process configure (pid: 14320, stackpage=c474d000)
 Stack: c943a780 c0d12240 c013c8e7 c437aec0 c943a780 00000007 00000004 c0d12340 
        3632315b 5d373738 00000000 c9dc90e0 c16053a0 00000000 c99e91c0 fffffff2 
        c474df68 00000008 0001ef9d bffff2c0 c474c000 c474dfb0 ffffffff bffff3d8 
 Call Trace:    [do_pipe+199/544] [sys_pipe+12/64] [system_call+51/64]
 
 Code: 89 48 04 89 46 30 89 51 04 89 4b 10 89 5e 08 5b 5e c3 8d 76 
  <1>Unable to handle kernel paging request at virtual address cdc92e48
  printing eip:
 c012c3db
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[__kmem_cache_alloc+59/224]    Not tainted
 EFLAGS: 00210002
 eax: c1215f8c   ebx: c1215f8c   ecx: c943b000   edx: cbfc0000
 esi: c1215f84   edi: 00200246   ebp: 000001f0   esp: cad09e28
 ds: 0018   es: 0018   ss: 0018
 Process wmifs (pid: 6108, stackpage=cad09000)
 Stack: 00000000 cbfd35b8 cbfd35b8 cbffa400 c012bded c1215f84 000001f0 c0146f7c 
        c1215f84 000001f0 00000000 cbfd35b8 00001017 cbffa400 c014727c cbffa400 
        00001017 cbfd35b8 00000000 00000000 c121ec20 c437a61f c121ec6f c437a5c0 
 Call Trace:    [kmem_cache_alloc+13/32] [get_new_inode+28/352] [iget4+188/224] [proc_get_inode+45/288] [proc_lookup+185/224]
   [proc_root_lookup+23/96] [real_lookup+146/192] [link_path_walk+721/1632] [path_lookup+41/64] [open_namei+114/1280] [filp_open+50/96]
   [sys_open+57/128] [system_call+51/64]
 
 Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 09 57 9d 89 
  <1>Unable to handle kernel paging request at virtual address cdc92e48
  printing eip:
 c012c3db
 *pde = 00000000
 Oops: 0000
 CPU:    0
 EIP:    0010:[__kmem_cache_alloc+59/224]    Not tainted
 EFLAGS: 00010006
 eax: c1215f8c   ebx: c1215f8c   ecx: c943b000   edx: c27e1ef8
 esi: c1215f84   edi: 00000246   ebp: 000001f0   esp: c27e1eac
 ds: 0018   es: 0018   ss: 0018
 Process esd (pid: 6082, stackpage=c27e1000)
 Stack: c7522bd0 bffffcc4 00000007 bffffcc4 c012bded c1215f84 000001f0 c0146ed1 
        c1215f84 000001f0 c7522bd0 c01c0369 00000005 bffffcc4 00000007 c01c0f62 
        c7522bd0 c01c0f7b c102c01c ffffffe8 ffffffff 00003d2e c8a5c008 c8a5c008 
 Call Trace:    [kmem_cache_alloc+13/32] [get_empty_inode+17/160] [sock_alloc+9/160] [sys_accept+34/224] [sys_accept+59/224]
   [poll_freewait+59/96] [do_select+264/512] [kfree+39/64] [sys_select+638/1216] [sys_socketcall+158/416] [sys_nanosleep+189/320]
   [system_call+51/64]
 
 Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 09 57 9d 89 
============================================================
