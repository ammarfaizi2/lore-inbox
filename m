Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbVLNXlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbVLNXlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVLNXlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:41:09 -0500
Received: from mail.polishnetwork.com ([69.222.0.23]:13069 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S965101AbVLNXlH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:41:07 -0500
Subject: =?ISO-8859-1?Q?Re=3A=20kernel-2=2E6=2E15-rc5-rt2=20-=20compilation=20err?=
 =?ISO-8859-1?Q?or=20=91RWSEM=5FACTIVE=5FBIAS=92=20undeclared?=
Date: Wed, 14 Dec 2005 17:41:38 -0600
Message-Id: <200512141741.AA16122424@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <rostedt@goodmis.org>
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Re: kernel-2.6.15-rc5-rt2 - compilation error ‘RWSEM_ACTIVE_BIAS’ undeclared

now it compiles but Oops & problem with xserver
-------------------------------------------------------------------
messages
....
kernel: check_periodic_interval: Long interval! 205976689.
kernel: 		Something may be blocking interrupts.
.....
fstab-sync[2783]: added mount point /media/floppy for /dev/fd0
fstab-sync[2793]: added mount point /media/cdrecorder1 for /dev/hdc
init: open(/dev/pts/0): No such file or directory
init: open(/dev/pts/0): No such file or directory
kernel: BUG: Unable to handle kernel paging request at virtual address ffff69f0
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00002067
kernel: *pte = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f4b74000   ebx: ffff69d0   ecx: f41de5f0   edx: f41de5f0
13  gdm[3075]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel: esi: 00000000   edi: f4b74000   ebp: 00000101   esp: f4a78ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3087, threadinfo=f4a78000 task=f41de000 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f4a78f50 f4b74000 f4b74000 c016b8d6 c032d19b 00000060 f4320c78 
14  05  fstab-sync[2783]: added mount point /media/floppy for /dev/fd0
07  fstab-sync[2793]: added mount point /media/cdrecorder1 for /dev/hdc
35  init: open(/dev/pts/0): No such file or directory
35  init: open(/dev/pts/0): No such file or directory
kernel: BUG: Unable to handle kernel paging request at virtual address ffff69f0
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00002067
kernel: *pte = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f4b74000   ebx: ffff69d0   ecx: f41de5f0   edx: f41de5f0
13  gdm[3075]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel: esi: 00000000   edi: f4b74000   ebp: 00000101   esp: f4a78ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3087, threadinfo=f4a78000 task=f41de000 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f4a78f50 f4b74000 f4b74000 c016b8d6 c032d19b 00000060 f4320c78 
kernel:        00000101 f4a78f50 00000101 ffffffe9 f4b74000 c016b915 00000003 f4a78f50 
kernel:        00000004 f4a78f50 c016b962 00000003 00000000 f4b74000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
gdm[3108]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel:  <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 000000ac
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00000000
kernel: Oops: 0000 [#2]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f685b000   ebx: 0000008c   ecx: f44545f0   edx: f44545f0
kernel: esi: 00000000   edi: f685b000   ebp: 00000101   esp: f6858ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3144, threadinfo=f6858000 task=f4454000 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f6858f50 f685b000 f685b000 c016b8d6 c032d19b 00000060 f463cb70 
kernel:        00000101 f6858f50 00000101 ffffffe9 f685b000 c016b915 00000003 f6858f50 
kernel:        00000004 f6858f50 c016b962 00000003 00000000 f685b000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
gdm[3201]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel:  <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 000000ac
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00000000
kernel: Oops: 0000 [#3]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f3327000   ebx: 0000008c   ecx: f4463530   edx: f4463530
kernel: esi: 00000000   edi: f3327000   ebp: 00000101   esp: f4605ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3224, threadinfo=f4605000 task=f4462c00 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f4605f50 f3327000 f3327000 c016b8d6 c032d19b 00000060 f4424800 
kernel:        00000101 f4605f50 00000101 ffffffe9 f3327000 c016b915 00000003 f4605f50 
kernel:        00000004 f4605f50 c016b962 00000003 00000000 f3327000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
gdm[3049]: deal_with_x_crashes: Running the XKeepsCrashing script
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
syslogd 1.4.1: restart.
kernel:        00000101 f4a78f50 00000101 ffffffe9 f4b74000 c016b915 00000003 f4a78f50 
kernel:        00000004 f4a78f50 c016b962 00000003 00000000 f4b74000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
gdm[3108]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel:  <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 000000ac
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00000000
kernel: Oops: 0000 [#2]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f685b000   ebx: 0000008c   ecx: f44545f0   edx: f44545f0
kernel: esi: 00000000   edi: f685b000   ebp: 00000101   esp: f6858ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3144, threadinfo=f6858000 task=f4454000 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f6858f50 f685b000 f685b000 c016b8d6 c032d19b 00000060 f463cb70 
kernel:        00000101 f6858f50 00000101 ffffffe9 f685b000 c016b915 00000003 f6858f50 
kernel:        00000004 f6858f50 c016b962 00000003 00000000 f685b000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
gdm[3201]: gdm_slave_xioerror_handler: Fatal X error - Restarting :0
kernel:  <1>BUG: Unable to handle kernel NULL pointer dereference at virtual address 000000ac
kernel:  printing eip:
kernel: c013fee7
kernel: *pde = 00000000
kernel: Oops: 0000 [#3]
kernel: PREEMPT 
kernel: Modules linked in: parport_pc lp parport autofs4 sunrpc ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables video button battery ac ipv6 ohci1394 ieee1394 sr_mod uhci_hcd usb_storage ohci_hcd ehci_hcd shpchp hw_random i2c_i801 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc e100 mii floppy dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod
kernel: CPU:    0
kernel: EIP:    0060:[<c013fee7>]    Not tainted VLI
kernel: EFLAGS: 00013286   (2.6.15-rc5-rt2) 
kernel: EIP is at audit_inode+0x79/0xae
kernel: eax: f3327000   ebx: 0000008c   ecx: f4463530   edx: f4463530
kernel: esi: 00000000   edi: f3327000   ebp: 00000101   esp: f4605ea4
kernel: ds: 007b   es: 007b   ss: 0068   preempt: 00000001
kernel: Process X (pid: 3224, threadinfo=f4605000 task=f4462c00 stack_left=3696 worst_left=-1)
kernel: Stack: fffffffe f4605f50 f3327000 f3327000 c016b8d6 c032d19b 00000060 f4424800 
kernel:        00000101 f4605f50 00000101 ffffffe9 f3327000 c016b915 00000003 f4605f50 
kernel:        00000004 f4605f50 c016b962 00000003 00000000 f3327000 c016bfe8 00000003 
kernel: Call Trace:
kernel:  [<c016b8d6>] path_lookup+0x1da/0x1df (20)
kernel:  [<c016b915>] __path_lookup_intent_open+0x3a/0x6f (36)
kernel:  [<c016b962>] path_lookup_open+0x18/0x1d (20)
kernel:  [<c016bfe8>] open_namei+0x70/0x622 (16)
kernel:  [<c01467c7>] __alloc_pages+0x53/0x2d2 (32)
kernel:  [<c013ee8f>] audit_filter_syscall+0x39/0xae (8)
kernel:  [<c015ce26>] filp_open+0x1c/0x35 (36)
kernel:  [<c0146a72>] __get_free_pages+0x2c/0x6a (20)
kernel:  [<c015d01c>] get_unused_fd+0xac/0xce (28)
kernel:  [<c015d11e>] do_sys_open+0x31/0xad (36)
kernel:  [<c0102ecd>] syscall_call+0x7/0xb (28)
gdm[3049]: deal_with_x_crashes: Running the XKeepsCrashing script
kernel: Code: 8b 40 3c 85 c0 74 04 39 f8 74 51 83 fa 0c 7f 47 8d 42 01 89 41 38 89 d0 c1 e0 05 c7 44 08 3c 00 00 00 00 c1 e2 05 01 ca 89 6a 58 <8b> 43 20 89 42 40 8b 83 d8 00 00 00 8b 40 08 89 42 44 0f b7 43 
syslogd 1.4.1: restart.


xboom


