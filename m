Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTIOGMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTIOGMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:12:25 -0400
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:61056
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S262440AbTIOGMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:12:22 -0400
Date: Mon, 15 Sep 2003 02:12:21 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: Keyboard problems: magic key + h stuck, and keyboard errors,stuck
 keys with 2.6.0-test5-bk3
Message-ID: <Pine.LNX.4.44.0309150159030.389-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two systems, When I turn the system next to me on the machine thats
currently powered on spews out this each time, why is the magic key
(alt+sysrq h) being dumped?

They are both connected via serial.

SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount
SysRq : HELP : loglevel0-8 reBoot Dumpmsgs tErm kIll saK showMem powerOff
showPc unRaw Sync showTasks Unmount

I have run into race conditions with the two machines and serial
connectivity in the past (see previous emails on that).

What would be the best way to determine why my systems cause so much
problems wrt to serial connectivity?

Also, what is the best way to debug a kernel over serial when the system
on the other end is completely locked?

The other issue is:

Dec  8 17:56:45 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
Dec  8 17:56:45 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Feb 12 23:25:29 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
Feb 17 02:09:26 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
Feb 20 23:06:04 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.Feb 22 01:45:55 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Feb 24 18:33:37 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
Feb 27 00:09:52 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Mar  5 00:49:59 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
Mar  5 00:49:59 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
..........................

Sep  1 23:38:58 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xc0, on isa0060/serio0) pressed.
Sep  1 23:38:59 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Sep  1 23:39:04 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xc0, on isa0060/serio0) pressed.
Sep  1 23:39:35 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Sep 10 20:25:57 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
Sep 10 21:50:22 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Sep 11 22:57:07 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Sep 13 16:16:24 coredump kernel: atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.

I have a small 4 port KVM switch from Startech, Is this KVM causing
keyboard issues that the keyboard driver cannot interpret properly?

Why is this occuring so often? I can usually trigger this if I start using
certain key combinations.

What also happens is a key will get 'stuck' and then repeat itself until I
stop it from repeating the letter.

The keyboard is a Microsoft Internet keyboard PS/2 style plugged into the
KVM.

If you want me to catch any debug output let me know and I will do this.

Thanks,

Shawn S.

