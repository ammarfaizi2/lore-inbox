Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbTBSWBO>; Wed, 19 Feb 2003 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTBSWBO>; Wed, 19 Feb 2003 17:01:14 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:640 "EHLO bilbo.tmr.com")
	by vger.kernel.org with ESMTP id <S262040AbTBSWBN>;
	Wed, 19 Feb 2003 17:01:13 -0500
Date: Wed, 19 Feb 2003 17:11:09 -0500 (EST)
From: davidsen <root@tmr.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.61-ac1] set_rtc_mss back
Message-ID: <Pine.LNX.4.44.0302191658080.1167-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

set_rtc_mmss: can't update from 5 to 55

I used to get this message in early 4.5.5x kernels, and there was some 
discussion which I can't easily track right now, then it went away. This 
system was up for 25 days on 2.5.59+patches, and the console showed none 
of these since boot.

I just built 2.5.61-ac1 and booted. The good news is that it is up and 
looks reasonably stable (rebuilt the kernel). Bad news is that this 
message is coming out often enough to make the console hard to use.

No details, I assume that whatever fixed this before will fix it again, 
just so someone knows it is happening again.

Humm, the sym53c8xx driver didn't see the controller, that's why all my 
SCSI stuff is missing. I'll check that myself, but if others are having 
problems let Alan know. I copied the config for 2.5.59 and did oldconfig, 
all should be the same.

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


