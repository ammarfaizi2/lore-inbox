Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbVIVUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbVIVUeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIVUeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:34:08 -0400
Received: from smtp.etmail.cz ([160.218.43.220]:28631 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S1750839AbVIVUeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:34:07 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-dvb@linuxtv.org
Subject: oops when playing using pluto2 driver
Date: Thu, 22 Sep 2005 22:32:55 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222232.57878.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sending oops occured playing using pluto2 driver

tda1004x: found firmware revision ff -- invalid
tda1004x: waiting for firmware upload...
tda1004x: found firmware revision 20 -- ok
tda1004x: found firmware revision 20 -- ok
pluto2 0000:03:00.0: overflow irq (6)
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
pluto2 0000:03:00.0: card hung up :(
ACPI: PCI interrupt for device 0000:03:00.0 disabled
Unable to handle kernel NULL pointer dereference at virtual address 0000016c
 printing eip:
f8856ed0
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: rfcomm hidp l2cap pcspkr cdc_acm sd_mod snd_intel8x0m 
8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc i2c_i801 ehci_hcd hci_usb 
eth1394 usb_storage bluetoothuhci_hcd ipw2200 ieee80211 ieee80211_crypt 
8139too mii ohci1394 sr_mod sbp2 scsi_mod ieee1394 ide_cd cdrom genrtc pluto2 
dvb_core tda1004x
CPU:    0
EIP:    0060:[<f8856ed0>]    Not tainted VLI
EFLAGS: 00010246   (2.6.13)
EIP is at dvb_frontend_poll+0x40/0xb0 [dvb_core]
eax: 00000000   ebx: 00000000   ecx: 00000174   edx: 00000001
esi: 00000000   edi: f21ff700   ebp: 00000001   esp: f569df10
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5034, threadinfo=f569c000 task=efd5f060)
Stack: f569df1c 00393b58 f569df98 00000145 f74bb188 f21ff700 c017a871 f21ff700
       00000000 f74bb180 00000000 f569df5c f569df60 c017a8ec 00000001 f74bb188
       f569df5c f569df60 f569c000 00000000 00000000 00000000 f74bb180 bf88fe08
Call Trace:
 [<c017a871>] do_pollfd+0x91/0xa0
 [<c017a8ec>] do_poll+0x6c/0xe0
 [<c017ab30>] sys_poll+0x1d0/0x230
 [<c0179e90>] __pollwait+0x0/0xd0
 [<c01031e5>] syscall_call+0x7/0xb
Code: 24 0c 8b 47 78 8b 40 28 8b 58 0c a1 d0 23 86 f8 85 c0 75 47 85 f6 89 d9 
0f 95 c0 81 c1 74 01 00 00 0f 95 c2 0f b6 d285 d0 75 60 <8b> 93 6c 01 00 00 
b8 43 00 00 00 8b 74 24 10 39 93 68 01 00 00
 <1>Unable to handle kernel paging request at virtual address f882c050
 printing eip:
f8850467
*pde = 017ec067
*pte = 00000000
Oops: 0000 [#2]
PREEMPT
Modules linked in: rfcomm hidp l2cap pcspkr cdc_acm sd_mod snd_intel8x0m 
8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc i2c_i801 ehci_hcd hci_usb 
eth1394 usb_storage bluetoothuhci_hcd ipw2200 ieee80211 ieee80211_crypt 
8139too mii ohci1394 sr_mod sbp2 scsi_mod ieee1394 ide_cd cdrom genrtc pluto2 
dvb_core tda1004x
CPU:    0
EIP:    0060:[<f8850467>]    Not tainted VLI
EFLAGS: 00010286   (2.6.13)
EIP is at dvb_demux_release+0x7/0x20 [dvb_core]
eax: f882c000   ebx: 00000008   ecx: 00000000   edx: f8850460
esi: ef05c780   edi: c17e0e80   ebp: f61eb314   esp: ee0ede28
ds: 007b   es: 007b   ss: 0068
Process kaffeine (pid: 5064, threadinfo=ee0ec000 task=ee09e580)
Stack: c0165a6e f61eb314 ef05c780 00000000 00000000 f639840c ef05c780 f6ac5040
       00000000 00000001 c0163db6 ef05c780 f6ac5040 0000168f 0000000a f6ac5040
       c011fa72 ef05c780 f6ac5040 ee0ec000 ee09e580 f6ac5040 00000009 c01207a5
Call Trace:
 [<c0165a6e>] __fput+0x15e/0x1a0
 [<c0163db6>] filp_close+0x46/0x90
 [<c011fa72>] put_files_struct+0x62/0xd0
 [<c01207a5>] do_exit+0x105/0x420
 [<c0120b34>] do_group_exit+0x34/0xa0
 [<c012a80b>] get_signal_to_deliver+0x20b/0x330
 [<c0102f9c>] do_signal+0x6c/0x150
 [<c0179e90>] __pollwait+0x0/0xd0
 [<c017a5a0>] sys_select+0x210/0x450
 [<c0164898>] vfs_read+0x1a8/0x1b0
 [<c01030b7>] do_notify_resume+0x37/0x3c
 [<c0103276>] work_notifysig+0x13/0x15
Code: 74 24 10 8b 7c 24 14 8b 6c 24 18 83 c4 1c c3 90 8d 74 26 00 89 74 24 08 
89 4c 24 04 89 2c 24 ff 16 eb ae 90 8b 44 2408 8b 40 78 <8b> 50 50 89 44 24 
08 89 54 24 04 e9 69 f8 ff ff 89 f6 8d bc 27
 <1>Fixing recursive fault but reboot is needed!


vanilla kernel 2.6.13, debian sarge

Michal
-- 
S pozdravem

Michal Semler
