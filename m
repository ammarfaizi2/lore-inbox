Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUFGAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUFGAaj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbUFGAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 20:30:39 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:13203 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264269AbUFGAaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 20:30:24 -0400
Message-ID: <40C3B721.6060109@blue-labs.org>
Date: Sun, 06 Jun 2004 20:30:25 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [OOPS-amd64] 2.6.7-rc2, USB
Content-Type: multipart/mixed;
 boundary="------------070703020402060702040401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703020402060702040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The system was fairly idle except for playing mp3s.

gcc version 3.3.3 20040412 (Gentoo Linux 3.3.3-r5, ssp-3.3-7, pie-8.7.5.3)


Jun  6 19:54:58 Scott drivers/usb/media/ov511.c: ERROR: urb->status=-71: 
Bit-stuff error (bad cable?)
Jun  6 19:54:58 Scott hub 2-1:1.0: port 1 disabled by hub (EMI?), 
re-enabling...<6>usb 2-1.1: USB disconnect,
address 3
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott ALSA sound/pci/via82xx.c:737: invalid 
via82xx_cur_ptr, using last valid pointer
Jun  6 19:54:58 Scott usb 2-1.1: new low speed USB device using address 6
Jun  6 19:54:59 Scott hiddev97: USB HID v1.10 Device [APC Back-UPS ES 
350 FW:1.e2.D USB FW:e2] on usb-0000:00:
10.0-1.1
Jun  6 19:55:13 Scott Unable to handle kernel paging request at 
0000000000003140 RIP:
Jun  6 19:55:13 Scott <ffffffff8032ddd6>{hid_open+6}PML4 3dbc7067 PGD 
3db69067 PMD 0
Jun  6 19:55:13 Scott Oops: 0000 [1]
Jun  6 19:55:13 Scott CPU 0
Jun  6 19:55:13 Scott Modules linked in: snd_pcm_oss snd_mixer_oss
Jun  6 19:55:13 Scott Pid: 6521, comm: apcupsd Not tainted 2.6.7-rc2
Jun  6 19:55:13 Scott RIP: 0010:[<ffffffff8032ddd6>] 
<ffffffff8032ddd6>{hid_open+6}
Jun  6 19:55:13 Scott RSP: 0018:000001003d02be48  EFLAGS: 00010246
Jun  6 19:55:13 Scott RAX: 000001003f53f968 RBX: 0000000000000000 RCX: 
0000000000000000
Jun  6 19:55:13 Scott RDX: 0000000000000000 RSI: 000001003d518000 RDI: 
0000000000000008
Jun  6 19:55:13 Scott RBP: 000001003f0d6d80 R08: 0000000000000000 R09: 
000001003df2d868
Jun  6 19:55:13 Scott R10: 0000000000000400 R11: 0000000000000004 R12: 
00000000ffffffed
Jun  6 19:55:13 Scott R13: 0000000000000000 R14: 000001003f0d6d80 R15: 
0000000000521010
Jun  6 19:55:13 Scott FS:  0000002a95cdb4a0(0000) 
GS:ffffffff80752a80(0000) knlGS:0000000000000000
Jun  6 19:55:13 Scott CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  6 19:55:13 Scott CR2: 0000000000003140 CR3: 0000000000101000 CR4: 
00000000000006e0
Jun  6 19:55:13 Scott Process apcupsd (pid: 6521, threadinfo 
000001003d02a000, task 000001003d3947f0)
Jun  6 19:55:13 Scott Stack: 0000000000000216 ffffffff8032ee52 
000001003ec9d4c0 ffffffff8063fe00
Jun  6 19:55:13 Scott 000001003f0d6d80 ffffffff80310961 000001003fb15068 
000001003ec9d4c0
Jun  6 19:55:13 Scott 0000000000000000 ffffffff8016ed31
Jun  6 19:55:13 Scott Call Trace:<ffffffff8032ee52>{hiddev_open+210} 
<ffffffff80310961>{usb_open+97}
Jun  6 19:55:13 Scott <ffffffff8016ed31>{chrdev_open+305} 
<ffffffff801662fd>{dentry_open+205}
Jun  6 19:55:13 Scott <ffffffff80166212>{filp_open+66} 
<ffffffff8013a980>{process_timeout+0}
Jun  6 19:55:13 Scott <ffffffff801665fc>{sys_open+76} 
<ffffffff801115aa>{system_call+126}
Jun  6 19:55:13 Scott
Jun  6 19:55:13 Scott
Jun  6 19:55:13 Scott Code: 8b 87 38 31 00 00 ff c0 89 87 38 31 00 00 ff 
c8 75 2e 48 8b
Jun  6 19:55:13 Scott RIP <ffffffff8032ddd6>{hid_open+6} RSP 
<000001003d02be48>
Jun  6 19:55:13 Scott CR2: 0000000000003140


--------------070703020402060702040401
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070703020402060702040401--
