Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWEBHmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWEBHmr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEBHmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:42:47 -0400
Received: from soda.CSUA.Berkeley.EDU ([128.32.112.233]:9136 "EHLO
	soda.csua.berkeley.edu") by vger.kernel.org with ESMTP
	id S932490AbWEBHmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:42:46 -0400
Date: Tue, 2 May 2006 00:42:45 -0700
From: "Robert F. Merrill" <rfm@CSUA.Berkeley.EDU>
Message-Id: <200605020742.k427gj7W022835@soda.csua.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 0.6.93)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------[ cut here ]------------
kernel BUG at fs/locks.c:1932!
invalid operand: 0000 [#8]
SMP 
Modules linked in: thermal fan button processor ac battery nfs lockd nfs_acl sunrpc ipv6 quota_v1 ide_cd cdrom generic joydev evdev e1000 mousedev piix psmouse i2c_i801 serio_raw pcspkr i2c_core ide_core floppy rtc uhci_hcd ehci_hcd usbcore parport_pc parport shpchp pci_hotplug
CPU:    0
EIP:    0060:[<c015fe6a>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15.7-soda0) 
EIP is at locks_remove_flock+0xbb/0xd7
eax: d87f0cfc   ebx: ca0b0ebc   ecx: 00000000   edx: 00000000
esi: cf340900   edi: ca0b0e18   ebp: c5d75834   esp: cb585efc
ds: 007b   es: 007b   ss: 0068
Process mutt (pid: 2295, threadinfo=cb585000 task=e29f2030)
Stack: 00000000 00000000 00000000 00000000 00000000 cf340900 000008f7 00000000 
       00000000 00000000 cf340900 00000202 00000000 00000000 ffffffff 7fffffff 
       00000000 00000000 00000000 00000000 00000000 00000000 f6cb0b40 00000008 
Call Trace:
 [<c014da9d>] __fput+0x6d/0x125
 [<c014c5ca>] filp_close+0x4e/0x57
 [<c014c63b>] sys_close+0x68/0x7c
 [<c01027b1>] syscall_call+0x7/0xb
