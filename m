Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267881AbUJOOfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267881AbUJOOfH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUJOOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:35:06 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25728 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267881AbUJOOet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:34:49 -0400
Date: Fri, 15 Oct 2004 10:34:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: OOPS while loading a Linux-2.6.8 module
Message-ID: <Pine.LNX.4.61.0410151030490.25333@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you were to execute `strip` on a Linux-2.6.8 module,
you can OOPS the kernel. Gotta patch? I'll test immediately.


HeavyLink: falsely claims to have parameter shmem
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
00000000
*pde = 07469001
Oops: 0000 [#1]
SMP 
Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm l2cap bluetooth sunrpc 3c59x e100 mii ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables floppy sg sr_mod microcode dm_mod uhci_hcd ehci_hcd button battery asus_acpi ac ipv6 ext3 jbd ata_piix libata aic7xxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010202   (2.6.8) 
EIP is at 0x0
eax: 00000000   ebx: c0341da0   ecx: c0341da0   edx: 00000000
esi: f0a60f80   edi: c0341d84   ebp: c0341d84   esp: de38dfa4
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 25326, threadinfo=de38c000 task=ee9ab730)
Stack: c0138897 bffffc1a 00000004 0807a018 00000000 00000000 de38c000 c0106e4d
        0807a018 0000c3e0 0807a008 00000000 00000000 bfffcc08 00000080 0000007b
        0000007b 00000080 ffffe410 00000073 00000206 bfffcbb0 0000007b 
Call Trace:
  [<c0138897>] sys_init_module+0x107/0x220
  [<c0106e4d>] sysenter_past_esp+0x52/0x71
Code:  Bad EIP value.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

