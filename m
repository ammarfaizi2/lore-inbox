Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRK1BVv>; Tue, 27 Nov 2001 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281843AbRK1BVn>; Tue, 27 Nov 2001 20:21:43 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:9382 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S283001AbRK1BV2>;
	Tue, 27 Nov 2001 20:21:28 -0500
Message-ID: <3C043C15.F0A8ACDA@pobox.com>
Date: Tue, 27 Nov 2001 17:21:25 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: heads-up: preempt kernel and tux NO-GO
Content-Type: multipart/mixed;
 boundary="------------17DAE8EE5F779BEC6AC1D455"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------17DAE8EE5F779BEC6AC1D455
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Forgot to attach the oopses -

Here they are:





--------------17DAE8EE5F779BEC6AC1D455
Content-Type: text/plain; charset=us-ascii;
 name="2.4.16-tux+preempt+lowlat.ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.16-tux+preempt+lowlat.ksymoops.out"

ksymoops 2.4.0 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol ftp_bandwidth  , tux says d28fd1b0, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28fa350.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol ftp_bytes_sent  , tux says d28fd1ac, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28fa34c.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol last_measurement  , tux says d28fd1a8, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28fa348.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol nr_tux_threads  , tux says d28fd220, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28fa3c0.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol threadinfo  , tux says d28fd240, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28fa3e0.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d28c1010, /lib/modules/2.4.16/kernel/fs/lockd/lockd.o says d28c0468.  Ignoring /lib/modules/2.4.16/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d28b3264, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d28b2f44.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d28b3268, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d28b2f48.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d28b326c, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d28b2f4c.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d28b3260, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d28b2f40.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol raid1_retry_tail  , raid1 says d2894b38, /lib/modules/2.4.16/kernel/drivers/md/raid1.o says d28949e0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/raid1.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d288cc80, /lib/modules/2.4.16/kernel/drivers/md/md.o says d288caa0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d288c480, /lib/modules/2.4.16/kernel/drivers/md/md.o says d288c2a0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/md.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c0127cbf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0127cbf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cdbce05c
esi: cdbce000   edi: 00000001   ebp: cfb3deb0   esp: cfb3de78
ds: 0018   es: 0018   ss: 0018
Process tux (pid: 4569, stackpage=cfb3d000)
Stack: cfb3c000 00000000 cf12aea0 d0162380 c01127bc cfb3c000 cfb3dee4 c01071a1 
       cdbce000 00000000 00000001 00000000 cdbce000 00000001 cfb3dee4 d28e1d42 
       cdbce05c cdbce07c cdbce0c8 d28e1910 00000001 cfb3ded0 d0162380 cdbce000 
Call Trace: [<c01127bc>] [<c01071a1>] [<d28e1d42>] [<d28e1910>] [<d28e6b11>] 
   [<d28dfaf0>] [<d28e0f38>] [<d28fd240>] [<d28ec025>] [<d28fd240>] [<d28fd240>] 
   [<d28ee19e>] [<d28fd240>] [<c0134f08>] [<d28fd240>] [<d28fd240>] [<c01bbba5>] 
   [<c01070cb>] 
Code: 8b 40 08 8b b8 ac 00 00 00 8b 47 20 89 45 e0 0f b7 50 30 66 

>>EIP; c0127cbf <do_generic_file_read+f/510>   <=====
Trace; c01127bc <preempt_schedule+2c/40>
Trace; c01071a1 <ret_from_exception+42/49>
Trace; d28e1d42 <[tux]generic_send_file+e2/1d0>
Trace; d28e1910 <[tux]sock_send_actor+0/240>
Trace; d28e6b11 <[tux]http_send_body+71/110>
Trace; d28dfaf0 <[tux]tux_schedule_atom+50/60>
Trace; d28e0f38 <[tux]process_requests+118/160>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; d28ec025 <[tux]event_loop+65/1b0>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; d28ee19e <[tux]__sys_tux+5ee/ba0>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; c0134f08 <sys_chdir+128/140>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; d28fd240 <[tux]__module_kernel_version+0/16>
Trace; c01bbba5 <sys_tux+25/100>
Trace; c01070cb <system_call+33/38>
Code;  c0127cbf <do_generic_file_read+f/510>
00000000 <_EIP>:
Code;  c0127cbf <do_generic_file_read+f/510>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  c0127cc2 <do_generic_file_read+12/510>
   3:   8b b8 ac 00 00 00         mov    0xac(%eax),%edi
Code;  c0127cc8 <do_generic_file_read+18/510>
   9:   8b 47 20                  mov    0x20(%edi),%eax
Code;  c0127ccb <do_generic_file_read+1b/510>
   c:   89 45 e0                  mov    %eax,0xffffffe0(%ebp)
Code;  c0127cce <do_generic_file_read+1e/510>
   f:   0f b7 50 30               movzwl 0x30(%eax),%edx
Code;  c0127cd2 <do_generic_file_read+22/510>
  13:   66                        data16


13 warnings issued.  Results may not be reliable.

--------------17DAE8EE5F779BEC6AC1D455
Content-Type: text/plain; charset=us-ascii;
 name="2.4.16-tux+preempt.ksymoops.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.16-tux+preempt.ksymoops.out"

ksymoops 2.4.0 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): mismatch on symbol ftp_bandwidth  , tux says d28c11b0, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28be350.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol ftp_bytes_sent  , tux says d28c11ac, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28be34c.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol last_measurement  , tux says d28c11a8, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28be348.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol nr_tux_threads  , tux says d28c1220, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28be3c0.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol threadinfo  , tux says d28c1240, /lib/modules/2.4.16/kernel/net/tux/tux.o says d28be3e0.  Ignoring /lib/modules/2.4.16/kernel/net/tux/tux.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d30e5010, /lib/modules/2.4.16/kernel/fs/lockd/lockd.o says d30e4468.  Ignoring /lib/modules/2.4.16/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d30d7264, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d30d6f44.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d30d7268, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d30d6f48.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d30d726c, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d30d6f4c.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d30d7260, /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o says d30d6f40.  Ignoring /lib/modules/2.4.16/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol raid1_retry_tail  , raid1 says d2894b38, /lib/modules/2.4.16/kernel/drivers/md/raid1.o says d28949e0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/raid1.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d288cc80, /lib/modules/2.4.16/kernel/drivers/md/md.o says d288caa0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d288c480, /lib/modules/2.4.16/kernel/drivers/md/md.o says d288c2a0.  Ignoring /lib/modules/2.4.16/kernel/drivers/md/md.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01279bf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01279bf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cf3d285c
esi: cf3d2800   edi: 00000001   ebp: d0195eb0   esp: d0195e78
ds: 0018   es: 0018   ss: 0018
Process tux (pid: 659, stackpage=d0195000)
Stack: 00001000 00000000 ced32440 ce03a560 00000551 00000018 cf3d6440 00000012 
       cf3d2800 00000000 00000001 00000000 cf3d2800 00000001 d0195ee4 d28a5d42 
       cf3d285c cf3d287c cf3d28c8 d28a5910 00000001 d0195ed0 ce03a560 cf3d2800 
Call Trace: [<d28a5d42>] [<d28a5910>] [<d28aab11>] [<d28a3af0>] [<d28a4f38>] 
   [<d28c1240>] [<d28b0025>] [<d28c1240>] [<d28c1240>] [<d28b219e>] [<d28c1240>] 
   [<c0134a58>] [<d28c1240>] [<d28c1240>] [<c01bb265>] [<c01070cb>] 
Code: 8b 40 08 8b b8 ac 00 00 00 8b 47 20 89 45 e0 0f b7 50 30 66 

>>EIP; c01279bf <do_generic_file_read+f/4e0>   <=====
Trace; d28a5d42 <[tux]generic_send_file+e2/1d0>
Trace; d28a5910 <[tux]sock_send_actor+0/240>
Trace; d28aab11 <[tux]http_send_body+71/110>
Trace; d28a3af0 <[tux]tux_schedule_atom+50/60>
Trace; d28a4f38 <[tux]process_requests+118/160>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28b0025 <[tux]event_loop+65/1b0>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28b219e <[tux]__sys_tux+5ee/ba0>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; c0134a58 <sys_chdir+128/140>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; c01bb265 <sys_tux+25/100>
Trace; c01070cb <system_call+33/38>
Code;  c01279bf <do_generic_file_read+f/4e0>
00000000 <_EIP>:
Code;  c01279bf <do_generic_file_read+f/4e0>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  c01279c2 <do_generic_file_read+12/4e0>
   3:   8b b8 ac 00 00 00         mov    0xac(%eax),%edi
Code;  c01279c8 <do_generic_file_read+18/4e0>
   9:   8b 47 20                  mov    0x20(%edi),%eax
Code;  c01279cb <do_generic_file_read+1b/4e0>
   c:   89 45 e0                  mov    %eax,0xffffffe0(%ebp)
Code;  c01279ce <do_generic_file_read+1e/4e0>
   f:   0f b7 50 30               movzwl 0x30(%eax),%edx
Code;  c01279d2 <do_generic_file_read+22/4e0>
  13:   66                        data16

Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01279bf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01279bf>]    Not tainted
EFLAGS: 00010296
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cde4d85c
esi: cde4d800   edi: 00000001   ebp: d0247eb0   esp: d0247e78
ds: 0018   es: 0018   ss: 0018
Process tux (pid: 2610, stackpage=d0247000)
Stack: 00001000 00000000 cf9c8f00 cee5cb60 000007c1 00000009 cf3d6440 00000000 
       cde4d800 00000000 00000001 00000000 cde4d800 00000001 d0247ee4 d28a5d42 
       cde4d85c cde4d87c cde4d8c8 d28a5910 00000001 d0247ed0 cee5cb60 cde4d800 
Call Trace: [<d28a5d42>] [<d28a5910>] [<d28aab11>] [<d28a3af0>] [<d28a4f38>] 
   [<d28c1240>] [<d28b0025>] [<d28c1240>] [<d28c1240>] [<d28b219e>] [<d28c1240>] 
   [<c0134a58>] [<d28c1240>] [<d28c1240>] [<c01bb265>] [<c01070cb>] 
Code: 8b 40 08 8b b8 ac 00 00 00 8b 47 20 89 45 e0 0f b7 50 30 66 

>>EIP; c01279bf <do_generic_file_read+f/4e0>   <=====
Trace; d28a5d42 <[tux]generic_send_file+e2/1d0>
Trace; d28a5910 <[tux]sock_send_actor+0/240>
Trace; d28aab11 <[tux]http_send_body+71/110>
Trace; d28a3af0 <[tux]tux_schedule_atom+50/60>
Trace; d28a4f38 <[tux]process_requests+118/160>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28b0025 <[tux]event_loop+65/1b0>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28b219e <[tux]__sys_tux+5ee/ba0>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; c0134a58 <sys_chdir+128/140>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; d28c1240 <[tux]__module_kernel_version+0/16>
Trace; c01bb265 <sys_tux+25/100>
Trace; c01070cb <system_call+33/38>
Code;  c01279bf <do_generic_file_read+f/4e0>
00000000 <_EIP>:
Code;  c01279bf <do_generic_file_read+f/4e0>   <=====
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=====
Code;  c01279c2 <do_generic_file_read+12/4e0>
   3:   8b b8 ac 00 00 00         mov    0xac(%eax),%edi
Code;  c01279c8 <do_generic_file_read+18/4e0>
   9:   8b 47 20                  mov    0x20(%edi),%eax
Code;  c01279cb <do_generic_file_read+1b/4e0>
   c:   89 45 e0                  mov    %eax,0xffffffe0(%ebp)
Code;  c01279ce <do_generic_file_read+1e/4e0>
   f:   0f b7 50 30               movzwl 0x30(%eax),%edx
Code;  c01279d2 <do_generic_file_read+22/4e0>
  13:   66                        data16


13 warnings issued.  Results may not be reliable.

--------------17DAE8EE5F779BEC6AC1D455--

