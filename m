Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRJCLlX>; Wed, 3 Oct 2001 07:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273203AbRJCLlN>; Wed, 3 Oct 2001 07:41:13 -0400
Received: from [200.248.92.2] ([200.248.92.2]:18195 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S273176AbRJCLlA>; Wed, 3 Oct 2001 07:41:00 -0400
Message-Id: <200110031143.IAA16823@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: linux-kernel@vger.kernel.org
Subject: kswapd kernel 2.4.9
Date: Wed, 3 Oct 2001 08:39:20 -0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running kernel 2.4.9 under a DELL 8450 with 8xP-III  and 10GB RAM. 
Yesterday a run a BIG   I/O, and when this process run, my cached goes to 9GB 
and the kswapd is using 100% of one cpu after that.

my /proc/meminfo

        total:    used:    free:  shared: buffers:  cached:
Mem:  1957650432 1946705920 10944512        0 392224768 1218093056
Swap: 1073733632   684032 1073049600
MemTotal:     10300376 kB
MemFree:         10688 kB
MemShared:           0 kB
Buffers:        383032 kB
Cached:        9577652 kB
SwapCached:        500 kB
Active:        3328980 kB
Inact_dirty:   6628180 kB
Inact_clean:      4088 kB
Inact_target:        8 kB
HighTotal:     9568256 kB
HighFree:         3948 kB
LowTotal:       732120 kB
LowFree:          6740 kB
SwapTotal:     1048568 kB
SwapFree:      1047900 kB


This is normal?



Thank's



Andre
