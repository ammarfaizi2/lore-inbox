Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313054AbSDCEF0>; Tue, 2 Apr 2002 23:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313056AbSDCEFQ>; Tue, 2 Apr 2002 23:05:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43281 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313054AbSDCEFN>; Tue, 2 Apr 2002 23:05:13 -0500
Date: Tue, 2 Apr 2002 23:02:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Ext2 vs. ext3 recovery after crash
Message-ID: <Pine.LNX.3.96.1020402225256.9671A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a laptop (Dell Inspiron C600) which, like most Dell laptops,
crashes every time I log out of X. On some occasions on reboot I get a
message about replaying the journal, while occasionally I get a full ext2
style multi-pass 12 minute recovery. I don't see why the ext3 isn't always
used, I know it's going to crash, I always do a sync and wait ten seconds
for journal writes, etc, to take place.

I have tried all the usual, Redhat kernels, 2.4.17, 2.4.19, -aa, -ac,
disable io-apc, disable apic, disable all power management, boot noapic
(someone swore it wasn't enough to pull it out of the kernel ;-) all
producing about 20% chance of slow reboot.

Since I would have to spend my own money to replace this device with
something functional before 2003, is there something I'm missing about why
it does the slow cleanup? It was Redhat 7.1, updated fsutils and modutils,
pcmcia packed, etc, to latest of Mar 15 this year, in case that matters.
All kernels have ext3 compiled in, all work "most of the time."

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

