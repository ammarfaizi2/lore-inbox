Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262757AbSJCGyF>; Thu, 3 Oct 2002 02:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262758AbSJCGyF>; Thu, 3 Oct 2002 02:54:05 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:3714 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S262757AbSJCGyE>; Thu, 3 Oct 2002 02:54:04 -0400
Date: Thu, 3 Oct 2002 08:59:30 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.40: AT keyboard input problem
Message-ID: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While 2.5 has worked better than I hoped for so far, I do have a problem 
with the new input layer (I think) that is easily reproducible, and quite 
irritating.

If I press and hold my left Alt key, press and release the right AltGr
key, and then release the left Alt key, I get one of the following
messages in dmesg:

atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0xb8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x1b8, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.

The left Alt key is now stuck until I press and release it again.

The same thing happens for a few other combinations as well. I happens 
both in X and in the console.

Please let me know if you need more info.

/Tobias

