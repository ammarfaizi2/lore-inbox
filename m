Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271541AbSISQP6>; Thu, 19 Sep 2002 12:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271545AbSISQP6>; Thu, 19 Sep 2002 12:15:58 -0400
Received: from vulcan.bascom.com ([206.112.62.10]:11177 "EHLO
	vulcan.bascom.com") by vger.kernel.org with ESMTP
	id <S271541AbSISQPv>; Thu, 19 Sep 2002 12:15:51 -0400
From: "Drew J. Como" <dcomo@bascom.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel Panic for unknown reason - Additional Info
Date: Thu, 19 Sep 2002 12:20:15 -0400
Message-ID: <000001c25ff8$70fbbf30$13013c0a@dcomo>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: 
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is some more information that may help in diagnosing
these errors:

ksymoops 2.4.0 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_LOG.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_limit.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_REJECT.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_MASQUERADE.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_REDIRECT.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ipt_state.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_filter.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_nat_ftp.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o
Error (pclose_local): read_nm_symbols pclose failed 0x7f00
Warning (read_object): no symbols in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o
Warning (compare_maps): ip_conntrack_ftp symbol ip_conntrack_ftp not found
in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o
entry
Warning (compare_maps): ip_conntrack_ftp symbol ip_ftp_lock not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack_ftp.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_cheat_check not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_delete_sack not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_helper_register not found
in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_helper_unregister not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_mangle_tcp_packet not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_seq_adjust not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): iptable_nat symbol ip_nat_setup_info not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/iptable_nat.o entry
Warning (compare_maps): ip_conntrack symbol invert_tuplepr not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_alter_reply not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_change_expect not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_destroyed not found
in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_expect_related not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_get not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_helper_register not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_helper_unregister
not found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_htable_size not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_lock not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_module not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_protocol_register
not found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_tuple_taken not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_conntrack_unexpect_related
not found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_ct_gather_frags not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_ct_refresh not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_conntrack symbol ip_ct_selective_cleanup not
found in /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o.
Ignoring /lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_conntrack.o entry
Warning (compare_maps): ip_tables symbol ipt_do_table not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_register_match not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_register_table not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_register_target not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_unregister_match not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_unregister_table not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Warning (compare_maps): ip_tables symbol ipt_unregister_target not found in
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o.  Ignoring
/lib/modules/2.4.18/kernel/net/ipv4/netfilter/ip_tables.o entry
Aug 30 00:15:37 (none) kernel: Unable to handle kernel paging request at
virtual address 50182444
Aug 30 00:15:37 (none) kernel: c0135e0d
Aug 30 00:15:37 (none) kernel: *pde = 00000000
Aug 30 00:15:37 (none) kernel: Oops: 0002
Aug 30 00:15:37 (none) kernel: CPU:    0
Aug 30 00:15:37 (none) kernel: EIP:    0010:[open_namei+633/1244]    Not
tainted
Aug 30 00:15:37 (none) kernel: EFLAGS: 00010246
Aug 30 00:15:37 (none) kernel: eax: c2ec0c10   ebx: 00000000   ecx: c02b23bc
edx: 00000003
Aug 30 00:15:37 (none) kernel: esi: c55c0000   edi: c5893f8c   ebp: 00010801
esp: c5893f54
Aug 30 00:15:37 (none) kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 00:15:37 (none) kernel: Process find (pid: 890, stackpage=c5893000)
Aug 30 00:15:37 (none) kernel: Stack: 00010800 c55c0000 08057364 bffff4cc
00001000 00000000 00000004 c2ec0c10
Aug 30 00:15:37 (none) kernel:        c012c3da c55c0000 00010801 08054538
c5893f8c 00000005 c2ec0c10 c7ffc350
Aug 30 00:15:37 (none) kernel:        08057364 bffff4cc 00000000 00000003
00000001 c012c717 c55c0000 00010800
Aug 30 00:15:37 (none) kernel: Call Trace: [filp_open+46/76]
[sys_open+51/148] [system_call+51/56]
Aug 30 00:15:37 (none) kernel: Code: 00 8b 44 24 18 50 56 e8 c3 ef ff ff 89
c3 83 c4 08 85 db 00
Using defaults from ksymoops -t elf32-i386 -a i386
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.iANrXk


Sep  5 07:06:21 (none) kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000001f
Sep  5 07:06:21 (none) kernel: c012c590
Sep  5 07:06:21 (none) kernel: *pde = 00000000
Sep  5 07:06:21 (none) kernel: Oops: 0000
Sep  5 07:06:21 (none) kernel: CPU:    0
Sep  5 07:06:21 (none) kernel: EIP:    0010:[get_unused_fd+20/360]    Not
tainted
Sep  5 07:06:21 (none) kernel: EFLAGS: 00010296
Sep  5 07:06:21 (none) kernel: eax: c5857000   ebx: c4f54000   ecx: 00000fe0
edx: 0000001f
Sep  5 07:06:21 (none) kernel: esi: c5857000   edi: bfff7d2c   ebp: bfff79ec
esp: c4f55f98
Sep  5 07:06:21 (none) kernel: ds: 0018   es: 0018   ss: 0018
Sep  5 07:06:21 (none) kernel: Process squid (pid: 147, stackpage=c4f55000)
Sep  5 07:06:21 (none) kernel: Stack: bfff79ec 08179f60 00001000 c4f54000
40016a44 bfff7d2c c4f54000 c5857000
Sep  5 07:06:21 (none) kernel:        c4f54000 40016a44 c0106d8b 08179f60
00000800 000001a4 40016a44 bfff7d2c
Sep  5 07:06:21 (none) kernel:        bfff79ec 00000005 c010002b 0000002b
00000005 4014d164 00000023 00000293
Sep  5 07:06:21 (none) kernel: Call Trace: [system_call+51/56]
Sep  5 07:06:21 (none) kernel: Code: 8b 02 d3 e8 f7 d0 0f bc d8 75 05 bb 20
00 00 00 8b 70 1c 8b
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.T8VecG


Sep  5 12:19:38 (none) kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000001f
Sep  5 12:19:38 (none) kernel: c012c590
Sep  5 12:19:38 (none) kernel: *pde = 00000000
Sep  5 12:19:38 (none) kernel: Oops: 0000
Sep  5 12:19:38 (none) kernel: CPU:    0
Sep  5 12:19:38 (none) kernel: EIP:    0010:[get_unused_fd+20/360]    Not
tainted
Sep  5 12:19:38 (none) kernel: EFLAGS: 00010296
Sep  5 12:19:38 (none) kernel: eax: c7e14000   ebx: c51be000   ecx: 00000fe0
edx: 0000001f
Sep  5 12:19:38 (none) kernel: esi: c7e14000   edi: bfff7d2c   ebp: bfff79ec
esp: c51bff98
Sep  5 12:19:38 (none) kernel: ds: 0018   es: 0018   ss: 0018
Sep  5 12:19:38 (none) kernel: Process squid (pid: 147, stackpage=c51bf000)
Sep  5 12:19:38 (none) kernel: Stack: bfff79ec 08179f60 00001000 c51be000
40016a44 bfff7d2c c51be000 c7e14000
Sep  5 12:19:38 (none) kernel:        c51be000 40016a44 c0106d8b 08179f60
00000800 000001a4 40016a44 bfff7d2c
Sep  5 12:19:38 (none) kernel:        bfff79ec 00000005 c010002b 0000002b
00000005 4014d164 00000023 00000293
Sep  5 12:19:38 (none) kernel: Call Trace: [system_call+51/56]
Sep  5 12:19:38 (none) kernel: Code: 8b 02 d3 e8 f7 d0 0f bc d8 75 05 bb 20
00 00 00 8b 70 1c 8b
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.KjKPdd


Sep  5 12:22:12 (none) kernel:  invalid operand: 0000
Sep  5 12:22:12 (none) kernel: CPU:    0
Sep  5 12:22:12 (none) kernel: EIP:    0010:[file_read_actor+7/96]    Not
tainted
Sep  5 12:22:12 (none) kernel: EFLAGS: 00010282
Sep  5 12:22:12 (none) kernel: eax: 000002fb   ebx: c10ae3c0   ecx: c6215f8c
edx: c0121f1c
Sep  5 12:22:12 (none) kernel: esi: c122b944   edi: c3844320   ebp: 00000000
esp: c6215f20
Sep  5 12:22:12 (none) kernel: ds: 0018   es: 0018   ss: 0018
Sep  5 12:22:12 (none) kernel: Process squid (pid: 4426, stackpage=c6215000)
Sep  5 12:22:12 (none) kernel: Stack: c10ae3c0 c122b944 c3844320 00000000
c0121b13 c6215f8c c10ae3c0 00000000
Sep  5 12:22:12 (none) kernel:        000002fa 00000000 c1ba7510 ffffffea
00001000 000002fa 00000001 00000000
Sep  5 12:22:12 (none) kernel:        00000000 c3844270 c012201d c1ba7510
c1ba7530 c6215f8c c0121f1c 00000000
Sep  5 12:22:12 (none) kernel: Call Trace: [do_generic_file_read+479/1036]
[generic_file_read+161/332] [file_read_actor+0/96] [sys_read+149/224]
[system_call+51/56]
Sep  5 12:22:12 (none) kernel: Code: ff ff ff 29 dd 8b 44 24 14 89 68 04 01
18 01 58 08 89 d8 5b
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.p09rLM


Sep  6 10:03:14 (none) kernel: invalid operand: 0000
Sep  6 10:03:14 (none) kernel: CPU:    0
Sep  6 10:03:14 (none) kernel: EIP:
0010:[iptable_nat:__insmod_iptable_nat_O/lib/modules/2.4.18/kernel/net/ipv4/
n+-20732175/96]    Not tainted
Sep  6 10:03:14 (none) kernel: EFLAGS: 00010246
Sep  6 10:03:14 (none) kernel: eax: 00000000   ebx: 0804d850   ecx: c43c98b0
edx: c3c88e60
Sep  6 10:03:14 (none) kernel: esi: c75c26f0   edi: 00000000   ebp: c3c88e60
esp: c3dfdebc
Sep  6 10:03:14 (none) kernel: ds: 0018   es: 0018   ss: 0018
Sep  6 10:03:14 (none) kernel: Process http-gw (pid: 6141,
stackpage=c3dfd000)
Sep  6 10:03:14 (none) kernel: Stack: 00000000 c75c26f0 c3c88e60 c3dfdedc
0804d850 c3c88e60 c43c98b0 00000000
Sep  6 10:03:14 (none) kernel:        00000000 c3c88e60 c011f61a c75c26f0
c3c88e60 0804d850 00000000 c4ff4134
Sep  6 10:03:14 (none) kernel:        00000000 c3c88e60 0804d850 c3dfc000
c010fac3 c75c26f0 c3c88e60 0804d850
Sep  6 10:03:14 (none) kernel: Call Trace: [handle_mm_fault+82/180]
[do_page_fault+331/1096] [do_page_fault+0/1096] [sock_read+132/144]
[sys_read+216/224]
Sep  6 10:03:14 (none) kernel: Code: 8e c8 c3 48 82 c8 c3 60 8e c8 c3 00 f0
8b c6 01 00 00 00 01
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.0CMb9E


Sep  9 10:49:42 (none) kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Sep  9 10:49:42 (none) kernel: c013a201
Sep  9 10:49:42 (none) kernel: *pde = 00000000
Sep  9 10:49:42 (none) kernel: Oops: 0002
Sep  9 10:49:42 (none) kernel: CPU:    0
Sep  9 10:49:42 (none) kernel: EIP:    0010:[flock_make_lock+25/112]    Not
tainted
Sep  9 10:49:42 (none) kernel: EFLAGS: 00010286
Sep  9 10:49:42 (none) kernel: eax: 00000000   ebx: fffffff7   ecx: c6cf9344
edx: c6cf9344
Sep  9 10:49:42 (none) kernel: esi: 00000000   edi: 00000000   ebp: ffffffdb
esp: c7977f80
Sep  9 10:49:42 (none) kernel: ds: 0018   es: 0018   ss: 0018
Sep  9 10:49:42 (none) kernel: Process login.cgi (pid: 6811,
stackpage=c7977000)
Sep  9 10:49:42 (none) kernel: Stack: c013ac1e c41853c0 00000001 fffffff7
00000006 c41853c0 bffff9fc 00000000
Sep  9 10:49:42 (none) kernel:        c5872db0 c013b7cd c41853c0 00000001
00000000 c7976000 bffff9a4 0806d530
Sep  9 10:49:42 (none) kernel:        c0106d8b 00000005 00000006 40020f18
bffff9a4 0806d530 bffff9fc 0000008f
Sep  9 10:49:42 (none) kernel: Call Trace: [flock_lock_file+54/392]
[sys_flock+161/180] [system_call+51/56]
Sep  9 10:49:42 (none) kernel: Code: 00 00 00 c7 41 44 00 00 00 00 c7 41 48
00 00 00 00 89 c8 c3
Error (pclose_local): Oops_decode pclose failed 0x7f00
Error (Oops_decode): no objdump lines read for /tmp/ksymoops.ajPoKj

46 warnings and 24 errors issued.  Results may not be reliable.

(io_ports)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03e8-03ef : serial(set)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
08b0-08bf : PCI device 1166:0211
  08b0-08b7 : ide0
  08b8-08bf : ide1
0cf8-0cff : PCI conf1
d480-d4bf : PCI device 8086:1229
  d480-d4bf : eepro100
d4c0-d4ff : PCI device 8086:1229
  d4c0-d4ff : eepro100
d800-d8ff : PCI device 9005:00cf
  d800-d8ff : aic7xxx
dc00-dcff : PCI device 9005:00cf
  dc00-dcff : aic7xxx
e800-e8ff : PCI device 1002:4752
ecc0-ecff : PCI device 8086:1229
  ecc0-ecff : eepro100

(io_mem)

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffdfff : System RAM
  00100000-0025c5f0 : Kernel code
  0025c5f1-002c6397 : Kernel data
f9000000-f901ffff : PCI device 8086:1229
f9020000-f903ffff : PCI device 8086:1229
f9040000-f9040fff : PCI device 8086:1229
  f9040000-f9040fff : eepro100
f9041000-f9041fff : PCI device 8086:1229
  f9041000-f9041fff : eepro100
f9042000-f9042fff : PCI device 9005:00cf
  f9042000-f9042fff : aic7xxx
f9043000-f9043fff : PCI device 9005:00cf
  f9043000-f9043fff : aic7xxx
fc000000-fcffffff : PCI device 1002:4752
fe000000-fe0fffff : PCI device 8086:1229
fe100000-fe100fff : PCI device 1166:0220
fe101000-fe101fff : PCI device 1002:4752
fe102000-fe102fff : PCI device 8086:1229
  fe102000-fe102fff : eepro100

Thanks :-)

============================================
Drew J. Como             Phone: 631-434-6600
Systems Administrator      Fax: 631-434-7800
dcomo@bascom.com         Web: www.bascom.com
    Bascom Global Internet Services, Inc.
--------------------------------------------
          "When quality is the goal,
           winning is guaranteed."




-----Original Message-----
From: Drew J. Como [mailto:dcomo@bascom.com]
Sent: Thursday, September 19, 2002 11:28 AM
To: 'linux-kernel@vger.kernel.org'
Subject: PROBLEM: Kernel Panic for unknown reason


As per the information listed below, I have a system that will
only kernel panic when traffic is being sent to him.  If I disconnect
all of the network cables, etc. and let him be, he doesn't panic.

Aug 30 00:15:37 (none) kernel: Unable to handle kernel paging request at
virtual address 50182444
Aug 30 00:15:37 (none) kernel:  printing eip:
Aug 30 00:15:37 (none) kernel: c0135e0d
Aug 30 00:15:37 (none) kernel: *pde = 00000000
Aug 30 00:15:37 (none) kernel: Oops: 0002
Aug 30 00:15:37 (none) kernel: CPU:    0
Aug 30 00:15:37 (none) kernel: EIP:    0010:[open_namei+633/1244]    Not
tainted
Aug 30 00:15:37 (none) kernel: EFLAGS: 00010246
Aug 30 00:15:37 (none) kernel: eax: c2ec0c10   ebx: 00000000   ecx: c02b23bc
edx: 00000003
Aug 30 00:15:37 (none) kernel: esi: c55c0000   edi: c5893f8c   ebp: 00010801
esp: c5893f54
Aug 30 00:15:37 (none) kernel: ds: 0018   es: 0018   ss: 0018
Aug 30 00:15:37 (none) kernel: Process find (pid: 890, stackpage=c5893000)
Aug 30 00:15:37 (none) kernel: Stack: 00010800 c55c0000 08057364 bffff4cc
00001000 00000000 00000004 c2ec0c10
Aug 30 00:15:37 (none) kernel:        c012c3da c55c0000 00010801 08054538
c5893f8c 00000005 c2ec0c10 c7ffc350
Aug 30 00:15:37 (none) kernel:        08057364 bffff4cc 00000000 00000003
00000001 c012c717 c55c0000 00010800
Aug 30 00:15:37 (none) kernel: Call Trace: [filp_open+46/76]
[sys_open+51/148] [system_call+51/56]
Aug 30 00:15:37 (none) kernel:
Aug 30 00:15:37 (none) kernel: Code: 00 8b 44 24 18 50 56 e8 c3 ef ff ff 89
c3 83 c4 08 85 db 00

# cat cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 997.532
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

# cat modules

ipt_LOG                 3120   1 (autoclean)
ipt_limit                960   1 (autoclean)
ipt_REJECT              2784  11 (autoclean)
ipt_MASQUERADE          1200   2 (autoclean)
ipt_REDIRECT             736   1 (autoclean)
ipt_state                608   4 (autoclean)
iptable_filter          1728   1 (autoclean)
ip_nat_ftp              2720   0 (unused)
ip_conntrack_ftp        3472   0 (unused)
iptable_nat            13168   2 (autoclean) [ipt_MASQUERADE ipt_REDIRECT
ip_nat_ftp]
ip_conntrack           14384   3 [ipt_MASQUERADE ipt_REDIRECT ipt_state
ip_nat_ftp ip_conntrack_ftp iptable_nat]
ip_tables              10528  10 [ipt_LOG ipt_limit ipt_REJECT
ipt_MASQUERADE ipt_REDIRECT ipt_state iptable_filter iptable_nat]

# lspci -vvv

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 48, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 48, cache line size 08

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
08)
	Subsystem: Dell Computer Corporation: Unknown device 009b
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fe102000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ecc0 [size=64]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fd000000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0e.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
(prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at fe101000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master
SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 08b0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if
10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe100000 (32-bit, non-prefetchable) [size=4K]

01:02.0 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at f9043000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.1 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ce
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at f9042000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at f8000000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f9041000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d4c0 [size=64]
	Region 2: Memory at f9020000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
0d)
	Subsystem: Intel Corporation: Unknown device 1050
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f9040000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at d480 [size=64]
	Region 2: Memory at f9000000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

Please let me know if this is a hardware problem or ???...

Thanks for your help!!

============================================
Drew J. Como             Phone: 631-434-6600
Systems Administrator      Fax: 631-434-7800
dcomo@bascom.com         Web: www.bascom.com
    Bascom Global Internet Services, Inc.
--------------------------------------------
          "When quality is the goal,
           winning is guaranteed."

