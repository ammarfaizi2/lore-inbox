Return-Path: <linux-kernel-owner+w=401wt.eu-S1753963AbWLXACJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbWLXACJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbWLXACJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 19:02:09 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58218 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753963AbWLXACI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 19:02:08 -0500
Date: Sun, 24 Dec 2006 01:01:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth memory corruption (was Re: ext3-related crash in 2.6.20-rc1)
Message-ID: <20061224000150.GA1812@elf.ucw.cz>
References: <20061223234305.GA1809@elf.ucw.cz> <20061223235501.GA1740@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061223235501.GA1740@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I got this nasty oops while playing with debugger. Not sure if that is
> > related; it also might be something with bluetooth; I already know it
> > corrupts memory during suspend, perhaps it corrupts memory in some
> > error path?
> 
> Okay, I spoke too soon. bluetooth & suspend memory corruption was
> _way_ harder to reproduce than expected. Took me 5-or-so-suspend
> cycles... so it is probably unrelated to the previous crash.
> 
> I was getting pretty regular crashes with bluetooth & gdb, but I was
> not using bluetooth at the time of ext3-related crash.

And for completeness, here's bluetooth + gdb oops. Ok, I'm not _sure_
it is bluetooth related. I'll try it without bluetooth in a while.

								Pavel

PM: Adding info for No Bus:vcsa8
coda_read_super: Bad mount data
coda_read_super: device index: 0
coda_read_super: rootfid is (01234567.ffffffff.080519b0.00000000)
PM: Removing info for No Bus:vcs10
PM: Removing info for No Bus:vcsa10
coda_upcall: Venus dead on (op,un) (7.2) flags 10
Failure of coda_cnode_make for root: error -19
hci_cmd_task: hci0 command tx timeout
PM: Adding info for No Bus:rfcomm1
PM: Adding info for bluetooth:acl00803715A329
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
hci_acldata_packet: hci0 ACL packet for unknown connection handle 12
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
l2cap_recv_acldata: Unexpected continuation frame (len 0)
PM: Removing info for bluetooth:acl00803715A329
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1235!
invalid opcode: 0000 [#1]
SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c01912b2>]    Not tainted VLI
EFLAGS: 00010046   (2.6.20-rc1 #383)
EIP is at __find_get_block+0x1b2/0x1c0
eax: 00000086   ebx: 00001000   ecx: 00000000   edx: 006780b2
esi: 0033d60d   edi: 00001000   ebp: 000000cf   esp: f75a3c90
ds: 007b   es: 007b   ss: 0068
Process phone (pid: 1795, ti=f75a2000 task=c2287030 task.ti=f75a2000)
Stack: 006780b2 00000000 c21e9a08 00000003 ad40ad40 f7d8d1dc c0629908 00000000 
       f89fa000 00000012 00000002 00000003 ad55ad55 f7d8d182 c0629908 00001000 
       0033d60d 00001000 000000cf c01912df 00001000 f7dbf74c 00000000 00000008 
Call Trace:
 [<c01912df>] __getblk+0x1f/0x290
 [<c016a284>] check_poison_obj+0x24/0x1a0
 [<c0280115>] soft_cursor+0x175/0x1e0
 [<c01b1ad0>] __ext3_get_inode_loc+0x120/0x3a0
 [<c016954e>] dbg_redzone1+0xe/0x20
 [<c016a43e>] cache_alloc_debugcheck_after+0x3e/0x150
 [<c01c1703>] journal_start+0x83/0xe0
 [<c01b1e27>] ext3_reserve_inode_write+0x27/0x80
 [<c01b226a>] ext3_mark_inode_dirty+0x1a/0x40
 [<c01b2719>] ext3_dirty_inode+0x79/0xb0
 [<c018a744>] __mark_inode_dirty+0x34/0x1c0
 [<c0181a59>] file_update_time+0x39/0xa0
 [<c0152984>] __generic_file_aio_write_nolock+0x244/0x590
 [<c0120fad>] __wake_up_sync+0x3d/0x60
 [<c06154df>] __mutex_lock_slowpath+0xef/0x230
 [<c0152d29>] generic_file_aio_write+0x59/0xd0
 [<c01b04a0>] ext3_file_write+0x30/0xc0
 [<c016e997>] do_sync_write+0xc7/0x130
 [<c013c640>] autoremove_wake_function+0x0/0x50
 [<c015f2e9>] remove_vma+0x39/0x50
 [<c016f126>] vfs_write+0xa6/0x160
 [<c016e8d0>] do_sync_write+0x0/0x130
 [<c016f9e1>] sys_write+0x41/0x70
 [<c010304c>] syscall_call+0x7/0xb
 =======================
Code: 00 8b 7c 24 18 f3 a5 fb 8b 44 24 10 85 c0 0f 84 2c ff ff ff 8b 44 24 10 e8 5c ca ff ff e9 1e ff ff ff 89 d8 e8 50 ca ff ff eb 8d <0f> 0b eb fe 0f 0b eb fe 0f 0b eb fe 89 f6 55 57 56 53 83 ec 48 
EIP: [<c01912b2>] __find_get_block+0x1b2/0x1c0 SS:ESP 0068:f75a3c90
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
