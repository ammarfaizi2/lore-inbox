Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131462AbQJ2Akw>; Sat, 28 Oct 2000 20:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131471AbQJ2Akm>; Sat, 28 Oct 2000 20:40:42 -0400
Received: from montreal.eicon.com ([192.219.17.120]:45323 "EHLO
	mtl_exchange.eicon.com") by vger.kernel.org with ESMTP
	id <S131462AbQJ2Akh>; Sat, 28 Oct 2000 20:40:37 -0400
Message-ID: <D8E12241B029D411A3A300805FE6A2B996C4E7@montreal.eicon.com>
From: Carlo Pagano <carlop@Eicon.com>
To: linux-kernel@vger.kernel.org
Cc: Carlo Pagano <carlop@Eicon.com>, cpagano@total.net
Subject: oops with 2.4.0-test9, testing a module
Date: Sat, 28 Oct 2000 20:42:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1460.8)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

  I am testing out a modem driver module that works fine on 2.2.14 and
2.2.16. On 2.4.0-test9 I can insmod it with no problem.

When I open up minicom to test out some AT commands I get the kernel oops
below right away, and the system hangs.

System info:

Kernel 2.4.0-test9, gcc version egcs-2.91.66 19990314
Pentium III 450, 128 MB RAM
2 IDE Hard drives
Modem is a 56K speakerphone

I rebooted and loaded the module again, then ran ksymoops. I am assuming the
errors and warnings have something to do with the fact that I had to reboot,
but the code looks fine out of ksymoops. If any other info is needed please
ask. 

Here it is:

ksymoops 2.3.4 on i686 2.4.0-test9.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o
(specified)
     -m System.map (specified)

Error (expand_objects): cannot
stat(Sless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o) for hcfspkph
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(__usb_get_extra_descriptor) not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_alloc_bus)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_alloc_dev)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_alloc_urb)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_bulk_msg)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_check_bandwidth) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_claim_bandwidth) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_clear_halt)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_connect)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_control_msg) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_deregister)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_deregister_bus) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_disconnect)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_driver_claim_interface) not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_driver_release_interface) not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_epnum_to_ep_desc) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_free_bus)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_free_dev)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_free_urb)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_class_descriptor) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_configuration) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_current_frame_number) not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_descriptor) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_device_descriptor) not found in vmlinux.
Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_get_protocol) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_get_report)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_get_string)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_ifnum_to_if) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_inc_dev_use) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_interface_claimed) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_new_device)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_register)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_register_bus) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_release_bandwidth) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_reset_device) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_root_hub_string) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_scan_devices) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_set_address) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_set_configuration) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_set_idle)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_set_interface) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(usb_set_protocol) not found in vmlinux.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_set_report)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_string) not
found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_submit_urb)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(usb_unlink_urb)
not found in vmlinux.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol ResetBLSlot__FUc  , hcfspkph says
c8845320,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol
SetRockwellDataPumpBaseAddress__16RockwellDataPumpPv  , hcfspkph says
c884530c,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol
SetRockwellDataPumpBaseAddress__16RockwellDataPumpUl  , hcfspkph says
c88452f8,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol _._8TsGmcAPI  , hcfspkph says
c88452d8,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol _._8TsHalAPI  , hcfspkph says
c88453b0,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol _._9TsDdalAPI  , hcfspkph says
c88452b8,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol _._9TsOsalAPI  , hcfspkph says
c88453d0,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol __vt_8TsGmcAPI  , hcfspkph says
c8855e40,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol __vt_8TsHalAPI  , hcfspkph says
c8855e64,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol __vt_9TsDdalAPI  , hcfspkph says
c8855e10,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Warning (compare_maps): mismatch on symbol __vt_9TsOsalAPI  , hcfspkph says
c8855e80,
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o says
c885f600.  Ignoring
/storage/_TS_OSless/Target/Modem/HCF_SPKPHL74/Linux/Serial/hcfspkph.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0119189
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0119189>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c02a2000   ebx: 00000286   ecx: c88443dc   edx: c886fd24
esi: 00000000   edi: c886fd60   ebp: c02a3f6c   esp: c02a3f54
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a3000)
Stack: c886fd60 c886fd24 c01130f0 c02a2000 c00fdf8c c028bd80 c02a3fd0
c88443eb 
       00000000 c0118da8 c886fd60 c01130f0 c02a2000 c01071d0 c02a3fd0
c88443dc 
       00000018 c02a0018 00000000 c011335a 00000010 c886fd24 c02a2000
c02a2000 
Call Trace: [<c886fd60>] [<c886fd24>] [<c01130f0>] [<c88443eb>] [<c0118da8>]
[<c886fd60>] [<c01130f0>] 
       [<c01071d0>] [<c88443dc>] [<c011335a>] [<c886fd24>] [<c01071d0>]
[<c01071d0>] [<c01238e4>] [<c010727e>] 
       [<c0105000>] [<c01001d0>] 
Code: f0 fe 0e 0f 88 fa d0 10 00 8b 46 04 8d 4d f8 89 48 04 89 45 

>>EIP; c0119189 <interruptible_sleep_on+1d/6c>   <=====
Trace; c886fd60 <[hcfspkph]roundrobin_data+0/1bb>
Trace; c886fd24 <[hcfspkph]roundrobin_task+0/10>
Trace; c01130f0 <acpi_idle+0/27c>
Trace; c88443eb <[hcfspkph]RoundRobin__9OSALLinuxPv+f/88>
Trace; c0118da8 <schedule+63c/6d4>
Trace; c886fd60 <[hcfspkph]roundrobin_data+0/1bb>
Trace; c01130f0 <acpi_idle+0/27c>
Trace; c01071d0 <default_idle+0/38>
Trace; c88443dc <[hcfspkph]RoundRobin__9OSALLinuxPv+0/88>
Trace; c011335a <acpi_idle+26a/27c>
Trace; c886fd24 <[hcfspkph]roundrobin_task+0/10>
Trace; c01071d0 <default_idle+0/38>
Trace; c01071d0 <default_idle+0/38>
Trace; c01238e4 <check_pgt_cache+14/18>
Trace; c010727e <cpu_idle+4e/58>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001d0 <L6+0/2>
Code;  c0119189 <interruptible_sleep_on+1d/6c>
00000000 <_EIP>:
Code;  c0119189 <interruptible_sleep_on+1d/6c>   <=====
   0:   f0 fe 0e                  lock decb (%esi)   <=====
Code;  c011918c <interruptible_sleep_on+20/6c>
   3:   0f 88 fa d0 10 00         js     10d103 <_EIP+0x10d103> c022628c
<stext_lock+87c/92e4>
Code;  c0119192 <interruptible_sleep_on+26/6c>
   9:   8b 46 04                  mov    0x4(%esi),%eax
Code;  c0119195 <interruptible_sleep_on+29/6c>
   c:   8d 4d f8                  lea    0xfffffff8(%ebp),%ecx
Code;  c0119198 <interruptible_sleep_on+2c/6c>
   f:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c011919b <interruptible_sleep_on+2f/6c>
  12:   89 45 00                  mov    %eax,0x0(%ebp)

Kernel panic: Attempted to kill the idle task!

57 warnings and 1 error issued.  Results may not be reliable.

Thanks in advance,


Carlo Pagano
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
