Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbSJGXK7>; Mon, 7 Oct 2002 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263734AbSJGXJ0>; Mon, 7 Oct 2002 19:09:26 -0400
Received: from members.cotse.com ([216.112.42.58]:39558 "EHLO cotse.com")
	by vger.kernel.org with ESMTP id <S263497AbSJGXHB>;
	Mon, 7 Oct 2002 19:07:01 -0400
Message-ID: <YWxhbg==.a03486974c45631ab208f8963158f56d@1034032442.cotse.net>
Date: Mon, 7 Oct 2002 19:14:02 -0400 (EDT)
X-Abuse-To: abuse@cotse.com
X-AntiForge: http://packetderm.cotse.com/antiforge.php
Subject: DRI not working
From: "Alan Willis" <alan@cotse.net>
To: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  For quite a few kernel versions now,.. DRI has not been working.  I see
that there is a lot of DRI syncing going on, so someone should probably
check this out, as it is still broken as of linux 2.5.41.  Log, dmesg and
config are attached, something about not enough memory for dcache.


-alan

P.S: This may also be useful:

alan@aries:~$ cat /proc/meminfo
MemTotal:       253148 kB
MemFree:         68648 kB
MemShared:           0 kB
Buffers:          9500 kB
Cached:          86804 kB
SwapCached:          0 kB
Active:          36264 kB
Inactive:       124924 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       253148 kB
LowFree:         68648 kB
SwapTotal:     1028152 kB
SwapFree:      1028152 kB
Dirty:              48 kB
Writeback:           0 kB
Mapped:          99720 kB
Slab:             9524 kB
Committed_AS:   235176 kB
PageTables:       1116 kB
ReverseMaps:     56213



