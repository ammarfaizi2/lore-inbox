Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJBCtC>; Tue, 1 Oct 2002 22:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262935AbSJBCtC>; Tue, 1 Oct 2002 22:49:02 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:64496 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S261677AbSJBCtB>; Tue, 1 Oct 2002 22:49:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15770.24570.170414.576715@samba.doc.wustl.edu>
Date: Tue, 1 Oct 2002 21:54:50 -0500
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: Keyboard problems with Linux-2.5.40
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a MS Natural Pro Keyboard with a PS/2 adapter (if I use it as a
USB keyboard I am not able to use it to select the kernel to load i.e use
the keyboard before the kernel is loaded, anybody know how to get around
this ? ) under Linux-2.5.40. I have mapped the multimedia keys available
under this keyboard to start some applications under X. I am having
problems with a couple of keys being unrecognized and one key producing
duplicate behaviour as another. Specifically, I have the following in my
.xmodmaprc file:

/----[ .xmodmap-samba ]
| ! .xmodmap-samba -- Customize Microsoft Natural Pro PC keyboard -*- xrdb -*-
| !
| ! last modified:  19-Oct-2001  Fri  15:03
| 
| ! Use the fancy buttons to do some tasks
| !
| keycode 144 = XF86AudioPrev
| keycode 153 = XF86AudioNext
| keycode 160 = XF86AudioMute
| keycode 161 = XF86Calculator
| keycode 162 = XF86AudioPlay
| keycode 164 = XF86AudioStop
| keycode 174 = XF86AudioLowerVolume
| keycode 176 = XF86AudioRaiseVolume
| keycode 178 = XF86HomePage
| keycode 223 = XF86Standby
| keycode 229 = XF86Search
| keycode 230 = XF86Favorites
| keycode 231 = XF86Refresh
| keycode 232 = XF86Stop
| keycode 233 = XF86Forward
| keycode 234 = XF86Back
| keycode 235 = XF86MyComputer
| keycode 236 = XF86Mail
| keycode 237 = XF86AudioMedia
| 
\----

I get the following in my kernel logs when I press XF86AudioMedia or
XF86Refresh. And the window manager doesn't do anything i.e it doesn't
start XMMS or reload the page under the browser

atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x120, on isa0060/serio0) released.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) pressed.
atkbd.c: Unknown key (set 2, scancode 0x150, on isa0060/serio0) released.

Also when I press XF86AudioLowerVolume, I get the same behaviour as
XF86HomePage i.e another instance of the browser is started. All other keys
work fine.

Can someone help me with this annoying problem ? Is there any package that
I should upgrade ? Have the keycodes for this keyboard changed with the new
kernel or have I miscompiled the kernel ? None of these problems occur with
Linux-2.4.19.

I am not on this list. So please CC me on any replies.

-kitty.

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
