Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132020AbQLPPYX>; Sat, 16 Dec 2000 10:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132048AbQLPPYO>; Sat, 16 Dec 2000 10:24:14 -0500
Received: from c252.h203149202.is.net.tw ([203.149.202.252]:58264 "EHLO
	mail.tahsda.org.tw") by vger.kernel.org with ESMTP
	id <S132020AbQLPPYD>; Sat, 16 Dec 2000 10:24:03 -0500
Message-ID: <3A3B81C4.4670ECEA@teatime.com.tw>
Date: Sat, 16 Dec 2000 22:52:52 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: bug: kernel timer added twice ad 000000000110052c.
In-Reply-To: <3A3A0D9A.426A2FB0@teatime.com.tw> <20001215163747.F829@nightmaster.csn.tu-chemnitz.de> <3A3A3472.33349B51@teatime.com.tw> <3A3AAE0B.77DD7492@uow.edu.au> <3A3B3654.6882D5A5@teatime.com.tw> <3A3B3E81.25FEE5B9@uow.edu.au> <3A3B6133.9CA2A0EF@teatime.com.tw> <3A3B6354.36FDB3DB@uow.edu.au>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton ¼g¹D:
> 
> > >         ksymoops -m /usr/src/linux/System.map < oops.txt
> > > Did you do that?

  I just done for this.

  There is no any log file contain such message.... After I run 'modprobe ip_conntrack',
  the kernel only show message to console, no any log... and system halt.
  I try to write down the console message and run ksymoops....

  Here is my result:

ksymoops 2.3.5 on sparc64 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /usr/src/linux/System.map (specified)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(kernel_scsi_ioctl) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_Scsi_Cmnd) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_command) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_msg) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_req_sense) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_sense) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(print_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(proc_print_scsidevice) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(proc_scsi) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_allocate_device) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_allocate_request) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_block_requests) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_block_when_processing_errors) not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_command_size) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_deregister_blocked_host) not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_device_types) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_devicelist) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_dma_free_sectors) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_do_cmd) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_do_req) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_end_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_free) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_free_host_dev) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_get_host_dev) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_hostlist) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_hosts) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_io_completion) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_ioctl) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_ioctl_send_command) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_logging_level) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_malloc) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_mark_host_reset) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_need_isa_buffer) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_partsize) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_register) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_register_blocked_host) not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_register_module) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_release_command) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_release_request) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_report_bus_reset) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_sleep) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_unblock_requests) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_unregister) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_unregister_module) not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsi_wait_req) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(scsicam_bios_param) not found in System.map.  Ignoring ksyms_base entry
swapper(0): Kernel bad trap
TSTATE: 0000004480009606 TPC: 000000000044b610 TNPC: 000000000044b614 Y: ee000000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 0000000000000000 g1: 0000000000000001 g2: 0000000000000001 g3: ffffffffffffff9d
g4: fffff80000000000 g5: 0000000000000001 g6: 0000000000414000 g7: 0000000000000001
o0: 0000000000000033 o1: 0000000000616f66 o2: 0000000000000033 o3: 0000000000000001
o4: 0000000000616f33 o5: 0000000000616f66 sp: 0000000000416c11 ret_pc: 000000000044b608
l0: fffff8003222e460 l1: fffff8003df412e0 l2: 000000000000005c l3: 0000000000000060
l4: 000000000069a400 l5: fffff8003fdca060 l6: 0000000000000000 l7: 000000000000000c
i0: fffff8002ce220e8 i1: 00000000000113f3 i2: 000000000067d800 i3: 000000000001083b
i4: fffff8003fe99800 i5: 0000000000000002 i6: 0000000000416cd1 i7: 000000000110052c
Caller[000000000110052c]
Caller[0000000001102ae4]
Caller[0000000000519674]
Caller[0000000000519944]
Caller[000000000052a784]
Caller[000000000052b01c]
Caller[0000000000519990]
Caller[000000000052abe4]
Caller[000000000051ef14]
Caller[0000000000448780]
Caller[000000000040ee80]
Caller[0000000000418228]
Caller[00000000005cca2c]
Caller[0000000000404284]
Caller[0000000000000000]
Instruction DUMP: 90122078  7fffe3fe  9210001f  <91d02005>  81cfe008  01000000  01000000  94100008 97520000

>>PC;  0044b610 <add_timer+130/140>   <=====
>>O7;  0044b608 <add_timer+128/140>
>>I7;  0110052c <.bss.end+3cbd/????>
Trace; 0110052c <.bss.end+3cbd/????>
Trace; 01102ae4 <.bss.end+6275/????>
Trace; 00519674 <nf_iterate+34/c0>
Trace; 00519944 <nf_hook_slow+44/e0>
Trace; 0052a784 <ip_local_deliver+1c4/1e0>
Trace; 0052b01c <ip_rcv_finish+25c/2c0>
Trace; 00519990 <nf_hook_slow+90/e0>
Trace; 0052abe4 <ip_rcv+444/4a0>
Trace; 0051ef14 <net_rx_action+1d4/300>
Trace; 00448780 <do_softirq+80/e0>
Trace; 0040ee80 <__handle_softirq+0/10>
Trace; 00418228 <cpu_idle+28/60>
Trace; 005cca2c <start_kernel+18c/1a0>
Trace; 00404284 <sun4u_init+e0/e8>
Trace; 00000000 Before first symbol
Code;  0044b604 <add_timer+124/140>
0000000000000000 <_PC>:
Code;  0044b604 <add_timer+124/140>
   0:   90 12 20 78       or  %o0, 0x78, %o0
Code;  0044b608 <add_timer+128/140>
   4:   7f ff e3 fe       call  ffffffffffff8ffc <_PC+0xffffffffffff8ffc> 00444600 <printk+0/220>
Code;  0044b60c <add_timer+12c/140>
   8:   92 10 00 1f       mov  %i7, %o1
Code;  0044b610 <add_timer+130/140>   <=====
   c:   91 d0 20 05       ta  5   <=====
Code;  0044b614 <add_timer+134/140>
  10:   81 cf e0 08       rett  %i7 + 8
Code;  0044b618 <add_timer+138/140>
  14:   01 00 00 00       nop 
Code;  0044b61c <add_timer+13c/140>
  18:   01 00 00 00       nop 
Code;  0044b620 <mod_timer+0/140>
  1c:   94 10 00 08       mov  %o0, %o2
Code;  0044b624 <mod_timer+4/140>
  20:   97 52 00 00       unknown

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

46 warnings issued.  Results may not be reliable.


-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 31515964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
