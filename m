Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKSKZY>; Mon, 19 Nov 2001 05:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277435AbRKSKZG>; Mon, 19 Nov 2001 05:25:06 -0500
Received: from [203.94.130.164] ([203.94.130.164]:37388 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S277431AbRKSKYq>;
	Mon, 19 Nov 2001 05:24:46 -0500
Date: Mon, 19 Nov 2001 21:53:44 +1100 (EST)
From: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: oops 1 of 2, try_to_release_page, 2.4.9-13
Message-ID: <Pine.LNX.4.40.0111192151580.14019-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Posted an oops last week, with an older rh kernel, upgraded, as per alans 
advice, and now found this in dmesg.

If theres anything you need me to do, please cc

thanks,

	/ Brett

ksymoops 2.4.1 on i686 2.4.9-13.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-13/ (default)
     -m /boot/System.map-2.4.9-13 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01b5780, System.map says c0156450.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tone_control  , emu10k1 says d29c4f54, /lib/modules/2.4.9-13/kernel/drivers/sound/emu10k1/emu10k1.o says d29c4180.  Ignoring /lib/modules/2.4.9-13/kernel/drivers/sound/emu10k1/emu10k1.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says d2983d14, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d298317c.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says d2983d10, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d2983178.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says d2983d18, /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o says d2983180.  Ignoring /lib/modules/2.4.9-13/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says d2975dc0, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975aa0.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says d2975dc4, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975aa4.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says d2975dc8, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975aa8.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says d2975dbc, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a9c.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says d2975d9c, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a7c.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says d2975d8c, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a6c.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says d2975da0, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a80.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says d2975d84, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a64.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says d2975d88, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a68.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says d2975d80, /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o says d2975a60.  Ignoring /lib/modules/2.4.9-13/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d285ba80, /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o says d285b5a0.  Ignoring /lib/modules/2.4.9-13/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Unable to handle kernel paging request at virtual address 000a7020
c0137dcf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0137dcf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 000a7000   ebx: c13fa0b8   ecx: c13fa0d4   edx: c1280d08
esi: 00000080   edi: 00000000   ebp: 00000007   esp: c1641f8c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1641000)
Stack: 00000000 c13fa0b8 c012df64 c13fa0b8 00000080 00000000 00000000 00000088 
       00004199 00000000 00000000 000000c0 000000c0 0008e000 c012e7d1 000000c0 
       00000000 c1640000 00000006 c012e865 000000c0 00000000 00010f00 c1447fb8 
Call Trace: [<c012df64>] page_launder [kernel] 0x3f4 
[<c012e7d1>] do_try_to_free_pages [kernel] 0x11 
[<c012e865>] kswapd [kernel] 0x55 
[<c0105000>] stext [kernel] 0x0 
[<c0105746>] kernel_thread [kernel] 0x26 
[<c012e810>] kswapd [kernel] 0x0 
Code: 8b 40 20 85 c0 74 0f 56 53 ff d0 5a 85 c0 59 75 05 5b 31 c0 

>>EIP; c0137dcf <try_to_release_page+2f/60>   <=====
Trace; c012df64 <page_launder+3f4/8e0>
Trace; c012e7d1 <do_try_to_free_pages+11/50>
Trace; c012e865 <kswapd+55/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105746 <kernel_thread+26/30>
Trace; c012e810 <kswapd+0/f0>
Code;  c0137dcf <try_to_release_page+2f/60>
00000000 <_EIP>:
Code;  c0137dcf <try_to_release_page+2f/60>   <=====
   0:   8b 40 20                  mov    0x20(%eax),%eax   <=====
Code;  c0137dd2 <try_to_release_page+32/60>
   3:   85 c0                     test   %eax,%eax
Code;  c0137dd4 <try_to_release_page+34/60>
   5:   74 0f                     je     16 <_EIP+0x16> c0137de5 <try_to_release_page+45/60>
Code;  c0137dd6 <try_to_release_page+36/60>
   7:   56                        push   %esi
Code;  c0137dd7 <try_to_release_page+37/60>
   8:   53                        push   %ebx
Code;  c0137dd8 <try_to_release_page+38/60>
   9:   ff d0                     call   *%eax
Code;  c0137dda <try_to_release_page+3a/60>
   b:   5a                        pop    %edx
Code;  c0137ddb <try_to_release_page+3b/60>
   c:   85 c0                     test   %eax,%eax
Code;  c0137ddd <try_to_release_page+3d/60>
   e:   59                        pop    %ecx
Code;  c0137dde <try_to_release_page+3e/60>
   f:   75 05                     jne    16 <_EIP+0x16> c0137de5 <try_to_release_page+45/60>
Code;  c0137de0 <try_to_release_page+40/60>
  11:   5b                        pop    %ebx
Code;  c0137de1 <try_to_release_page+41/60>
  12:   31 c0                     xor    %eax,%eax


18 warnings and 2 errors issued.  Results may not be reliable.

