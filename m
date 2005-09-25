Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbVIYTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbVIYTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 15:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbVIYTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 15:17:25 -0400
Received: from BSN-95-229-147.dsl.siol.net ([193.95.229.147]:15378 "EHLO
	sammy.k106") by vger.kernel.org with ESMTP id S932277AbVIYTRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 15:17:24 -0400
Message-ID: <4336F78D.9020308@siol.net>
Date: Sun, 25 Sep 2005 21:16:29 +0200
From: Izo <I@siol.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help needed: kernel boot waits for Synaptics TouchPAD for whole minute
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obviously I have been wasting my time notorically posting this question 
to the linux.kernel newsgroup (about 5-6 times, I guess) until I have 
finally taken a look to the tux org page.However, here is my question 
again and I just hope somebody's gonna post an answer on it:

kernel: 2.6.13 (CPU=P4)
GRUB kernel line: kernel (hd0,4)/boot/bzImage-2.6.13 root=/dev/hda5
vga=0x317 selinux=0 splash=silent resume=/dev/hda2 desktop elevator=as
showopts

On my Gericom Blockbuster notebook kernel waits at boot for whole minute
for Synaptics TouchPad (while SuSE-9.3 packaged kernel (2.6.11) boots
fine). After this minute the kernel boot continues and it works OK
afterwards.

......
ACPI wakeup devices:
PCI0 PS2M PS2K  EC0  LID USB1 USB2 USB3 USB4 S139  LAN  MDM  AUD SLPB
ACPI: (supports S0 S3 S4 S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
input: AT Translated Set 2 keyboard on isa0060/serio0
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
Synaptics Touchpad, model: 1, fw: 4.1, id: 0x848a1, caps: 0x0/0x0
input: SynPS/2 Synaptics TouchPad on isa0060/serio2

after minute or so kernel boot continues:

ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Trying to move old root to /initrd ... /initrd does not exist. Ignored.
Unmounting old root
Trying to free ramdisk memory ... okay
....
and smoothly on


I've been googling for some helpful info and found nothing.

Can somebody tell me what to do to et rid of this delay at boot ?

Izo
