Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSFGSdA>; Fri, 7 Jun 2002 14:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317321AbSFGSdA>; Fri, 7 Jun 2002 14:33:00 -0400
Received: from exchange.ignitemedia.com ([207.24.163.39]:57639 "EHLO
	ignitemedia.com") by vger.kernel.org with ESMTP id <S317320AbSFGSc5> convert rfc822-to-8bit;
	Fri, 7 Jun 2002 14:32:57 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel meltdown
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Fri, 7 Jun 2002 13:28:37 -0500
Message-ID: <D466FBEAA19E7E408BE3FAAC6EEB567602456B9F@utah.ignitemedia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel meltdown
Thread-Index: AcIOUF9bFDU4E6HVS0i1GOxfg6GijgAASp7g
From: "Anna Riley" <ariley@ignitesports.com>
To: "Thunder from the hill" <thunder@ngforever.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the output and thanks Thunder:

ksymoops 2.4.1 on i686 2.4.9-31smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-31smp/ (default)
     -m /boot/System.map-2.4.9-31smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sym53c8xx.o) for sym53c8xx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.9-31smp/build: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100


Warning (compare_maps): ksyms_base symbol
GPLONLY_IO_APIC_get_PCI_irq_vector not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
GPLONLY_pci_hp_change_slot_info not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_pci_hp_deregister not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_pci_hp_register not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01c2f40, System.map says c0161e20.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd
says e4924e54, /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o says
e49242b4.  Ignoring /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o
entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
e4924e50, /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o says
e49242b0.  Ignoring /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o
entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says
e4924e58, /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o says
e49242b8.  Ignoring /lib/modules/2.4.9-31smp/kernel/fs/lockd/lockd.o
entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
e4916180, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e60.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
e4916184, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e64.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
e4916188, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e68.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
e491617c, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e5c.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc
says e491615c, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e3c.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
e491614c, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e2c.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
e4916160, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e40.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says
e4916144, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e24.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says
e4916148, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e28.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says
e4916140, /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o says
e4915e20.  Ignoring /lib/modules/2.4.9-31smp/kernel/net/sunrpc/sunrpc.o
entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says e48db520, /lib/modules/2.4.9-31smp/kernel/drivers/usb/usbcore.o
says e48db040.  Ignoring
/lib/modules/2.4.9-31smp/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
Warning (compare_maps): mismatch on symbol sd  , sd_mod says e481ce60,
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/sd_mod.o says e481cdc0.
Ignoring /lib/modules/2.4.9-31smp/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says
e4818c9c, /lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o says
e48174d4.  Ignoring
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod
says e4818cc8, /lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o
says e4817500.  Ignoring
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod
says e4818cc4, /lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o
says e48174fc.  Ignoring
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says
e4818ccc, /lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o says
e4817504.  Ignoring
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  ,
scsi_mod says e4818c98,
/lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o says e48174d0.
Ignoring /lib/modules/2.4.9-31smp/kernel/drivers/scsi/scsi_mod.o entry
 kernel BUG at slab.c:1767!
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[kmem_cache_reap+504/912]    Not tainted
 EIP:    0010:[<c0133d08>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 EFLAGS: 00010092
 eax: 0000001b   ebx: e2c34000   ecx: c02db9e4   edx: 00003906
 esi: c1b8f9e8   edi: c1b8f9f8   ebp: 00000000   esp: e3fedf8c
 ds: 0018   es: 0018   ss: 0018
 Process kswapd (pid: 5, stackpage=e3fed000)
 Stack: c024f253 000006e7 00000d80 c1b8f9f8 c1b8f9f0 00000183 e3f9d000
0000000a 
        00000000 00000000 00000000 00000183 000000c0 000000c0 0008e000
c0136076 
        000000c0 e3fec000 00000006 c01360d5 000000c0 00000000 00010f00
c1d9ffb8 
 Call Trace: [call_spurious_interrupt+130654/156203] .rodata.str1.1
[kernel] 0x2a8e 
 Call Trace: [<c024f253>] .rodata.str1.1 [kernel] 0x2a8e 
 [<c0136076>] do_try_to_free_pages [kernel] 0x46 
 [<c01360d5>] kswapd [kernel] 0x55 
 [<c0105000>] stext [kernel] 0x0 
 [<c0105866>] kernel_thread [kernel] 0x26 
 [<c0136080>] kswapd [kernel] 0x0 
 Code: 0f 0b 58 5a 8b 03 45 39 f8 75 dd 8b 4e 2c 89 ea 8b 7e 4c d3 

>>EIP; c0133d08 <kmem_cache_reap+1f8/390>   <=====
Trace; c024f253 <call_spurious_interrupt+1fe5e/2622b>
Trace; c0136076 <do_try_to_free_pages+46/50>
Trace; c01360d5 <kswapd+55/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105866 <kernel_thread+26/30>
Trace; c0136080 <kswapd+0/f0>
Code;  c0133d08 <kmem_cache_reap+1f8/390>
00000000 <_EIP>:
Code;  c0133d08 <kmem_cache_reap+1f8/390>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0133d0a <kmem_cache_reap+1fa/390>
   2:   58                        pop    %eax
Code;  c0133d0b <kmem_cache_reap+1fb/390>
   3:   5a                        pop    %edx
Code;  c0133d0c <kmem_cache_reap+1fc/390>
   4:   8b 03                     mov    (%ebx),%eax
Code;  c0133d0e <kmem_cache_reap+1fe/390>
   6:   45                        inc    %ebp
Code;  c0133d0f <kmem_cache_reap+1ff/390>
   7:   39 f8                     cmp    %edi,%eax
Code;  c0133d11 <kmem_cache_reap+201/390>
   9:   75 dd                     jne    ffffffe8 <_EIP+0xffffffe8>
c0133cf0 <kmem_cache_reap+1e0/390>
Code;  c0133d13 <kmem_cache_reap+203/390>
   b:   8b 4e 2c                  mov    0x2c(%esi),%ecx
Code;  c0133d16 <kmem_cache_reap+206/390>
   e:   89 ea                     mov    %ebp,%edx
Code;  c0133d18 <kmem_cache_reap+208/390>
  10:   8b 7e 4c                  mov    0x4c(%esi),%edi
Code;  c0133d1b <kmem_cache_reap+20b/390>
  13:   d3 00                     roll   %cl,(%eax)


27 warnings and 6 errors issued.  Results may not be reliable.




-anna



-----Original Message-----
From: Thunder from the hill [mailto:thunder@ngforever.de]
Sent: Friday, June 07, 2002 1:27 PM
To: Anna Riley
Cc: Thunder from the hill
Subject: RE: kernel meltdown


Hi,

On Fri, 7 Jun 2002, Anna Riley wrote:
>  kernel BUG at slab.c:1767!
>  invalid operand: 0000
>  Kernel 2.4.9-31smp
>  CPU:    0
>  EIP:    0010:[kmem_cache_reap+504/912]    Not tainted
>  EIP:    0010:[<c0133d08>]    Not tainted
>  EFLAGS: 00010092
>  EIP is at kmem_cache_reap [kernel] 0x1f8 
>  eax: 0000001b   ebx: e2c34000   ecx: c02db9e4   edx: 00003906
>  esi: c1b8f9e8   edi: c1b8f9f8   ebp: 00000000   esp: e3fedf8c
>  ds: 0018   es: 0018   ss: 0018
>  Process kswapd (pid: 5, stackpage=e3fed000)
>  Stack: c024f253 000006e7 00000d80 c1b8f9f8 c1b8f9f0 00000183 e3f9d000
> 0000000a 
>         00000000 00000000 00000000 00000183 000000c0 000000c0 0008e000
> c0136076 
>         000000c0 e3fec000 00000006 c01360d5 000000c0 00000000 00010f00
> c1d9ffb8 
>  Call Trace: [call_spurious_interrupt+130654/156203] .rodata.str1.1
> [kernel] 0x2a8e 
>  Call Trace: [<c024f253>] .rodata.str1.1 [kernel] 0x2a8e 
>  [do_try_to_free_pages+70/80] do_try_to_free_pages [kernel] 0x46 
>  [<c0136076>] do_try_to_free_pages [kernel] 0x46 
>  [kswapd+85/240] kswapd [kernel] 0x55 
>  [<c01360d5>] kswapd [kernel] 0x55 
>  [_stext+0/96] stext [kernel] 0x0 
>  [<c0105000>] stext [kernel] 0x0 
>  [kernel_thread+38/48] kernel_thread [kernel] 0x26 
>  [<c0105866>] kernel_thread [kernel] 0x26 
>  [kswapd+0/240] kswapd [kernel] 0x0 
>  [<c0136080>] kswapd [kernel] 0x0 
>  Code: 0f 0b 58 5a 8b 03 45 39 f8 75 dd 8b 4e 2c 89 ea 8b 7e 4c d3 

> > Then do "cat $filename | ksymoops" and send the result to the list.

Yet you haven't pushed it through ksymoops, which was the whole
training. 
Only you can do that, since only you have the appropriate symbols.
Please 
push this oops through ksymoops and mail it to 
linux-kernel@vger.kernel.org! (I will get it, either)

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at
ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

