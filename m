Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSIBDSL>; Sun, 1 Sep 2002 23:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIBDSL>; Sun, 1 Sep 2002 23:18:11 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:37586 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S318213AbSIBDSJ>; Sun, 1 Sep 2002 23:18:09 -0400
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Con Kolivas <conman@kolivas.net>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Date: Mon, 2 Sep 2002 05:24:41 +0200
User-Agent: KMail/1.4.3
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>, Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209020524.41937.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Con,

I have your ck5_2.4.19.patch with some additional stuff running fine on my 
dual Athlon MP 1900+, MSI K7D Master-L, 1 GB DDR-SDRAM 266 CL.

ck5 + some 2.4.19-jam0 stuff (Andrea, Ingo, others)

000_e100-2.1.6 (-AA)
000_e1000-4.3.2 (-AA)
00_387-fix-1
10-module-size-checks
12-memparam
24-config-nr_cpus
30-smptimers-A0
30_irq-balance-12
31-nr_requests
70-i2c-2.6.4
71-sensors-2.6.4

2.4.19.pending ReiserFS stuff
linux-2.4.19-ntfs-2.1.0a.patch
page_color-2.4.19-pre10-1 (Page coloring)

I'm from Robert Love's "side" and have his stuff running on top of 2.4 for 
nearly one year, now.

The first bench I try is latencytest-0.42-png all the time.
http://www.gardena.net/benno/linux/audio/

Then I try dbench (Yes, I know Rik ;-) to see the GREAT speed of Andrea 
Arcangeli's -AA VM which improve noticeably with the Preemption patch.
O(1) gave some additional speed, too.

What about Robert's nice Preemption Latency Measurement Tool?
http://www.tech9.net/rml/linux

I tried it many times to gave Robert some feedback.

Regards and good work!

-Dieter


-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel at hamburg.de (replace at with @)


