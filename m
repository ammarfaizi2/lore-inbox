Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTITUgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbTITUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:36:37 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:64898
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261956AbTITUgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:36:35 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Keyboard oddness.
Date: Sat, 20 Sep 2003 16:33:22 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309201633.22414.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've mentioned my keyboard repeat problems before.  I grepped through the logs 
and found a whole bunch of these type messages:

Aug 17 05:28:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Aug 19 09:06:51 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x8e, 
on isa0060/serio0) pressed.
Aug 22 04:33:36 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcd, 
on isa0060/serio0) pressed.
Aug 22 10:29:45 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x9f, 
on isa0060/serio0) pressed.
Aug 22 10:43:45 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x9f, 
on isa0060/serio0) pressed.
Aug 24 00:29:57 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Aug 26 19:46:44 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcd, 
on isa0060/serio0) pressed.
Aug 26 22:18:52 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1cb, 
on isa0060/serio0) pressed.
Aug 26 22:36:32 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Aug 28 05:18:28 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x97, 
on isa0060/serio0) pressed.
Aug 28 07:28:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Sep  1 19:18:52 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcb, 
on isa0060/serio0) pressed.
Sep  1 19:50:52 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  2 00:52:01 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x94, 
on isa0060/serio0) pressed.
Sep  2 13:37:52 localhost kernel: atkbd.c: Unknown key (set 0, scancode 0xfc, 
on isa0060/serio1) pressed.
Sep  2 13:37:52 localhost kernel: atkbd.c: Unknown key (set 0, scancode 0xfc, 
on isa0060/serio1) pressed.
Sep  2 22:31:25 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, 
on isa0060/serio0) pressed.
Sep  3 04:58:47 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Sep  3 14:26:41 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  3 22:03:33 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  3 22:06:53 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  3 22:27:33 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x9e, 
on isa0060/serio0) pressed.
Sep  4 16:00:48 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, 
on isa0060/serio0) pressed.
Sep  5 00:29:00 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  5 00:42:40 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcd, 
on isa0060/serio0) pressed.
Sep  5 00:43:40 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x92, 
on isa0060/serio0) pressed.
Sep  5 00:52:00 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Sep  5 00:54:40 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1d0, 
on isa0060/serio0) pressed.
Sep  5 01:49:00 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  5 02:24:40 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  5 03:06:00 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xcd, 
on isa0060/serio0) pressed.
Sep  5 14:36:01 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.
Sep  5 14:37:42 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xae, 
on isa0060/serio0) pressed.
Sep  5 15:23:42 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x90, 
on isa0060/serio0) pressed.
Sep  5 15:38:22 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x97, 
on isa0060/serio0) pressed.
Sep  5 16:03:42 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0x1cb, 
on isa0060/serio0) pressed.
Sep  5 18:16:22 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd0, 
on isa0060/serio0) pressed.

(There's more, it just goes on and on...)

Any clues?  (Thinkpad iSeries...  1200, I think.)

Rob
