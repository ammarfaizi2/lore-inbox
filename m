Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131586AbQLLMPa>; Tue, 12 Dec 2000 07:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131659AbQLLMPU>; Tue, 12 Dec 2000 07:15:20 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:37591 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131586AbQLLMPL>; Tue, 12 Dec 2000 07:15:11 -0500
Date: Tue, 12 Dec 2000 06:44:32 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12 not liking high disk i/o
Message-ID: <Pine.LNX.4.30.0012120636480.1053-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

Any one else experiencing problems when they do lots of disk activity
in test12?

I was able to grab the tail end of an oops. Probably not too usefull.

Code: 89 42 04 89 10 b8 01 00 00 00 07 43 04 00 00 00 00 c7 03 00
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing.

If I Alt+SysRq+s I get more oops (only tails again) and if I do it
enough times it hits a BUG and reboots immediately.
-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
