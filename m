Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263460AbTC2Uwf>; Sat, 29 Mar 2003 15:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbTC2Uwf>; Sat, 29 Mar 2003 15:52:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:62371 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S263460AbTC2Uwe>;
	Sat, 29 Mar 2003 15:52:34 -0500
Date: Sat, 29 Mar 2003 16:03:51 -0500 (EST)
From: war <war@lucidpixels.com>
X-X-Sender: war@p300
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.20 Raid Bug?
Message-ID: <Pine.LNX.4.51.0303291603230.2530@p300>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

157 processes: 156 sleeping, 1 running, 0 zombie, 0 stopped
CPU states:   6.5% user  22.2% system   0.4% nice   0.0% iowait  70.7%
idle
Mem:   386084k av,  122692k used,  263392k free,       0k shrd,    3608k
buff
        19668k active,              89324k inactive
Swap:  514072k av,       0k used,  514072k free                   52456k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
  526 war       17   0  1072 1068   760 R    12.1  0.2   0:00   0 top
  306 war       10   0   712  712   548 S     0.8  0.1   0:00   0 frox
  309 war       10   0   700  700   548 S     0.8  0.1   0:00   0 frox
    1 root       8   0   216  216   184 S     0.0  0.0   0:08   0 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 keventd
    3 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 kapmd
    4 root      19  19     0    0     0 SWN   0.0  0.0   0:00   0
ksoftirqd_CPU
    5 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 kswapd
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 bdflush
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00   0 kupdated
    8 root     18446744073709551615 -20     0    0     0 SW<   0.0  0.0
0:00 [mdrecoveryd]


I guess I'll use LVM.

