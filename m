Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTIJEry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTIJEry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:47:54 -0400
Received: from mta5.algx.net ([67.92.168.234]:53303 "EHLO chimta04.algx.net")
	by vger.kernel.org with ESMTP id S264527AbTIJErw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:47:52 -0400
Date: Tue, 09 Sep 2003 23:52:43 -0500
From: Tony Jones <sir_tez@softhome.net>
Subject: 2.6.0-test4-mm5 and Warcraft III - WineX
To: linux-kernel@vger.kernel.org
Message-id: <1063169563.21739.1.camel@thelight.sir-tez.org>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my testing of recent kernels 2.6.0-test5 and 2.6.0-test4-mm4 (mm6
wouldn't cooperate with X for some reason and I didn't do much
investigation) I've experied an easily replicable and highly annoying
problem with Warcraft III and WineX 3.1 (prebuilt).

After playing 1 or 2 games, or leaving the game idle in the chat room,
the sound will eventually start to stutter and chop badly.  In the
presence of this incredibly bad sound, the mouse and game respond just
fine (kudos to the scheduler on that point).  Considering the game is
played in "real-time" and is full of audio cues I hate to imagine that
Con's scheduler will be the "official" scheduler of 2.6 without having
this issue addressed.

The kernels I use are tainted with nvidia's video drivers, 1.0.4496.  

Nick's scheduler in 2.6.0-test4-mm5 seems to be the only thing capable
of correcting this problem.  In general operation, mm5's scheduler
seems better at handling about everything I threw at it, with a rare
xmms skip once in a week of use.

I'm not a developer but I'd love some feedback and or questions to
help figure out why this happens with Con's scheduler patches in mm4
and test5 to help improve 2.6.0 altogether.

Other stats:  gcc 3.2.3, AMD Athlon XP 2100+, 512MB RAM, ATA 100
drive, GF4 Ti4200.   I'll also post CFLAGS upon request.

