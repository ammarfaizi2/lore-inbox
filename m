Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBPKUj>; Sun, 16 Feb 2003 05:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBPKUj>; Sun, 16 Feb 2003 05:20:39 -0500
Received: from kim.it.uu.se ([130.238.12.178]:45961 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S266175AbTBPKUi>;
	Sun, 16 Feb 2003 05:20:38 -0500
Date: Sun, 16 Feb 2003 11:30:34 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302161030.LAA18138@kim.it.uu.se>
To: vojtech@suse.cz
Subject: PS/2 mouse problems with 2.5 input drivers
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

The 2.5 input layer sometimes mishandles my PS/2 mice.

On my Dell Latitude, the external PS/2 mouse works, but the
sensitivity is way down compared to the 2.4 PS/2 driver.
(As in: I have to move the mouse much further with 2.5 to
move the mouse pointer a given distance on the screen.)

On resuming after suspend (apm), the mouse goes bonkers.
Even the tiniest mouse movement or key press seems to generate
too many and bogus events (it wreaks havoc in my xterm), the
PS/2 interrupt count goes up rapidly, and I get "psmouse.c:
Lost synchronization, throwing N bytes away." (for N in 1-3).

This is the last major HW-related problem I have with 2.5, and
it basically makes it impossible for me to use 2.5 on my laptop.

(Also, it seems the input layer detects most of my mice as
"ImPS/2 Generic Wheel Mouse", even though only one of them
is a wheel mouse. I don't know if that's a problem.)

/Mikael
