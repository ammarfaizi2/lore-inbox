Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266011AbUFOXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUFOXhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUFOXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:37:15 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:33965 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266011AbUFOXhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:37:12 -0400
Message-ID: <40CF8846.7020309@blue-labs.org>
Date: Tue, 15 Jun 2004 19:37:42 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ov511 [2.6.7-rc3] does something odd
Content-Type: multipart/mixed;
 boundary="------------060608050503090304080203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060608050503090304080203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

usb 2-1.3: new full speed USB device using address 7
DEV: registering device: ID = '2-1.3'
PM: Adding info for usb:2-1.3
bus usb: add device 2-1.3
bound device '2-1.3' to driver 'usb'
DEV: registering device: ID = '2-1.3:1.0'
PM: Adding info for usb:2-1.3:1.0
bus usb: add device 2-1.3:1.0
drivers/usb/media/ov511.c: USB OV511 video device found
drivers/usb/media/ov511.c: model: AverMedia InterCam Elite
drivers/usb/media/ov511.c: Sensor is an OV7610
CLASS: registering class device: ID = 'video0'
class_hotplug - name = video0
drivers/usb/media/ov511.c: Device at usb-0000:00:10.0-1.3 registered to 
minor 0
bound device '2-1.3:1.0' to driver 'ov511'
stack segment: 0000 [1] PREEMPT
CPU 0
Modules linked in:
Pid: 6806, comm: camsource Not tainted 2.6.7-rc3
RIP: 0010:[<ffffffff803a9906>] <ffffffff803a9906>{ov51x_v4l1_ioctl+38}
RSP: 0018:000001003c4edf18  EFLAGS: 00010216
RAX: 000001003fefe920 RBX: 6b6b6b6b6b6b6c13 RCX: 00000000407ff760
RDX: 0000000040107613 RSI: 000001003a1d5a88 RDI: 6b6b6b6b6b6b6c13
RBP: 6b6b6b6b6b6b6b6b R08: 0000000000524f80 R09: 000001003d714c08
R10: 00000000407ff738 R11: 0000000000000246 R12: 00000000407ff760
R13: 0000000000000000 R14: 0000000000000007 R15: 00000000ffffffe7
FS:  00000000407ff960(005b) GS:ffffffff80737b00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9e5c8000 CR3: 0000000000101000 CR4: 00000000000006e0
Process camsource (pid: 6806, threadinfo 000001003c4ec000, task 
000001003e1b2430)
Stack: 0000000040107613 0000000040107613 000001003a1d5a88 ffffffff801ad8bd
       0000000000000000 000000003b8658f4 0000000000000000 00000000005250c0
       00000000407ff760 0000000000525040
Call Trace:<ffffffff801ad8bd>{sys_ioctl+685} 
<ffffffff8011221a>{system_call+126}


Code: ff 8d a8 00 00 00 0f 88 8a 2c 00 00 31 c0 85 c0 41 b8 fc ff
RIP <ffffffff803a9906>{ov51x_v4l1_ioctl+38} RSP <000001003c4edf18>


--------------060608050503090304080203
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


--------------060608050503090304080203--
