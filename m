Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263180AbSJBQop>; Wed, 2 Oct 2002 12:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJBQop>; Wed, 2 Oct 2002 12:44:45 -0400
Received: from 62-190-202-92.pdu.pipex.net ([62.190.202.92]:15364 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263180AbSJBQoo>; Wed, 2 Oct 2002 12:44:44 -0400
Date: Wed, 2 Oct 2002 17:58:37 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210021658.g92Gwbdg000900@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Freaky 2.5.40 keyboard behavior
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, this is a really surreal problem:

I am using a Japanese AT keyboard, (an IBM 94X1110), with 2.5.40, and noticed entries like these in the syslog:

Oct  2 17:26:00 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0xb6, on
isa0060/serio0) pressed.
Oct  2 17:50:22 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0xa7, on
isa0060/serio0) pressed.
Oct  2 17:50:22 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0xa3, on
isa0060/serio0) pressed.
Oct  2 17:50:22 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0xa4, on
isa0060/serio0) pressed.
Oct  2 17:50:35 darkstar kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, on
isa0060/serio0) pressed.

The funny thing is, I cannot reproduce them by pressing any single key - even the Henkaku/Zenkaku key, which is about the most non-standard compared to a U.K. keyboard, (the kana shift keys are mapped to space bar), doesn't report anything odd.

However, I can reproduce it by banging repeatedly on 't', 'h', '@', and ';'.

Any idea at all what is causing this?  By the way, I have the Russian keymap loaded, because it fits this keyboard better than the Japanese keymap, (this is a weird keyboard, incase you haven't guessed).

Sayonara :-)

John.
