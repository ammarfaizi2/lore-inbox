Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267193AbSK3AHm>; Fri, 29 Nov 2002 19:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267194AbSK3AHm>; Fri, 29 Nov 2002 19:07:42 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:7041 "EHLO
	mailrelay.tugraz.at") by vger.kernel.org with ESMTP
	id <S267193AbSK3AHl>; Fri, 29 Nov 2002 19:07:41 -0500
Date: Sat, 30 Nov 2002 01:08:40 +0100 (CET)
From: Martin Pirker <crf@sbox.tugraz.at>
X-X-Sender: crf@pluto.tugraz.at
To: linux-kernel@vger.kernel.org
Subject: cache size misdetected with 2.4.20 + P3m
Message-ID: <Pine.LNX.4.44.0211300056180.29587-100000@pluto.tugraz.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi...

just did an update from 2.4.17 to 2.4.20 + cpufreq 2.4.20-rc3-1

2.4.17:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU       933MHz
stepping        : 1
cpu MHz         : 930.254
cache size      : 512 KB
....

2.4.20:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU       933MHz
stepping        : 1
cpu MHz         : 930.255
cache size      : 32 KB


chipset (if that matters): 830M
tried with cpufreq enabled and without

Question: Where has the cache gone? Is this just wrong in /proc/cpuinfo
or are really just 32KB used? (and how to test this?)

Martin

