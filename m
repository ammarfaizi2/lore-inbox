Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVBPOEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVBPOEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVBPOEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:04:36 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:4996 "EHLO smtp12.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262017AbVBPOET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:04:19 -0500
X-ME-UUID: 20050216140418133.2094A1C00090@mwinf1202.wanadoo.fr
Date: Wed, 16 Feb 2005 15:04:16 +0100
From: Christophe Lucas <c.lucas@ifrance.com>
To: linux-kernel@vger.kernel.org
Message-ID: <20050216140416.GK3658@rhum.iomeda.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux / 2.6.9 (i686)
X-Homepage: http://odie.mcom.fr/~clucas/
X-Crypto: GnuPG/1.2.4 http://www.gnupg.org
X-GPG-Key: http://odie.mcom.fr/~clucas/downloads/clucas-public-key.txt
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 192.168.0.24
X-SA-Exim-Mail-From: c.lucas@ifrance.com
Subject: [OOPS] 2.6.9
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on vodka.iomeda.fr)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here is an oops which have been occured around 3, 4 time in a week.
I know that, perhaps the reason of this crash have been tracked and
killed in 2.6.10, and near 2.6.11.

But if it could help, I enclosed oops and ksymoops files.
I can put on net all information about the computer on which this oops
appeared.

Have a good day :)
-- 
Christophe

--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops.setiathome"

ksymoops 2.4.9 on i686 2.6.9.  Options used
     -v /usr/src/linux-2.6.9/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9/ (default)
     -M (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
EIP: 0060:[<c0120662>] Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097 (2.6.9)
eax: 3e03a64b ebx: 3b9b7640 ecx: c914cea0 edx: d755df64
esi: d755c000 edi: 3e06637b ebp: d755df64 esp: d755df54
ds: 007b es: 007b ss: 0068
c01203eb 00000001 c012085f d755df64 c914cea0 c9145e00 d755dfc4 00000001
c033c0a8 0000000a c0302800 c011c6fd c033c0a8 00000046 00000000 c029b510
c011c736 d755c000 c0106e2d 00000000 c0302800 00000001 c029b510 b707c480
Call Trace:
[<c01203eb>] update_wall_time+0xb/0x40
[<c012085f>] do_timer+0xdf/0xf0
[<c011c6fd>] __do_softirq+0x7d/0x90
[<c011c736>] do_softirq+0x26/0x30
[<c0106e2d>] do_IRQ+0xfd/0x130
[<c0104b88>] common_interrupt+0x18/0x20
Code: 24 10 89 41 04 8b 44 24 0c 89 4c 24 10 89 02 89 50 04 89 5f 08 89 5b 04 90 8b 4d 00 39 e9 74 41 8b 51 04 8b 01 8b 79 10 8b 59 14 <89> 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c7 41 18


>>EIP; c0120662 <run_timer_softirq+a2/1b0>   <=====

>>eax; 3e03a64b <__crc_scsi_cmd_ioctl+60d98/48514c>
>>ebx; 3b9b7640 <__crc_skb_iter_next+9334/568bc3>
>>ecx; c914cea0 <__crc_elv_add_request+495a4c/5724c0>
>>edx; d755df64 <__crc_blkdev_scsi_issue_flush_fn+15993c/2ba9fb>
>>esi; d755c000 <__crc_blkdev_scsi_issue_flush_fn+1579d8/2ba9fb>
>>edi; 3e06637b <__crc_scsi_cmd_ioctl+8cac8/48514c>
>>ebp; d755df64 <__crc_blkdev_scsi_issue_flush_fn+15993c/2ba9fb>
>>esp; d755df54 <__crc_blkdev_scsi_issue_flush_fn+15992c/2ba9fb>

Trace; c01203eb <update_wall_time+b/40>
Trace; c012085f <do_timer+df/f0>
Trace; c011c6fd <__do_softirq+7d/90>
Trace; c011c736 <do_softirq+26/30>
Trace; c0106e2d <do_IRQ+fd/130>
Trace; c0104b88 <common_interrupt+18/20>

Code;  c0120637 <run_timer_softirq+77/1b0>
00000000 <_EIP>:
Code;  c0120637 <run_timer_softirq+77/1b0>
   0:   24 10                     and    $0x10,%al
Code;  c0120639 <run_timer_softirq+79/1b0>
   2:   89 41 04                  mov    %eax,0x4(%ecx)
Code;  c012063c <run_timer_softirq+7c/1b0>
   5:   8b 44 24 0c               mov    0xc(%esp),%eax
Code;  c0120640 <run_timer_softirq+80/1b0>
   9:   89 4c 24 10               mov    %ecx,0x10(%esp)
Code;  c0120644 <run_timer_softirq+84/1b0>
   d:   89 02                     mov    %eax,(%edx)
Code;  c0120646 <run_timer_softirq+86/1b0>
   f:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0120649 <run_timer_softirq+89/1b0>
  12:   89 5f 08                  mov    %ebx,0x8(%edi)
Code;  c012064c <run_timer_softirq+8c/1b0>
  15:   89 5b 04                  mov    %ebx,0x4(%ebx)
Code;  c012064f <run_timer_softirq+8f/1b0>
  18:   90                        nop    
Code;  c0120650 <run_timer_softirq+90/1b0>
  19:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c0120653 <run_timer_softirq+93/1b0>
  1c:   39 e9                     cmp    %ebp,%ecx
Code;  c0120655 <run_timer_softirq+95/1b0>
  1e:   74 41                     je     61 <_EIP+0x61>
Code;  c0120657 <run_timer_softirq+97/1b0>
  20:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c012065a <run_timer_softirq+9a/1b0>
  23:   8b 01                     mov    (%ecx),%eax
Code;  c012065c <run_timer_softirq+9c/1b0>
  25:   8b 79 10                  mov    0x10(%ecx),%edi
Code;  c012065f <run_timer_softirq+9f/1b0>
  28:   8b 59 14                  mov    0x14(%ecx),%ebx
Code;  c0120662 <run_timer_softirq+a2/1b0>   <=====
  2b:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0120665 <run_timer_softirq+a5/1b0>
  2e:   89 02                     mov    %eax,(%edx)
Code;  c0120667 <run_timer_softirq+a7/1b0>
  30:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)
Code;  c012066e <run_timer_softirq+ae/1b0>
  37:   c7 01 00 01 10 00         movl   $0x100100,(%ecx)
Code;  c0120674 <run_timer_softirq+b4/1b0>
  3d:   c7                        .byte 0xc7
Code;  c0120675 <run_timer_softirq+b5/1b0>
  3e:   41                        inc    %ecx
Code;  c0120676 <run_timer_softirq+b6/1b0>
  3f:   18                        .byte 0x18


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="setiathome.oops"

CPU:0
EIP: 0060:[<c0120662>] Not Tainted
EFLAGS: 00010097 (2.6.9)
EIP is at run_timer_softirq+0xa2/0x1b0
eax: 3e03a64b ebx: 3b9b7640 ecx: c914cea0 edx: d755df64
esi: d755c000 edi: 3e06637b ebp: d755df64 esp: d755df54
ds: 007b es: 007b ss: 0068
process setiathome (pid=8548, threadinfo=d755c000, task=d3206aa0)
Stack:
c01203eb 00000001 c012085f d755df64 c914cea0 c9145e00 d755dfc4 00000001
c033c0a8 0000000a c0302800 c011c6fd c033c0a8 00000046 00000000 c029b510
c011c736 d755c000 c0106e2d 00000000 c0302800 00000001 c029b510 b707c480

Call Trace:
[<c01203eb>] update_wall_time+0xb/0x40
[<c012085f>] do_timer+0xdf/0xf0
[<c011c6fd>] __do_softirq+0x7d/0x90
[<c011c736>] do_softirq+0x26/0x30
[<c0106e2d>] do_IRQ+0xfd/0x130
[<c0104b88>] common_interrupt+0x18/0x20

Code: 24 10 89 41 04 8b 44 24 0c 89 4c 24 10 89 02 89 50 04 89 5f 08 89 5b 04 90 8b 4d 00 39 e9 74 41 8b 51 04 8b 01 8b 79 10 8b 59 14 <89> 50 04 89 02 c7 41 04 00 02 20 00 c7 01 00 01 10 00 c7 41 18

--lMM8JwqTlfDpEaS6--

