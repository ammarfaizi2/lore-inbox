Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266753AbRGFQy3>; Fri, 6 Jul 2001 12:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266758AbRGFQyT>; Fri, 6 Jul 2001 12:54:19 -0400
Received: from post2.fast.net ([209.92.1.22]:50074 "EHLO post2.fast.net")
	by vger.kernel.org with ESMTP id <S266753AbRGFQyG>;
	Fri, 6 Jul 2001 12:54:06 -0400
Date: Fri, 6 Jul 2001 12:52:49 -0400 (EDT)
From: William Earnest <wde@fast.net>
X-X-Sender: <wde@hulk.wde.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: New Machine Check problem
Message-ID: <Pine.LNX.4.31.0107061238290.21886-100000@hulk.wde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Have a system with an Asus P5A motherboard, Classic Pentium-200
underclocked to 180 MHz, and 196 MB of real memory. Up through 2.4.4 it
has performed flawlessly. Kernels 2.4.5 and 2.4.6 will not complete the
boot.

	Boot looks normal through the F0 0F check, and the message about
"Intel old style machine check architecture supported.". It then spews a
semi-infinite stream of:
"CPU#0: Machine Check Exception:  0x  10C1D0 (type 0x       9)."
lines (until at least the reset button is pressed. I caught this by
setting up for serial console at 300bps, which slowed the screen enough
to make notes by hand.

	This new check in bluesmoke.c is causing severe indigestion to a
formerly reliable system. Suggestions appreciated, and glad to run any
tests, but will be leaving Monday Jul. 9 for 2 weeks away from
computers.

    Bill Earnest    wde@fast-dot-net    Linux Powered    Allentown, PA, USA
Computers, like air conditioners, work poorly with Windows open.

