Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271847AbRHUUMf>; Tue, 21 Aug 2001 16:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271848AbRHUUMU>; Tue, 21 Aug 2001 16:12:20 -0400
Received: from [145.254.145.253] ([145.254.145.253]:20207 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271846AbRHUUMG>;
	Tue, 21 Aug 2001 16:12:06 -0400
Message-ID: <3B82C026.CA76C3D6@pcsystems.de>
Date: Tue, 21 Aug 2001 22:10:14 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: multiply NULL pointer
In-Reply-To: <Pine.LNX.4.10.10108122305360.7374-100000@coffee.psychology.mcmaster.ca>
Content-Type: multipart/mixed;
 boundary="------------263CE8B85103865CAACD67D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------263CE8B85103865CAACD67D2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



It has possibly been overheating.

Although I think an anormal temperature was first

reached some later days.

The oops was produced with about 65 degress celsius

cpu temperature.

I attached dmesg & ksymoops.

Nico

ps.: where the h!!! is the sign for degree on a us keyboard ?

Mark Hahn wrote:

> > pointers were produced. I attached the whole dmesg output.
>
> not useful, since none of the oopses are decoded.
> do you have any reason to believe this isn't just the usual
> kind of hardware error (overheating cpu, bad ram, etc)?

--------------263CE8B85103865CAACD67D2
Content-Type: text/plain; charset=us-ascii;
 name="ksymoops-nullpointer"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops-nullpointer"

ksymoops 0.7c on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_cast_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_copy_to_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_object) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_reference_list) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_simple_integer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_extract_package_data) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_context) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_info) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_node) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_osl_generate_event) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_proc_root) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_register_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_search) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_set_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_unregister_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol __module_author  , aha152x says d2995247, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997907.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , aha152x says d2995260, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997920.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x  , aha152x says d29954cc, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b8c.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x1  , aha152x says d2995512, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997bd2.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_delay  , aha152x says d2995449, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b09.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x  , aha152x says d29954e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ba0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x1  , aha152x says d2995540, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997c00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_delay  , aha152x says d2995460, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b20.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_exttrans  , aha152x says d29954a0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b60.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_io  , aha152x says d29952c0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997980.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_irq  , aha152x says d2995300, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979c0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_parity  , aha152x says d29953e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997aa0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_reconnect  , aha152x says d2995380, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a40.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_scsiid  , aha152x says d2995340, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_sync  , aha152x says d2995420, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ae0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_exttrans  , aha152x says d2995481, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b41.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_io  , aha152x says d2995297, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997957.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , aha152x says d29952eb, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979ab.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_parity  , aha152x says d29953b0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a70.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_reconnect  , aha152x says d2995367, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a27.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_scsiid  , aha152x says d2995327, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979e7.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_sync  , aha152x says d2995401, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ac1.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_author  , 3c59x says d2984960, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ac0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , 3c59x says d29849a0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_device_id  , 3c59x says d2984ab4, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c14.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_ioaddr  , 3c59x says d2984a8d, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bed.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_irq  , 3c59x says d2984aa2, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c02.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , 3c59x says d29849ea, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b4a.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_device_id  , 3c59x says d2984e60, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985fc0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_ioaddr  , 3c59x says d2984da0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_irq  , 3c59x says d2984e00, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f60.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_debug  , 3c59x says d2984ae0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_enable_wol  , 3c59x says d2984c80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985de0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_flow_ctrl  , 3c59x says d2984c20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_full_duplex  , 3c59x says d2984b80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ce0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_hw_checksums  , 3c59x says d2984bc0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d20.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_max_interrupt_work  , 3c59x says d2984d40, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ea0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_options  , 3c59x says d2984b20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_rx_copybreak  , 3c59x says d2984ce0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985e40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_watchdog  , 3c59x says d2984ec0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2986020.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_enable_wol  , 3c59x says d2984a4a, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985baa.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_flow_ctrl  , 3c59x says d2984a36, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b96.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_full_duplex  , 3c59x says d2984a09, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b69.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_hw_checksums  , 3c59x says d2984a1f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b7f.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_max_interrupt_work  , 3c59x says d2984a73, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bd3.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_options  , 3c59x says d29849f7, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b57.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_rx_copybreak  , 3c59x says d2984a5f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bbf.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_watchdog  , 3c59x says d2984acc, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c2c.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000024
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: cce1ff00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15de000   esp: c15dffa4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 00003607 00000000 c0131d87 cd58b4c0 
       c15de000 c0244877 c15de23b 0008e000 cd58b4c0 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e3e>] [<c01320a5>] [<c0105454>] 
Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 

>>EIP; c012f5e6 <__remove_from_lru_list+1e/68>   <=====
Trace; c01300d5 <__refile_buffer+45/70>
Trace; c0131d87 <flush_dirty_buffers+4b/b8>
Trace; c0131e3e <sync_old_buffers+16/3c>
Trace; c01320a5 <kupdate+d5/d8>
Trace; c0105454 <kernel_thread+28/38>
Code;  c012f5e6 <__remove_from_lru_list+1e/68>
00000000 <_EIP>:
Code;  c012f5e6 <__remove_from_lru_list+1e/68>   <=====
   0:   89 42 24                  mov    %eax,0x24(%edx)   <=====
Code;  c012f5e9 <__remove_from_lru_list+21/68>
   3:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c012f5ed <__remove_from_lru_list+25/68>
   7:   c1 e0 02                  shl    $0x2,%eax
Code;  c012f5f0 <__remove_from_lru_list+28/68>
   a:   bb 0c 6c 2e c0            mov    $0xc02e6c0c,%ebx
Code;  c012f5f5 <__remove_from_lru_list+2d/68>
   f:   89 c2                     mov    %eax,%edx
Code;  c012f5f7 <__remove_from_lru_list+2f/68>
  11:   39 0c 1a                  cmp    %ecx,(%edx,%ebx,1)

Unable to handle kernel NULL pointer dereference at virtual address 00000024
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: caf7ef00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15e0000   esp: c15e1fa8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 0000422b 00000000 c0131d87 cd58b4c0 
       c15e0000 c024486e c15e023a 0008e000 cd58b4c0 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131f95>] [<c0105454>] 
Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 

>>EIP; c012f5e6 <__remove_from_lru_list+1e/68>   <=====
Trace; c01300d5 <__refile_buffer+45/70>
Trace; c0131d87 <flush_dirty_buffers+4b/b8>
Trace; c0131f95 <bdflush+6d/a8>
Trace; c0105454 <kernel_thread+28/38>
Code;  c012f5e6 <__remove_from_lru_list+1e/68>
00000000 <_EIP>:
Code;  c012f5e6 <__remove_from_lru_list+1e/68>   <=====
   0:   89 42 24                  mov    %eax,0x24(%edx)   <=====
Code;  c012f5e9 <__remove_from_lru_list+21/68>
   3:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c012f5ed <__remove_from_lru_list+25/68>
   7:   c1 e0 02                  shl    $0x2,%eax
Code;  c012f5f0 <__remove_from_lru_list+28/68>
   a:   bb 0c 6c 2e c0            mov    $0xc02e6c0c,%ebx
Code;  c012f5f5 <__remove_from_lru_list+2d/68>
   f:   89 c2                     mov    %eax,%edx
Code;  c012f5f7 <__remove_from_lru_list+2f/68>
  11:   39 0c 1a                  cmp    %ecx,(%edx,%ebx,1)

Unable to handle kernel NULL pointer dereference at virtual address 00000024
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010282
eax: cc574e40   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: cf532000   esp: cf533e80
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 225, stackpage=cf533000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 000084ae 00000000 c0131d87 cd58b4c0 
       cc574e40 00001000 00000001 00000000 cd58b4c0 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 c3205260 00013000 00000000 cc574e40 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] 
       [<c0169a20>] [<c0123a60>] [<c012e4cb>] [<c0106ae7>] 
Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 

>>EIP; c012f5e6 <__remove_from_lru_list+1e/68>   <=====
Trace; c01300d5 <__refile_buffer+45/70>
Trace; c0131d87 <flush_dirty_buffers+4b/b8>
Trace; c0131e22 <wakeup_bdflush+2e/34>
Trace; c0130014 <balance_dirty+18/1c>
Trace; c0130c9d <__block_commit_write+b1/d0>
Trace; c01311e0 <generic_commit_write+34/60>
Trace; c016c496 <reiserfs_commit_write+32/a8>
Trace; c0169a20 <reiserfs_get_block+0/cf4>
Trace; c0123a60 <generic_file_write+428/558>
Trace; c012e4cb <sys_write+8f/c4>
Trace; c0106ae7 <system_call+33/38>
Code;  c012f5e6 <__remove_from_lru_list+1e/68>
00000000 <_EIP>:
Code;  c012f5e6 <__remove_from_lru_list+1e/68>   <=====
   0:   89 42 24                  mov    %eax,0x24(%edx)   <=====
Code;  c012f5e9 <__remove_from_lru_list+21/68>
   3:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c012f5ed <__remove_from_lru_list+25/68>
   7:   c1 e0 02                  shl    $0x2,%eax
Code;  c012f5f0 <__remove_from_lru_list+28/68>
   a:   bb 0c 6c 2e c0            mov    $0xc02e6c0c,%ebx
Code;  c012f5f5 <__remove_from_lru_list+2d/68>
   f:   89 c2                     mov    %eax,%edx
Code;  c012f5f7 <__remove_from_lru_list+2f/68>
  11:   39 0c 1a                  cmp    %ecx,(%edx,%ebx,1)


68 warnings issued.  Results may not be reliable.


--------------263CE8B85103865CAACD67D2
Content-Type: text/plain; charset=us-ascii;
 name="ksymoops-nullpointer.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops-nullpointer.2"

ksymoops 0.7c on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_cast_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_copy_to_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_object) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_reference_list) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_simple_integer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_extract_package_data) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_context) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_info) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_node) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_osl_generate_event) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_proc_root) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_register_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_search) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_set_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_unregister_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol __module_author  , aha152x says d2995247, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997907.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , aha152x says d2995260, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997920.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x  , aha152x says d29954cc, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b8c.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_aha152x1  , aha152x says d2995512, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997bd2.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_delay  , aha152x says d2995449, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b09.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x  , aha152x says d29954e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ba0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_aha152x1  , aha152x says d2995540, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997c00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_delay  , aha152x says d2995460, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b20.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_exttrans  , aha152x says d29954a0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b60.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_io  , aha152x says d29952c0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997980.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_irq  , aha152x says d2995300, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979c0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_parity  , aha152x says d29953e0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997aa0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_reconnect  , aha152x says d2995380, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a40.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_scsiid  , aha152x says d2995340, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a00.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_sync  , aha152x says d2995420, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ae0.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_exttrans  , aha152x says d2995481, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997b41.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_io  , aha152x says d2995297, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997957.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_irq  , aha152x says d29952eb, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979ab.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_parity  , aha152x says d29953b0, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a70.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_reconnect  , aha152x says d2995367, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997a27.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_scsiid  , aha152x says d2995327, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d29979e7.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_sync  , aha152x says d2995401, /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o says d2997ac1.  Ignoring /lib/modules/2.4.7/kernel/drivers/scsi/aha152x.o entry
Warning (compare_maps): mismatch on symbol __module_author  , 3c59x says d2984960, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ac0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_description  , 3c59x says d29849a0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_device_id  , 3c59x says d2984ab4, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c14.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_ioaddr  , 3c59x says d2984a8d, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bed.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_compaq_irq  , 3c59x says d2984aa2, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c02.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_debug  , 3c59x says d29849ea, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b4a.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_device_id  , 3c59x says d2984e60, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985fc0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_ioaddr  , 3c59x says d2984da0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f00.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_compaq_irq  , 3c59x says d2984e00, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985f60.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_debug  , 3c59x says d2984ae0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_enable_wol  , 3c59x says d2984c80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985de0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_flow_ctrl  , 3c59x says d2984c20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_full_duplex  , 3c59x says d2984b80, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ce0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_hw_checksums  , 3c59x says d2984bc0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985d20.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_max_interrupt_work  , 3c59x says d2984d40, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985ea0.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_options  , 3c59x says d2984b20, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c80.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_rx_copybreak  , 3c59x says d2984ce0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985e40.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_desc_watchdog  , 3c59x says d2984ec0, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2986020.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_enable_wol  , 3c59x says d2984a4a, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985baa.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_flow_ctrl  , 3c59x says d2984a36, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b96.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_full_duplex  , 3c59x says d2984a09, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b69.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_hw_checksums  , 3c59x says d2984a1f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b7f.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_max_interrupt_work  , 3c59x says d2984a73, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bd3.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_options  , 3c59x says d29849f7, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985b57.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_rx_copybreak  , 3c59x says d2984a5f, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985bbf.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Warning (compare_maps): mismatch on symbol __module_parm_watchdog  , 3c59x says d2984acc, /lib/modules/2.4.7/kernel/drivers/net/3c59x.o says d2985c2c.  Ignoring /lib/modules/2.4.7/kernel/drivers/net/3c59x.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000020
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 
Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 

>>EIP; c0131d76 <flush_dirty_buffers+3a/b8>   <=====
Trace; c0131e3e <sync_old_buffers+16/3c>
Trace; c01320a5 <kupdate+d5/d8>
Trace; c0105454 <kernel_thread+28/38>
Code;  c0131d76 <flush_dirty_buffers+3a/b8>
00000000 <_EIP>:
Code;  c0131d76 <flush_dirty_buffers+3a/b8>   <=====
   0:   8b 70 20                  mov    0x20(%eax),%esi   <=====
Code;  c0131d79 <flush_dirty_buffers+3d/b8>
   3:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c0131d7c <flush_dirty_buffers+40/b8>
   6:   f6 c2 02                  test   $0x2,%dl
Code;  c0131d7f <flush_dirty_buffers+43/b8>
   9:   75 0f                     jne    1a <_EIP+0x1a> c0131d90 <flush_dirty_buffers+54/b8>
Code;  c0131d81 <flush_dirty_buffers+45/b8>
   b:   51                        push   %ecx
Code;  c0131d82 <flush_dirty_buffers+46/b8>
   c:   e8 09 e3 ff ff            call   ffffe31a <_EIP+0xffffe31a> c0130090 <__refile_buffer+0/70>
Code;  c0131d87 <flush_dirty_buffers+4b/b8>
  11:   83 c4 04                  add    $0x4,%esp

Unable to handle kernel NULL pointer dereference at virtual address 00000020
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 
Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 

>>EIP; c0131d76 <flush_dirty_buffers+3a/b8>   <=====
Trace; c0131f95 <bdflush+6d/a8>
Trace; c0105454 <kernel_thread+28/38>
Code;  c0131d76 <flush_dirty_buffers+3a/b8>
00000000 <_EIP>:
Code;  c0131d76 <flush_dirty_buffers+3a/b8>   <=====
   0:   8b 70 20                  mov    0x20(%eax),%esi   <=====
Code;  c0131d79 <flush_dirty_buffers+3d/b8>
   3:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c0131d7c <flush_dirty_buffers+40/b8>
   6:   f6 c2 02                  test   $0x2,%dl
Code;  c0131d7f <flush_dirty_buffers+43/b8>
   9:   75 0f                     jne    1a <_EIP+0x1a> c0131d90 <flush_dirty_buffers+54/b8>
Code;  c0131d81 <flush_dirty_buffers+45/b8>
   b:   51                        push   %ecx
Code;  c0131d82 <flush_dirty_buffers+46/b8>
   c:   e8 09 e3 ff ff            call   ffffe31a <_EIP+0xffffe31a> c0130090 <__refile_buffer+0/70>
Code;  c0131d87 <flush_dirty_buffers+4b/b8>
  11:   83 c4 04                  add    $0x4,%esp

Unable to handle kernel NULL pointer dereference at virtual address 00000020
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00008373   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: cc21e000   esp: cc21fea0
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 450, stackpage=cc21f000)
Stack: c69a7da0 00001000 00000001 00000000 00000000 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 cb9bb7e0 003b7000 00000000 c69a7da0 
       00001000 c01311e0 cb9bb7e0 c117c29c 00000000 00001000 00001000 c117c29c 
Call Trace: [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] [<c0169a20>] [<c0123a60>] 
       [<c012e4cb>] [<c0106ae7>] 
Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 

>>EIP; c0131d76 <flush_dirty_buffers+3a/b8>   <=====
Trace; c0131e22 <wakeup_bdflush+2e/34>
Trace; c0130014 <balance_dirty+18/1c>
Trace; c0130c9d <__block_commit_write+b1/d0>
Trace; c01311e0 <generic_commit_write+34/60>
Trace; c016c496 <reiserfs_commit_write+32/a8>
Trace; c0169a20 <reiserfs_get_block+0/cf4>
Trace; c0123a60 <generic_file_write+428/558>
Trace; c012e4cb <sys_write+8f/c4>
Trace; c0106ae7 <system_call+33/38>
Code;  c0131d76 <flush_dirty_buffers+3a/b8>
00000000 <_EIP>:
Code;  c0131d76 <flush_dirty_buffers+3a/b8>   <=====
   0:   8b 70 20                  mov    0x20(%eax),%esi   <=====
Code;  c0131d79 <flush_dirty_buffers+3d/b8>
   3:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c0131d7c <flush_dirty_buffers+40/b8>
   6:   f6 c2 02                  test   $0x2,%dl
Code;  c0131d7f <flush_dirty_buffers+43/b8>
   9:   75 0f                     jne    1a <_EIP+0x1a> c0131d90 <flush_dirty_buffers+54/b8>
Code;  c0131d81 <flush_dirty_buffers+45/b8>
   b:   51                        push   %ecx
Code;  c0131d82 <flush_dirty_buffers+46/b8>
   c:   e8 09 e3 ff ff            call   ffffe31a <_EIP+0xffffe31a> c0130090 <__refile_buffer+0/70>
Code;  c0131d87 <flush_dirty_buffers+4b/b8>
  11:   83 c4 04                  add    $0x4,%esp

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c8dcdef4   esp: c8dcded8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 505, stackpage=c8dcd000)
Stack: cb6753a0 cb6753e8 000106e7 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 0000fda0 40092d30 
       00000000 c8dcc000 00000004 c0110034 bffff88c cc7f5009 ced60c7c c8dcc000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 511, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f1 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ca0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 512, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000011e0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 513, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ba0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 514, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001a60 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)

Unable to handle kernel paging request at virtual address fffffffc
*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 515, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000018a0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 

>>EIP; c0110d93 <__wake_up+33/a8>   <=====
Trace; c012f241 <write_unlocked_buffers+c9/fc>
Trace; c0110034 <do_page_fault+0/45c>
Trace; c0138c4a <open_namei+86/5ac>
Trace; c01264e8 <kmem_cache_free+210/2a0>
Trace; c012f2fc <sync_buffers+14/44>
Trace; c012f3ae <fsync_dev+e/38>
Trace; c012f3ef <sys_sync+7/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c0110d93 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c0110d93 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c0110d96 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c0110d98 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c0110d9a <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0110d9d <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c0110df0 <__wake_up+90/a8>
Code;  c0110d9f <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c0110da1 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c0110da2 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c0110da3 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c0110da4 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)


68 warnings issued.  Results may not be reliable.


--------------263CE8B85103865CAACD67D2
Content-Type: text/plain; charset=us-ascii;
 name="DMESG5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DMESG5"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.322 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 23 transactions in 9 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 23 transactions in 4 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
nmap uses obsolete (PF_INET,SOCK_PACKET)
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00002f8f   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15de000   esp: c15dffc4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: c15de000 c0244877 c15de23b 0008e000 00000000 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00004216   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: c15e0000   esp: c15e1fc8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: c15e0000 c024486e c15e023a 0008e000 00000000 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c0131f95>] [<c0105454>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0131d76
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0131d76>]
EFLAGS: 00010206
eax: 00000000   ebx: 00008373   ecx: 00000000   edx: 00000002
esi: 00000000   edi: 00000000   ebp: cc21e000   esp: cc21fea0
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 450, stackpage=cc21f000)
Stack: c69a7da0 00001000 00000001 00000000 00000000 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 cb9bb7e0 003b7000 00000000 c69a7da0 
       00001000 c01311e0 cb9bb7e0 c117c29c 00000000 00001000 00001000 c117c29c 
Call Trace: [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] [<c0169a20>] [<c0123a60>] 
       [<c012e4cb>] [<c0106ae7>] 

Code: 8b 70 20 8b 50 18 f6 c2 02 75 0f 51 e8 09 e3 ff ff 83 c4 04 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c8dcdef4   esp: c8dcded8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 505, stackpage=c8dcd000)
Stack: cb6753a0 cb6753e8 000106e7 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 0000fda0 40092d30 
       00000000 c8dcc000 00000004 c0110034 bffff88c cc7f5009 ced60c7c c8dcc000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 511, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f1 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ca0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 512, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000011e0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 513, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001ba0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 514, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106f3 cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 00001a60 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0110d93
*pde = 00001063
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0110d93>]
EFLAGS: 00010017
eax: cb6753e8   ebx: 00000000   ecx: 00000001   edx: cb6753ec
esi: cb6753e8   edi: fffffff8   ebp: c7059ef4   esp: c7059ed8
ds: 0018   es: 0018   ss: 0018
Process sync (pid: 515, stackpage=c7059000)
Stack: cb6753a0 cb6753e8 000106ed cb6753ec 00000001 00000286 00000003 00000000 
       c012f241 00000000 00000000 00000000 bffff8bc 00000000 000018a0 40092d30 
       00000000 c7058000 00000004 c0110034 bffff88c cc7f5009 ced60d1c c7058000 
Call Trace: [<c012f241>] [<c0110034>] [<c0138c4a>] [<c01264e8>] [<c012f2fc>] [<c012f3ae>] [<c012f3ef>] 
       [<c0106ae7>] 

Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00 


--------------263CE8B85103865CAACD67D2
Content-Type: text/plain; charset=us-ascii;
 name="NULLPOINTER"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="NULLPOINTER"

Linux version 2.4.7 (root@eiche) (gcc version 2.95.2 19991024 (release)) #4 Tue Oct 2 16:55:42 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=new ro root=801 vga=0x0301 nmi_watchdog=1
Initializing CPU#0
Detected 399.323 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 796.26 BogoMIPS
Memory: 255276k/262144k available (1254k kernel code, 6484k reserved, 434k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 03
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfacd0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: APM is already active, exiting
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV3 framebuffer ver 0.9.2a (RIVA-128, 8MB @ 0xE6000000)
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169493kB/56497kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG SV3064D, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 59794560 sectors (30615 MB) w/434KiB Cache, CHS=3722/255/63
hdc: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 10 for device 00:0c.0
PCI: Sharing IRQ 10 with 00:08.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
  Vendor: HP        Model: HP35480A          Rev: T503
  Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:4): 5.000MB/s transfers (5.000MHz, offset 8)
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 205816k swap-space (priority -1)
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,1), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on sd(8,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.5, 30 Jul 2001 on ide0(3,2), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
PCI: Found IRQ 10 for device 00:08.0
PCI: Sharing IRQ 10 with 00:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:08.0: 3Com PCI 3c905 Boomerang 100baseTx at 0xa400,  00:60:08:50:b3:45, IRQ 10
  product code 4b4b rev 00.0 date 08-12-97
  8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
  MII transceiver found at address 24, status 786f.
  Enabling bus-master transmits and whole-frame receives.
00:08.0: scatter/gather enabled. h/w checksums disabled
eth0: first available media type: MII
i2c-core.o: i2c core module
piix4.o version 2.5.5 (20010115)
i2c-core.o: adapter SMBus PIIX4 adapter at 5000 registered as adapter 0.
i2c-piix4.o: PIIX4 bus detected and initialized
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus PIIX4 adapter at 5000' as minor 0
i2c-isa.o version 2.5.5 (20010115)
i2c-dev.o: Registered 'ISA main adapter' as minor 1
i2c-core.o: adapter ISA main adapter registered as adapter 1.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-core.o: I2C adapter 40000: I2C level transfers not supported
i2c-core.o: I2C adapter 50000: I2C level transfers not supported
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: cce1ff00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15de000   esp: c15dffa4
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 8, stackpage=c15df000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 00003607 00000000 c0131d87 cd58b4c0 
       c15de000 c0244877 c15de23b 0008e000 cd58b4c0 c0131e3e 00000001 c01320a5 
       00010f00 c15f7fb0 c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e3e>] [<c01320a5>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010286
eax: caf7ef00   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: c15e0000   esp: c15e1fa8
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 7, stackpage=c15e1000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 0000422b 00000000 c0131d87 cd58b4c0 
       c15e0000 c024486e c15e023a 0008e000 cd58b4c0 c0131f95 00000000 00010f00 
       c15f7fbc c02b9170 c0105454 c02b9170 00000078 c02a9fd4 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131f95>] [<c0105454>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 
Unable to handle kernel NULL pointer dereference at virtual address 00000024
 printing eip:
c012f5e6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012f5e6>]
EFLAGS: 00010282
eax: cc574e40   ebx: 00000003   ecx: cd58b4c0   edx: 00000000
esi: cd58b4c0   edi: 00000000   ebp: cf532000   esp: cf533e80
ds: 0018   es: 0018   ss: 0018
Process rpc.nfsd (pid: 225, stackpage=cf533000)
Stack: 00000003 c01300d5 cd58b4c0 00000000 000084ae 00000000 c0131d87 cd58b4c0 
       cc574e40 00001000 00000001 00000000 cd58b4c0 c0131e22 00000000 c0130014 
       00000001 c0130c9d 00000301 00001000 c3205260 00013000 00000000 cc574e40 
Call Trace: [<c01300d5>] [<c0131d87>] [<c0131e22>] [<c0130014>] [<c0130c9d>] [<c01311e0>] [<c016c496>] 
       [<c0169a20>] [<c0123a60>] [<c012e4cb>] [<c0106ae7>] 

Code: 89 42 24 8b 44 24 0c c1 e0 02 bb 0c 6c 2e c0 89 c2 39 0c 1a 


--------------263CE8B85103865CAACD67D2--

