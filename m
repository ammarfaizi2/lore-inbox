Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVKSTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVKSTYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVKSTYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:24:42 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:27576 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750771AbVKSTYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:24:42 -0500
Message-ID: <028801c5ed3e$4f3d9b80$0400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk> <437F79B1.9050703@perkel.com>
Subject: USB storage -> Oops (2.6.14.2)
Date: Sat, 19 Nov 2005 20:20:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I have pugged in two USB storage.

1. WD 200GB
Nov 19 19:23:57 192.168.2.50 SCSI device sda: 268435455 512-byte hdwr
sectors (137439 MB)
(128GB???)

2. Maxtor 40GB
Nov 19 19:24:02 192.168.2.50 SCSI device sdb: 80293248 512-byte hdwr sectors
(41110 MB)


The full log is here:
(Syslog+netconsole)

Nov 19 19:23:51 192.168.2.50 kernel: usb 1-3: new high speed USB device
using ehci_hcd and address 2
Nov 19 19:23:51 192.168.2.50 kernel: scsi0 : SCSI emulation for USB Mass
Storage devices
Nov 19 19:23:56 192.168.2.50   Vendor:
Nov 19 19:23:56 192.168.2.50 U
Nov 19 19:23:56 192.168.2.50 S
Nov 19 19:23:56 192.168.2.50 B
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50 2
Nov 19 19:23:56 192.168.2.50 .
Nov 19 19:23:56 192.168.2.50 0
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50   Model:
Nov 19 19:23:56 192.168.2.50 S
Nov 19 19:23:56 192.168.2.50 t
Nov 19 19:23:56 192.168.2.50 o
Nov 19 19:23:56 192.168.2.50 r
Nov 19 19:23:56 192.168.2.50 a
Nov 19 19:23:56 192.168.2.50 g
Nov 19 19:23:56 192.168.2.50 e
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50 D
Nov 19 19:23:56 192.168.2.50 e
Nov 19 19:23:56 192.168.2.50 v
Nov 19 19:23:56 192.168.2.50 i
Nov 19 19:23:56 192.168.2.50 c
Nov 19 19:23:56 192.168.2.50 e
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50   Rev:
Nov 19 19:23:56 192.168.2.50 0
Nov 19 19:23:56 192.168.2.50 1
Nov 19 19:23:56 192.168.2.50 0
Nov 19 19:23:56 192.168.2.50 0
Nov 19 19:23:56 192.168.2.50
Nov 19 19:23:56 192.168.2.50   Type:   Direct-Access
Nov 19 19:23:57 192.168.2.50                  ANSI SCSI revision: 00
Nov 19 19:23:57 192.168.2.50
Nov 19 19:23:57 192.168.2.50 kernel:   Vendor: USB 2.0   Model: Storage
Device    Rev: 0100
Nov 19 19:23:57 192.168.2.50 kernel:   Type:   Direct-Access
ANSI SCSI revision: 00
Nov 19 19:23:57 192.168.2.50 SCSI device sda: 268435455 512-byte hdwr
sectors (137439 MB)
Nov 19 19:23:57 192.168.2.50 sda: assuming drive cache: write through
Nov 19 19:23:57 192.168.2.50 kernel: SCSI device sda: 268435455 512-byte
hdwr sectors (137439 MB)
Nov 19 19:23:57 192.168.2.50 kernel: sda: assuming drive cache: write
through
Nov 19 19:23:57 192.168.2.50 SCSI device sda: 268435455 512-byte hdwr
sectors (137439 MB)
Nov 19 19:23:57 192.168.2.50 sda: assuming drive cache: write through
Nov 19 19:23:57 192.168.2.50 kernel: SCSI device sda: 268435455 512-byte
hdwr sectors (137439 MB)
Nov 19 19:23:57 192.168.2.50 kernel: sda: assuming drive cache: write
through
Nov 19 19:23:57 192.168.2.50 kernel:  sda: sda1 sda2
Nov 19 19:23:57 192.168.2.50 Attached scsi disk sda at scsi0, channel 0, id
0, lun 0
Nov 19 19:23:57 192.168.2.50 kernel: Attached scsi disk sda at scsi0,
channel 0, id 0, lun 0
Nov 19 19:23:57 192.168.2.50 Attached scsi generic sg0 at scsi0, channel 0,
id 0, lun 0,  type 0
Nov 19 19:23:57 192.168.2.50 kernel: Attached scsi generic sg0 at scsi0,
channel 0, id 0, lun 0,  type 0
Nov 19 19:23:57 192.168.2.50 kernel: usb 1-1: new high speed USB device
using ehci_hcd and address 3
Nov 19 19:23:57 192.168.2.50 kernel: scsi1 : SCSI emulation for USB Mass
Storage devices
Nov 19 19:24:02 192.168.2.50   Vendor:
Nov 19 19:24:02 192.168.2.50 U
Nov 19 19:24:02 192.168.2.50 S
Nov 19 19:24:02 192.168.2.50 B
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 2
Nov 19 19:24:02 192.168.2.50 .
Nov 19 19:24:02 192.168.2.50 0
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50   Model:
Nov 19 19:24:02 192.168.2.50 S
Nov 19 19:24:02 192.168.2.50 t
Nov 19 19:24:02 192.168.2.50 o
Nov 19 19:24:02 192.168.2.50 r
Nov 19 19:24:02 192.168.2.50 a
Nov 19 19:24:02 192.168.2.50 g
Nov 19 19:24:02 192.168.2.50 e
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 D
Nov 19 19:24:02 192.168.2.50 e
Nov 19 19:24:02 192.168.2.50 v
Nov 19 19:24:02 192.168.2.50 i
Nov 19 19:24:02 192.168.2.50 c
Nov 19 19:24:02 192.168.2.50 e
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50   Rev:
Nov 19 19:24:02 192.168.2.50 0
Nov 19 19:24:02 192.168.2.50 1
Nov 19 19:24:02 192.168.2.50 last message repeated 2 times
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50   Type:   Direct-Access
Nov 19 19:24:02 192.168.2.50                  ANSI SCSI revision: 00
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 SCSI device sdb: 80293248 512-byte hdwr sectors
(41110 MB)
Nov 19 19:24:02 192.168.2.50 sdb: assuming drive cache: write through
Nov 19 19:24:02 192.168.2.50 SCSI device sdb: 80293247 512-byte hdwr sectors
(41110 MB)
Nov 19 19:24:02 192.168.2.50 sdb: assuming drive cache: write through
Nov 19 19:24:02 192.168.2.50 kernel:   Vendor: USB 2.0   Model: Storage
Device    Rev: 0111
Nov 19 19:24:02 192.168.2.50 kernel:   Type:   Direct-Access
ANSI SCSI revision: 00
Nov 19 19:24:02 192.168.2.50 kernel: SCSI device sdb: 80293248 512-byte hdwr
sectors (41110 MB)
Nov 19 19:24:02 192.168.2.50 kernel: sdb: assuming drive cache: write
through
Nov 19 19:24:02 192.168.2.50 kernel: SCSI device sdb: 80293247 512-byte hdwr
sectors (41110 MB)
Nov 19 19:24:02 192.168.2.50 kernel: sdb: assuming drive cache: write
through
Nov 19 19:24:02 192.168.2.50 kernel:  sdb: sdb1
Nov 19 19:24:02 192.168.2.50 Attached scsi disk sdb at scsi1, channel 0, id
0, lun 0
Nov 19 19:24:02 192.168.2.50 kernel: Attached scsi disk sdb at scsi1,
channel 0, id 0, lun 0
Nov 19 19:24:02 192.168.2.50 Attached scsi generic sg1 at scsi1, channel 0,
id 0, lun 0,  type 0
Nov 19 19:24:02 192.168.2.50 kernel: Attached scsi generic sg1 at scsi1,
channel 0, id 0, lun 0,  type 0
Nov 19 19:24:02 192.168.2.50 Unable to handle kernel NULL pointer
dereference
Nov 19 19:24:02 192.168.2.50  at virtual address 00000000
Nov 19 19:24:02 192.168.2.50  printing eip:
Nov 19 19:24:02 192.168.2.50 c03df86c
Nov 19 19:24:02 192.168.2.50 *pde = 006d1001
Nov 19 19:24:02 192.168.2.50 Oops: 0000 [#1]
Nov 19 19:24:02 192.168.2.50 SMP
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 Modules linked in:
Nov 19 19:24:02 192.168.2.50  netconsole
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 CPU:    3
Nov 19 19:24:02 192.168.2.50 EIP:    0060:[<c03df86c>]    Not tainted VLI
Nov 19 19:24:02 192.168.2.50 EFLAGS: 00010286   (2.6.14.2)
Nov 19 19:24:02 192.168.2.50 EIP is at scsi_run_queue+0x12/0xbc
Nov 19 19:24:02 192.168.2.50 eax: 00000000   ebx: db480ca4   ecx: 00000001
edx: db480ca4
Nov 19 19:24:02 192.168.2.50 esi: f49bdb00   edi: 00000246   ebp: c35bfe88
esp: c35bfe74
Nov 19 19:24:02 192.168.2.50 ds: 007b   es: 007b   ss: 0068
Nov 19 19:24:02 192.168.2.50 Process ksoftirqd/3 (pid: 12,
threadinfo=c35be000 task=c3550030)
Nov 19 19:24:02 192.168.2.50
Nov 19 19:24:02 192.168.2.50 Stack:
Nov 19 19:24:02 192.168.2.50 00000060
Nov 19 19:24:02 192.168.2.50 00000282
Nov 19 19:24:02 192.168.2.50 db480ca4
Nov 19 19:24:02 192.168.2.50 f49bdb00
Nov 19 19:24:02 192.168.2.50 00000246
Nov 19 19:24:02 192.168.2.50 c35bfe98
Nov 19 19:24:02 192.168.2.50 c03df989
Nov 19 19:24:03 192.168.2.50 db480ca4
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50 e6ba79dc
Nov 19 19:24:03 192.168.2.50 c35bfebc
Nov 19 19:24:03 192.168.2.50 c03dfa7e
Nov 19 19:24:03 192.168.2.50 f49bdb00
Nov 19 19:24:03 192.168.2.50 00000000
Nov 19 19:24:03 192.168.2.50 00000024
Nov 19 19:24:03 192.168.2.50 db480ca4
Nov 19 19:24:03 192.168.2.50 f49bdb00
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50 00040000
Nov 19 19:24:03 192.168.2.50 e6ba79dc
Nov 19 19:24:03 192.168.2.50 c35bff08
Nov 19 19:24:03 192.168.2.50 c03dff01
Nov 19 19:24:03 192.168.2.50 f49bdb00
Nov 19 19:24:03 192.168.2.50 00000000
Nov 19 19:24:03 192.168.2.50 00000024
Nov 19 19:24:03 192.168.2.50 00000001
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50 Call Trace:
Nov 19 19:24:03 192.168.2.50  [<c0103bf2>]
Nov 19 19:24:03 192.168.2.50 show_stack+0x9a/0xd0
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c0103db2>]
Nov 19 19:24:03 192.168.2.50 show_registers+0x16a/0x1fa
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c0103fc3>]
Nov 19 19:24:03 192.168.2.50 die+0xfa/0x17c
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c05557bc>]
Nov 19 19:24:03 192.168.2.50 do_page_fault+0x37c/0x6da
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c01038ab>]
Nov 19 19:24:03 192.168.2.50 error_code+0x4f/0x54
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03df989>]
Nov 19 19:24:03 192.168.2.50 scsi_next_command+0x20/0x26
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03dfa7e>]
Nov 19 19:24:03 192.168.2.50 scsi_end_request+0xb6/0xf9
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03dff01>]
Nov 19 19:24:03 192.168.2.50 scsi_io_completion+0x2c0/0x4ef
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03e0398>]
Nov 19 19:24:03 192.168.2.50 scsi_generic_done+0x3b/0x47
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03db491>]
Nov 19 19:24:03 192.168.2.50 scsi_finish_command+0x83/0x97
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c03db359>]
Nov 19 19:24:03 192.168.2.50 scsi_softirq+0xb8/0x134
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c0123ec2>]
Nov 19 19:24:03 192.168.2.50 __do_softirq+0x72/0xdc
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c0123f63>]
Nov 19 19:24:03 192.168.2.50 do_softirq+0x37/0x39
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c012447c>]
Nov 19 19:24:03 192.168.2.50 ksoftirqd+0xa5/0xfa
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c01330d7>]
Nov 19 19:24:03 192.168.2.50 kthread+0xb1/0xb5
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50  [<c0101145>]
Nov 19 19:24:03 192.168.2.50 kernel_thread_helper+0x5/0xb
Nov 19 19:24:03 192.168.2.50
Nov 19 19:24:03 192.168.2.50 Code:
Nov 19 19:24:03 192.168.2.50 ff
Nov 19 19:24:03 192.168.2.50 8b
Nov 19 19:24:03 192.168.2.50 4d
Nov 19 19:24:03 192.168.2.50 ec
Nov 19 19:24:03 192.168.2.50 8b
Nov 19 19:24:03 192.168.2.50 41
Nov 19 19:24:03 192.168.2.50 2c
Nov 19 19:24:03 192.168.2.50 e8
Nov 19 19:24:03 192.168.2.50 bd
Nov 19 19:24:03 192.168.2.50 55
Nov 19 19:24:03 192.168.2.50 17
Nov 19 19:24:03 192.168.2.50 00
Nov 19 19:24:03 192.168.2.50 89
Nov 19 19:24:03 192.168.2.50 45
Nov 19 19:24:03 192.168.2.50 f0
Nov 19 19:24:03 192.168.2.50 89
Nov 19 19:24:03 192.168.2.50 1c
Nov 19 19:24:03 192.168.2.50 24
Nov 19 19:24:03 192.168.2.50 e8
Nov 19 19:24:03 192.168.2.50 51
Nov 19 19:24:03 192.168.2.50 be
Nov 19 19:24:03 192.168.2.50 ff
Nov 19 19:24:03 192.168.2.50 ff
Nov 19 19:24:03 192.168.2.50 eb
Nov 19 19:24:03 192.168.2.50 ad
Nov 19 19:24:03 192.168.2.50 55
Nov 19 19:24:03 192.168.2.50 89
Nov 19 19:24:03 192.168.2.50 e5
Nov 19 19:24:03 192.168.2.50 57
Nov 19 19:24:03 192.168.2.50 56
Nov 19 19:24:03 192.168.2.50 53
Nov 19 19:24:03 192.168.2.50 83
Nov 19 19:24:03 192.168.2.50 ec
Nov 19 19:24:03 192.168.2.50 08
Nov 19 19:24:03 192.168.2.50 8b
Nov 19 19:24:03 192.168.2.50 55
Nov 19 19:24:03 192.168.2.50 08
Nov 19 19:24:03 192.168.2.50 8b
Nov 19 19:24:03 192.168.2.50 82
Nov 19 19:24:03 192.168.2.50 ec
Nov 19 19:24:03 192.168.2.50 00
Nov 19 19:24:03 192.168.2.50 last message repeated 2 times
Nov 19 19:24:03 192.168.2.50 b>
Nov 19 19:24:03 192.168.2.50 38
Nov 19 19:24:03 192.168.2.50 80
Nov 19 19:24:03 192.168.2.50 b8
Nov 19 19:24:03 192.168.2.50 79
Nov 19 19:24:03 192.168.2.50 01
Nov 19 19:24:03 192.168.2.50 00
Nov 19 19:24:04 192.168.2.50 last message repeated 2 times
Nov 19 19:24:04 192.168.2.50 0f
Nov 19 19:24:04 192.168.2.50 88
Nov 19 19:24:04 192.168.2.50 8e
Nov 19 19:24:04 192.168.2.50 00
Nov 19 19:24:04 192.168.2.50 last message repeated 2 times
Nov 19 19:24:04 192.168.2.50 8b
Nov 19 19:24:04 192.168.2.50 47
Nov 19 19:24:04 192.168.2.50 2c
Nov 19 19:24:04 192.168.2.50 e8
Nov 19 19:24:04 192.168.2.50 87
Nov 19 19:24:04 192.168.2.50 55
Nov 19 19:24:04 192.168.2.50
Nov 19 19:24:04 192.168.2.50
Nov 19 19:24:04 192.168.2.50 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Nov 19 19:24:04 192.168.2.50 kernel:  printing eip:
Nov 19 19:24:04 192.168.2.50 kernel: c03df86c
Nov 19 19:24:04 192.168.2.50 kernel: *pde = 006d1001
Nov 19 19:24:04 192.168.2.50 kernel: Oops: 0000 [#1]
Nov 19 19:24:04 192.168.2.50 kernel: SMP
Nov 19 19:24:04 192.168.2.50 kernel: Modules linked in: netconsole
Nov 19 19:24:04 192.168.2.50 kernel: CPU:    3
Nov 19 19:24:04 192.168.2.50 Kernel panic - not syncing: Fatal exception in
interrupt
Nov 19 19:24:04 192.168.2.50 kernel: EIP:    0060:[<c03df86c>]    Not
tainted VLI
Nov 19 19:24:04 192.168.2.50
Nov 19 19:24:04 192.168.2.50 Rebooting in 5 seconds..


Thanks

Janos

