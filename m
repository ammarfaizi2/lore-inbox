Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUDGQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUDGQ30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:29:26 -0400
Received: from [213.215.133.72] ([213.215.133.72]:11728 "EHLO smtp.ludonet.it")
	by vger.kernel.org with ESMTP id S263731AbUDGQ3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:29:09 -0400
Message-ID: <40742C55.1070009@ludonet.it>
Date: Wed, 07 Apr 2004 18:29:09 +0200
From: Paolo Perrucci <p.perrucci@ludonet.it>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hope this helps
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Ludonet-MailScanner-Information: 
X-Ludonet-MailScanner: Found to be clean
X-MailScanner-From: p.perrucci@ludonet.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.0 on i686 2.4.9-34smp.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.9-34smp/ (default)
      -m /boot/System.map-2.4.9-34smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/dpt_i2o.o) for dpt_i2o
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
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
says c01c32f0, System.map says c0162190.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore 
says f8a33e20, /lib/modules/2.4.9-34smp/kernel/drivers/usb/usbcore.o 
says f8a33940.  Ignoring 
/lib/modules/2.4.9-34smp/kernel/drivers/usb/usbcore.o entry
Warning (map_ksym_to_module): cannot match loaded module dpt_i2o to a 
unique module object.  Trace may not be reliable.
Warning (compare_maps): mismatch on symbol sd  , sd_mod says f881ce60, 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/sd_mod.o says f881cdc0. 
Ignoring /lib/modules/2.4.9-34smp/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says 
f8818c9c, /lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o says 
f88174d4.  Ignoring 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod 
says f8818cc8, /lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o 
says f8817500.  Ignoring 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod 
says f8818cc4, /lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o 
says f88174fc.  Ignoring 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says 
f8818ccc, /lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o says 
f8817504.  Ignoring 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , 
scsi_mod says f8818c98, 
/lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o says f88174d0. 
Ignoring /lib/modules/2.4.9-34smp/kernel/drivers/scsi/scsi_mod.o entry
Apr  7 13:23:28 mecenate kernel: kernel BUG at slab.c:1767!
Apr  7 13:23:28 mecenate kernel: invalid operand: 0000
Apr  7 13:23:28 mecenate kernel: CPU:    1
Apr  7 13:23:28 mecenate kernel: EIP:    0010:[kmem_cache_reap+504/912] 
    Not tainted
Apr  7 13:23:28 mecenate kernel: EIP:    0010:[<c0133dc8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr  7 13:23:28 mecenate kernel: EFLAGS: 00010092
Apr  7 13:23:28 mecenate kernel: eax: 0000001b   ebx: c31e6000   ecx: 
c02dbf04   edx: 07d67de0
Apr  7 13:23:28 mecenate kernel: esi: c22849e8   edi: c22849f8   ebp: 
00000000   esp: c22dbf8c
Apr  7 13:23:28 mecenate kernel: ds: 0018   es: 0018   ss: 0018
Apr  7 13:23:28 mecenate kernel: Process kswapd (pid: 5, stackpage=c22db000)
Apr  7 13:23:28 mecenate kernel: Stack: c024f693 000006e7 000002a0 
c22849f8 c22849f0 000000f5 c220a800 0000000a
Apr  7 13:23:28 mecenate kernel:        00000000 00000000 00000000 
00000260 000000c0 000000c0 0008e000 c0136136
Apr  7 13:23:28 mecenate kernel:        000000c0 c22da000 00000006 
c0136195 000000c0 00000000 00010f00 c22fbfb8
Apr  7 13:23:28 mecenate kernel: Call Trace: 
[call_spurious_interrupt+130686/156235] .rodata.str1.1 [kernel] 0x2a8e
Apr  7 13:23:28 mecenate kernel: Call Trace: [<c024f693>] .rodata.str1.1 
[kernel] 0x2a8e
Apr  7 13:23:28 mecenate kernel: [<c0136136>] do_try_to_free_pages 
[kernel] 0x46
Apr  7 13:23:28 mecenate kernel: [<c0136195>] kswapd [kernel] 0x55
Apr  7 13:23:28 mecenate kernel: [<c0105000>] stext [kernel] 0x0
Apr  7 13:23:28 mecenate kernel: [<c0105866>] kernel_thread [kernel] 0x26
Apr  7 13:23:28 mecenate kernel: [<c0136140>] kswapd [kernel] 0x0
Apr  7 13:23:28 mecenate kernel: Code: 0f 0b 58 5a 8b 03 45 39 f8 75 dd 
8b 4e 2c 89 ea 8b 7e 4c d3

>>EIP; c0133dc8 <kmem_cache_reap+1f8/390>   <=====
Trace; c024f693 <call_spurious_interrupt+1fe7e/2624b>
Trace; c0136136 <do_try_to_free_pages+46/50>
Trace; c0136195 <kswapd+55/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105866 <kernel_thread+26/30>
Trace; c0136140 <kswapd+0/f0>
Code;  c0133dc8 <kmem_cache_reap+1f8/390>
00000000 <_EIP>:
Code;  c0133dc8 <kmem_cache_reap+1f8/390>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0133dca <kmem_cache_reap+1fa/390>
    2:   58                        pop    %eax
Code;  c0133dcb <kmem_cache_reap+1fb/390>
    3:   5a                        pop    %edx
Code;  c0133dcc <kmem_cache_reap+1fc/390>
    4:   8b 03                     mov    (%ebx),%eax
Code;  c0133dce <kmem_cache_reap+1fe/390>
    6:   45                        inc    %ebp
Code;  c0133dcf <kmem_cache_reap+1ff/390>
    7:   39 f8                     cmp    %edi,%eax
Code;  c0133dd1 <kmem_cache_reap+201/390>
    9:   75 dd                     jne    ffffffe8 <_EIP+0xffffffe8> 
c0133db0 <kmem_cache_reap+1e0/390>
Code;  c0133dd3 <kmem_cache_reap+203/390>
    b:   8b 4e 2c                  mov    0x2c(%esi),%ecx
Code;  c0133dd6 <kmem_cache_reap+206/390>
    e:   89 ea                     mov    %ebp,%edx
Code;  c0133dd8 <kmem_cache_reap+208/390>
   10:   8b 7e 4c                  mov    0x4c(%esi),%edi
Code;  c0133ddb <kmem_cache_reap+20b/390>
   13:   d3 00                     roll   %cl,(%eax)


14 warnings and 3 errors issued.  Results may not be reliable.

-- 
Il messaggio e' stato analizzato alla ricerca di virus o
contenuti pericolosi da MailScanner, ed e'
risultato non infetto.


-- 
Il messaggio e' stato analizzato alla ricerca di virus o
contenuti pericolosi da MailScanner, ed e'
risultato non infetto.

