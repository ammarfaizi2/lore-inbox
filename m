Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbTJAQ4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTJAQ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:56:43 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:15328 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261515AbTJAQ4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:56:41 -0400
Date: Wed, 1 Oct 2003 18:56:37 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: linux-current: atkbd.c: Unknown key pressed
Message-ID: <20031001165637.GA16565@stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,
I have a Sun type 5 keyboard connected via a selfbuild sun to pc
keyboard converter connected to my PS/2 port. I am running a kernel
compiled from the Linux current bitkeeper repostory.

When I press some buttons on my sun type 5 keyboard I get the following
in the kern.log:

SunAudioLowerVolume:
Oct  1 18:36:59 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x57, data 0x6e, on isa0060/serio0).

SunAudioRaiseVolume:
Oct  1 18:38:09 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x48, data 0x6c, on isa0060/serio0).

Anykey:
Oct  1 18:38:38 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x40, data 0x6b, on isa0060/serio0).

Again:
Oct  1 18:38:53 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x19, data 0x71, on isa0060/serio0).

Props:
Oct  1 18:39:05 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x39, data 0x72, on isa0060/serio0).

Copy:
Oct  1 18:39:24 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x5c, data 0x75, on isa0060/serio0).

Open:
Oct  1 18:39:38 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x5f, data 0x76, on isa0060/serio0).

Compose:
Oct  1 18:40:00 excalibur kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x2f, data 0x5d, on isa0060/serio0).

all other keys work, but Help has a different key code (keycode 247):

Old keycodes:

keycode 93  = SunAudioMute
keycode 101 = Multi_key
keycode 113 = Mode_switch
keycode 118 = SunAudioLowerVolume
keycode 116 = SunAudioRaiseVolume
keycode 120 = SunStop
keycode 121 = Redo
keycode 122 = SunProps
keycode 123 = SunUndo
keycode 124 = SunFront
keycode 125 = SunCopy
keycode 126 = SunOpen
keycode 127 = SunPaste
keycode 128 = SunFind
keycode 129 = SunCut
keycode 130 = Help

An other thing I noticed, is that MAGIC SYSRQ is now working with my
Sunkeyboard (it wasn't working with linux-stable).

Greetings,
	Thomas
