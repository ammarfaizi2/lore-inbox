Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264448AbTCXRRy>; Mon, 24 Mar 2003 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264422AbTCXRQU>; Mon, 24 Mar 2003 12:16:20 -0500
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:33043 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S264378AbTCXRPk>;
	Mon, 24 Mar 2003 12:15:40 -0500
Subject: Latest Redhat Kernel OOPS
From: Adam Voigt <adam@cryptocomm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Mar 2003 12:26:43 -0500
Message-Id: <1048526809.1239.4.camel@beowulf.cryptocomm.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 24 Mar 2003 17:26:48.0515 (UTC) FILETIME=[8CD59130:01C2F22A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU: 2.4 GHZ Pentium 4
RAM: 512 MB
HD: 20 GB

Running the very latest Redhat kernel, A simple "ls" produced
the following, any ideas would be very much appreciated.
Same thing is produced trying to shutdown after these 3 oops's.
I will suppply any other info you might need on request.

Mar 24 12:20:42 mls kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000034
Mar 24 12:20:42 mls kernel:  printing eip:
Mar 24 12:20:42 mls kernel: c01545f1
Mar 24 12:20:42 mls kernel: *pde = 00000000
Mar 24 12:20:42 mls kernel: Oops: 0000
Mar 24 12:20:42 mls kernel: 8139too mii iptable_filter ip_tables ext3
jbd  
Mar 24 12:20:42 mls kernel: CPU:    0
Mar 24 12:20:42 mls kernel: EIP:    0010:[<c01545f1>]    Not tainted
Mar 24 12:20:42 mls kernel: EFLAGS: 00010217
Mar 24 12:20:42 mls kernel: 
Mar 24 12:20:42 mls kernel: EIP is at d_lookup [kernel] 0x61
(2.4.18-27.8.0)
Mar 24 12:20:42 mls kernel: eax: dff1c048   ebx: 00000000   ecx:
00000010   edx: dff00000
Mar 24 12:20:42 mls kernel: esi: fffffff0   edi: 00000000   ebp:
d7fd1d32   esp: d3513e8c
Mar 24 12:20:42 mls kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 12:20:42 mls kernel: Process zcat (pid: 5385, stackpage=d3513000)
Mar 24 12:20:42 mls kernel: Stack: c2319c04 00000136 c2260100 c22601a8
fffffff0 dff1c048 def59002 00000014 
Mar 24 12:20:42 mls kernel:        def59002 def59016 00000000 d3513f48
c014ab4b de623f00 d3513eec def59002 
Mar 24 12:20:42 mls kernel:        c014b199 de623f00 d3513eec 00000000
00000009 00000000 d828a180 00000000 
Mar 24 12:20:42 mls kernel: Call Trace: [<c014ab4b>] cached_lookup
[kernel] 0x1b (0xd3513ebc))
Mar 24 12:20:42 mls kernel: [<c014b199>] link_path_walk [kernel] 0x3d9
(0xd3513ecc))
Mar 24 12:20:42 mls kernel: [<c014b7b9>] path_lookup [kernel] 0x39
(0xd3513f0c))
Mar 24 12:20:42 mls kernel: [<c014ba59>] __user_walk [kernel] 0x49
(0xd3513f1c))
Mar 24 12:20:42 mls kernel: [<c0147b4f>] vfs_stat [kernel] 0x1f
(0xd3513f38))
Mar 24 12:20:42 mls kernel: [<c012d9e3>] unmap_fixup [kernel] 0x163
(0xd3513f3c))
Mar 24 12:20:42 mls kernel: [<c0125d00>] sys_rt_sigaction [kernel] 0xa0
(0xd3513f64))
Mar 24 12:20:42 mls kernel: [<c01481cb>] sys_stat64 [kernel] 0x1b
(0xd3513f70))
Mar 24 12:20:42 mls kernel: [<c0116900>] do_page_fault [kernel] 0x0
(0xd3513fb0))
Mar 24 12:20:42 mls kernel: [<c0109238>] error_code [kernel] 0x34
(0xd3513fb8))
Mar 24 12:20:42 mls kernel: [<c0109147>] system_call [kernel] 0x33
(0xd3513fc0))
Mar 24 12:20:42 mls kernel: 
Mar 24 12:20:42 mls kernel: 
Mar 24 12:20:42 mls kernel: Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 34 39 7e
0c 75 df 8b 57 4c 85 
Mar 24 12:20:48 mls kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000034
Mar 24 12:20:48 mls kernel:  printing eip:
Mar 24 12:20:48 mls kernel: c01545f1
Mar 24 12:20:48 mls kernel: *pde = 00000000
Mar 24 12:20:48 mls kernel: Oops: 0000
Mar 24 12:20:48 mls kernel: 8139too mii iptable_filter ip_tables ext3
jbd  
Mar 24 12:20:48 mls kernel: CPU:    0
Mar 24 12:20:48 mls kernel: EIP:    0010:[<c01545f1>]    Not tainted
Mar 24 12:20:48 mls kernel: EFLAGS: 00010213
Mar 24 12:20:48 mls kernel: 
Mar 24 12:20:48 mls kernel: EIP is at d_lookup [kernel] 0x61
(2.4.18-27.8.0)
Mar 24 12:20:48 mls kernel: eax: dff1d1c8   ebx: 00000000   ecx:
00000010   edx: dff00000
Mar 24 12:20:48 mls kernel: esi: fffffff0   edi: 00000000   ebp:
8fafe6d7   esp: d3513e8c
Mar 24 12:20:48 mls kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 12:20:48 mls kernel: Process zcat (pid: 6750, stackpage=d3513000)
Mar 24 12:20:48 mls kernel: Stack: c2319c04 00000136 c2260100 c22601a8
fffffff0 dff1d1c8 def5d002 0000000f 
Mar 24 12:20:48 mls kernel:        def5d002 def5d011 00000000 d3513f48
c014ab4b de623f00 d3513eec def5d002 
Mar 24 12:20:48 mls kernel:        c014b199 de623f00 d3513eec 00000000
00000009 00000000 d828a180 00000000 
Mar 24 12:20:48 mls kernel: Call Trace: [<c014ab4b>] cached_lookup
[kernel] 0x1b (0xd3513ebc))
Mar 24 12:20:48 mls kernel: [<c014b199>] link_path_walk [kernel] 0x3d9
(0xd3513ecc))
Mar 24 12:20:48 mls kernel: [<c014b7b9>] path_lookup [kernel] 0x39
(0xd3513f0c))
Mar 24 12:20:48 mls kernel: [<c014ba59>] __user_walk [kernel] 0x49
(0xd3513f1c))
Mar 24 12:20:48 mls kernel: [<c0147b4f>] vfs_stat [kernel] 0x1f
(0xd3513f38))
Mar 24 12:20:48 mls kernel: [<c012d9e3>] unmap_fixup [kernel] 0x163
(0xd3513f3c))
Mar 24 12:20:48 mls kernel: [<c0125d00>] sys_rt_sigaction [kernel] 0xa0
(0xd3513f64))
Mar 24 12:20:48 mls kernel: [<c01481cb>] sys_stat64 [kernel] 0x1b
(0xd3513f70))
Mar 24 12:20:48 mls kernel: [<c0116900>] do_page_fault [kernel] 0x0
(0xd3513fb0))
Mar 24 12:20:48 mls kernel: [<c0109238>] error_code [kernel] 0x34
(0xd3513fb8))
Mar 24 12:20:48 mls kernel: [<c0109147>] system_call [kernel] 0x33
(0xd3513fc0))
Mar 24 12:20:48 mls kernel: 
Mar 24 12:20:48 mls kernel: 
Mar 24 12:20:48 mls kernel: Code: 39 6e 44 8b 1b 75 e8 8b 7c 24 34 39 7e
0c 75 df 8b 57 4c 85 
Mar 24 12:20:58 mls kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000004
Mar 24 12:20:58 mls kernel:  printing eip:
Mar 24 12:20:58 mls kernel: c0154280
Mar 24 12:20:58 mls kernel: *pde = 00000000
Mar 24 12:20:58 mls kernel: Oops: 0002
Mar 24 12:20:58 mls kernel: 8139too mii iptable_filter ip_tables ext3
jbd  
Mar 24 12:20:58 mls kernel: CPU:    0
Mar 24 12:20:58 mls kernel: EIP:    0010:[<c0154280>]    Not tainted
Mar 24 12:20:58 mls kernel: EFLAGS: 00010246
Mar 24 12:20:58 mls kernel: 
Mar 24 12:20:58 mls kernel: EIP is at select_parent [kernel] 0x60
(2.4.18-27.8.0)
Mar 24 12:20:58 mls kernel: eax: d62ff918   ebx: d6b94800   ecx:
d6b94818   edx: 00000000
Mar 24 12:20:58 mls kernel: esi: d6b944a8   edi: 00000000   ebp:
d6b94480   esp: d3369f30
Mar 24 12:20:58 mls kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 12:20:58 mls kernel: Process rm (pid: 8397, stackpage=d3369000)
Mar 24 12:20:58 mls kernel: Stack: d6b944a8 d3368000 00000000 d3368000
d6b94480 df84d980 d6b94480 c01542f8 
Mar 24 12:20:58 mls kernel:        d6b94480 d6b94480 df84d9fc c014c746
d6b94480 def5a000 c014c837 d6b94480 
Mar 24 12:20:58 mls kernel:        00000003 def5a000 d6b94480 d6b94480
d3369f90 c014cacd df84d980 d6b94480 
Mar 24 12:20:58 mls kernel: Call Trace: [<c01542f8>]
shrink_dcache_parent [kernel] 0x18 (0xd3369f4c))
Mar 24 12:20:58 mls kernel: [<c014c746>] d_unhash [kernel] 0x26
(0xd3369f5c))
Mar 24 12:20:58 mls kernel: [<c014c837>] vfs_rmdir [kernel] 0xb7
(0xd3369f68))
Mar 24 12:20:58 mls kernel: [<c014cacd>] sys_rmdir [kernel] 0xed
(0xd3369f84))
Mar 24 12:20:58 mls kernel: [<c0109147>] system_call [kernel] 0x33
(0xd3369fc0))
Mar 24 12:20:58 mls kernel: 
Mar 24 12:20:58 mls kernel: 
Mar 24 12:20:58 mls kernel: Code: 89 4a 04 89 53 18 89 41 04 89 08 ff 44
24 08 47 81 ff f4 01 


-- 
Adam Voigt (adam@cryptocomm.com)
The Cryptocomm Group
My GPG Key: http://64.238.252.49:8080/adam_at_cryptocomm.asc

