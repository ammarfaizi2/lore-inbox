Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290009AbSBFE3a>; Tue, 5 Feb 2002 23:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290017AbSBFE3U>; Tue, 5 Feb 2002 23:29:20 -0500
Received: from oenone.stormclouds.net ([195.11.8.245]:22030 "EHLO
	oenone.stormclouds.net") by vger.kernel.org with ESMTP
	id <S290009AbSBFE3K>; Tue, 5 Feb 2002 23:29:10 -0500
Date: Wed, 6 Feb 2002 04:29:22 +0000
From: paule <paule@ilu.vu>
To: linux-kernel@vger.kernel.org
Subject: Swap issue
Message-ID: <20020206042922.GA89628@oenone.stormclouds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having just upgraded slackware8.0 (2.2 kernel)
to using 2.5.2, (2.5.3 patch install failed looking for malloc.h)
Im unable to use swap, despite it showing a success.

# dd if=/dev/zero of=/swap/swapfile bs=1024 count=131072
13107+0 records in
13107+0 records out
# mkswap -c /swap/swapfile
Setting up swapspace version 1, size = 13414400 bytes
# swapon /swap/swapfile
swapon: /swap/swapfile: Success
# cat /proc/meminfo
MemTotal:        61720 kB
MemFree:          1896 kB
MemShared:           0 kB
Buffers:          8300 kB
Cached:          30712 kB
SwapCached:          0 kB
Active:          25316 kB
Inactive:        19688 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        61720 kB
LowFree:          1896 kB
SwapTotal:           0 kB
SwapFree:            0 kB

I've tried various kernel configurations, and it just doesn't
want to work.

(It was however working under 2.2.x)

Any ideas?

TIA,
--
Paul Edwards
paule@ilu.vu
