Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274537AbRITP2S>; Thu, 20 Sep 2001 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274539AbRITP2J>; Thu, 20 Sep 2001 11:28:09 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:3844 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274537AbRITP1v> convert rfc822-to-8bit; Thu, 20 Sep 2001 11:27:51 -0400
X-Envelope-From: mmokrejs
Posted-Date: Thu, 20 Sep 2001 17:28:14 +0200 (MET DST)
Date: Thu, 20 Sep 2001 17:28:14 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Perf improvements in 2.4.10pre12aa1
In-Reply-To: <Pine.OSF.4.21.0109201243080.24552-100000@prfdec.natur.cuni.cz>
Message-ID: <Pine.OSF.4.21.0109201458230.24552-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001, Martin MOKREJ© wrote:

Hi,
  stupid to reply to myself, but ...

> linux-2.4.10-pre12
> dbench 16: Throughput 67.8566 MB/sec (NB=84.8208 MB/sec  678.566 MBit/sec)  16 procs

> linux-2.4.10-pre12aa1
> dbench 16: Throughput 141.659 MB/sec (NB=177.074 MB/sec  1416.59 MBit/sec)  16 procs

Hmm, now after few ours of running mysql tests I have (while still running):
linux-2.4.10-pre12aa1
dbench 16: Throughput 41.1484 MB/sec (NB=51.4356 MB/sec  411.484 MBit/sec)  16 procs

Load so far up to 7 (yesterday even 16, but thatt dependes of course while
test is currently being run).


And, well oh NO!, it's here again:
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012f852

How can I find what mean those (gfp=0x20/0) from c012f852 ?
Current situation:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054412800 845828096 208584704        0  3731456 476766208
Swap: 2147467264 61083648 2086383616
MemTotal:      1029700 kB
MemFree:        203696 kB
MemShared:           0 kB
Buffers:          3644 kB
Cached:         464100 kB
SwapCached:       1492 kB
Active:         318896 kB
Inactive:       150340 kB
HighTotal:      131072 kB
HighFree:         2044 kB
LowTotal:       898628 kB
LowFree:        201652 kB
SwapTotal:     2097136 kB
SwapFree:      2037484 kB

  5:29pm  up  4:58,  3 users,  load average: 5.61, 6.04, 6.32

-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany



