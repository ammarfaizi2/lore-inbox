Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSKBSox>; Sat, 2 Nov 2002 13:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSKBSox>; Sat, 2 Nov 2002 13:44:53 -0500
Received: from pmesmtp01.wcom.com ([199.249.20.1]:5370 "EHLO
	pmesmtp01.wcom.com") by vger.kernel.org with ESMTP
	id <S261344AbSKBSou>; Sat, 2 Nov 2002 13:44:50 -0500
Date: Sat, 02 Nov 2002 12:51:13 -0600
From: steve roemen <steve.roemen@wcom.com>
Subject: PS/2 mouse in 2.5.45
To: "Linux-Kernel development list (E-mail)" 
	<linux-kernel@vger.kernel.org>
Reply-to: steve.roemen@wcom.com
Message-id: <001a01c282a0$d1b280f0$e70a7aa5@WSXA7NCC106.wcomnet.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.3719.2500
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

not a big bug, but still a bug.  the mouse in 2.4.45 will freak out, and
start jumping all over the screen.

my system is a dual athlon 1800+ (tyan s2466n-4m)  the mouse is an M$
Intellimouse explorer.  I'm using the usb to PS/2 adapter.

is there a fix for this problem?


Nov  1 22:14:06 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:14:36 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:15:02 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
bytes a
way.
Nov  1 22:15:11 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:15:17 lws04 last message repeated 2 times
Nov  1 22:15:18 lws04 kernel: APIC error on CPU1: 00(02)
Nov  1 22:15:18 lws04 kernel: APIC error on CPU0: 00(02)
Nov  1 22:15:19 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
bytes a
way.
Nov  1 22:15:21 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:16:02 lws04 last message repeated 2 times
Nov  1 22:16:07 lws04 last message repeated 2 times
Nov  1 22:16:09 lws04 kernel: APIC error on CPU1: 02(02)
Nov  1 22:16:09 lws04 kernel: APIC error on CPU0: 02(02)
Nov  1 22:16:34 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:16:38 lws04 kernel: APIC error on CPU0: 02(02)
Nov  1 22:16:38 lws04 kernel: APIC error on CPU1: 02(02)
Nov  1 22:16:45 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:17:15 lws04 last message repeated 5 times
Nov  1 22:20:41 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:20:43 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:20:45 lws04 kernel: APIC error on CPU1: 02(02)
Nov  1 22:20:45 lws04 kernel: APIC error on CPU0: 02(02)
Nov  1 22:24:18 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:24:27 lws04 kernel: psmouse.c: Lost synchronization, throwing 1
bytes a
way.
Nov  1 22:25:40 lws04 kernel: psmouse.c: Lost synchronization, throwing 2
bytes a
way.

I rebooted with the noapic flag. and now I see this when the mouse freaks
out:

psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.
psmouse.c: Lost synchronization, throwing 2 bytes away.
psmouse.c: Lost synchronization, throwing 1 bytes away.


thanks

-Steve Roemen


