Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbTCIWf1>; Sun, 9 Mar 2003 17:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262654AbTCIWf0>; Sun, 9 Mar 2003 17:35:26 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:4
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S262649AbTCIWfY>; Sun, 9 Mar 2003 17:35:24 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
Date: Sun, 9 Mar 2003 17:49:40 -0500
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [BUG][2.5.64bk4] Weird problem with 2 PCs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200303091749.40739.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't have an oops/panic to give because the box won't dump one on this 
issue.

I have two PCs, an A7M266-D Athlon MP 2000+ and an IBM 300PL 6892-N2U PIII 
(Katmai) 450Mhz.  If I leave the IBM machine on for a few hours or so, it's 
idle and just handling my mail/dns.  The problem happens when I turn on the 
A7M266-D the other box locks up and reboots (due to panic=80). ksyslog/klogd 
aren't dumping any oopes to my logfile so I'm unable to capture the bug.

1. The PCs are connected via a router to my network.

2. The PCs are connected via serial port together (possibly causing the oops 
with interrupts?)

Note, when I turn off and on the A7M266-D the IBM will not panic. It's only 
when the IBM is powered on for a few hours (if thats any help in narrowing 
down things).

When It did panic, It reported __run_timers and a held spinlock by 
linux/timer.c but the EIP was 00000000 (garbage). 

Anyone else noticing strange things like this? This is really annoying :-(

