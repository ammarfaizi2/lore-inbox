Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVC2RCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVC2RCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 12:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVC2RCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 12:02:41 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:28805
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261222AbVC2RAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 12:00:55 -0500
Subject: OOPS in linux 2.6.10
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 29 Mar 2005 19:00:19 +0200
Message-Id: <1112115619.8048.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

	I use Slackware linux 2.6.10 standard kernel on a Sony Vaio PCG-GRT816S
laptop. I got that error. Maybe of some help.
Rgds
Sasa


Mar 29 17:29:49 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000007a
Mar 29 17:29:49 localhost kernel:  printing eip:
Mar 29 17:29:49 localhost kernel: f8d453b3
Mar 29 17:29:49 localhost kernel: *pde = 00000000
Mar 29 17:29:49 localhost kernel: Oops: 0002 [#1]
Mar 29 17:29:49 localhost kernel: Modules linked in: snd_pcm_oss
snd_mixer_oss ipv6 uhci_hcd sis_agp shpchp i2c_sis96x i2c_core
usb_storage snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm stv680
videodev snd_timer snd soundcore snd_page_alloc eth1394 ohci_hcd
ehci_hcd sis900 ohci1394 ieee1394 nvidia pcmcia yenta_socket pcmcia_core
dm_mod evdev agpgart psmouse reiserfs
Mar 29 17:29:49 localhost kernel: CPU:    0
Mar 29 17:29:49 localhost kernel: EIP:    0060:[<f8d453b3>]    Tainted:
P      VLI
Mar 29 17:29:49 localhost kernel: EFLAGS: 00210286   (2.6.10)
Mar 29 17:29:49 localhost kernel: EIP is at stv_close+0x13/0xe0 [stv680]
Mar 29 17:29:49 localhost kernel: eax: 00000001   ebx: 00000002   ecx:
c9164680   edx: 00000002
Mar 29 17:29:49 localhost kernel: esi: c9164680   edi: f6c864c4   ebp:
f709e0dc   esp: d0ae7f44
Mar 29 17:29:49 localhost kernel: ds: 007b   es: 007b   ss: 0068
Mar 29 17:29:49 localhost kernel: Process xsane (pid: 23222,
threadinfo=d0ae6000 task=dc8260a0)
Mar 29 17:29:49 localhost kernel: Stack: c9164680 dfff4b00 c01495e4
f6c864c4 c9164680 c9164680 dd8c3a50 dc8260a0
Mar 29 17:29:49 localhost kernel:        00000000 c013cac7 cf73c564
de788d00 c013e809 dd8c3a50 c03c1808 000002f2
Mar 29 17:29:49 localhost kernel:        de788d00 de788d2c c011433d
de788d00 de788d00 c0117f19 de788d00 00000001
Mar 29 17:29:49 localhost kernel: Call Trace:
Mar 29 17:29:49 localhost kernel:  [<c01495e4>] __fput+0xf4/0x110
Mar 29 17:29:49 localhost kernel:  [<c013cac7>] remove_vm_struct
+0x37/0x70
Mar 29 17:29:49 localhost kernel:  [<c013e809>] exit_mmap+0xf9/0x120
Mar 29 17:29:49 localhost kernel:  [<c011433d>] mmput+0x2d/0x80
Mar 29 17:29:49 localhost kernel:  [<c0117f19>] do_exit+0x139/0x370
Mar 29 17:29:49 localhost kernel:  [<c01181ba>] do_group_exit+0x2a/0x70
Mar 29 17:29:49 localhost kernel:  [<c0102d17>] syscall_call+0x7/0xb
Mar 29 17:29:49 localhost kernel: Code: c7 83 c4 10 bb f4 ff ff ff eb b9
8d b6 00 00 00 00 8d bc 27 00 00 00 00 56 53 8b 74 24 10 8b 46 7c 8b 58
40 89 da b8 01 00 00 00 <c7> 42 78 00 00 00 00 83 c2 14 48 79 f3 8b 43
64 85 c0 0f 85 a5




