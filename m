Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261531AbREOVAS>; Tue, 15 May 2001 17:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbREOVAL>; Tue, 15 May 2001 17:00:11 -0400
Received: from www.topmail.de ([212.255.16.226]:57995 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261516AbREOU70>;
	Tue, 15 May 2001 16:59:26 -0400
From: mirabilos <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: gcc3 fixed?, sb/ess1869 freeze
Message-Id: <20010515205300.53325A5A948@www.topmail.de>
Date: Tue, 15 May 2001 22:53:00 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found a CONFIG_RWSEM_GENERIC_SPINLOCK
(I give in that I really do not have any
clue about it) which is defined in
arch/i386/config.in to be the opposite of
CONFIG_RWSEM_XCHGADD_ALGORITHM.
It is defined n/y for i386 and y/n for others.

Because I even was unable to compile with Petr
Vandrovec's suggested patch I simply added the
patch below, set the config option to n/y and
recompiled.
This is written in telnet under that kernel ;-)

gcc-3.0: snapshot 20010514

kernel: 2.4.4-ac9

uptime:   8:56pm  up 39 min,  2 users,  load average: 0.08, 0.02, 0.01
(not much, but working)

If I am wrong to do this please correct me (no
need to Cc: as I am on the list).

SECOND, I have a Siemens Mobile 510 with ESS1869 onboard,
configured to soundblaster 220/5/1 (recording 0).
I can record and playback .au with dd and cat respectively
with no problems (I didn't simultaneously yet), but when
I press a key during playback it freezes nearly instantly
(there is a hardly noticable delay, 0.05 sec or so).
I have no clue why.
Information on request, again, no need to Cc: me.

Thanks to you gurus,
and everything else (including reiser) works very fine.

-mirabilos
-- 
by telnet
