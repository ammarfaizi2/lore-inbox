Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBEGh4>; Mon, 5 Feb 2001 01:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129065AbRBEGhq>; Mon, 5 Feb 2001 01:37:46 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:39248 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129035AbRBEGhg>;
	Mon, 5 Feb 2001 01:37:36 -0500
Message-ID: <3A7E49C6.BE283336@sgi.com>
Date: Sun, 04 Feb 2001 22:35:50 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.2-pre1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.x Shared memory question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another oddity -- I notice things taking alot more memory
in 2.4.  This coincides with 'top' consistently showing I have 0 shared
memory.  These two observations would have me wondering if I
have somehow misconfigured my system to disallow sharing.  Note
that /proc/meminfo also shows 0 shared memory:

        total:    used:    free:  shared: buffers:  cached:
Mem:  525897728 465264640 60633088        0 82145280 287862784
Swap: 270909440        0 270909440
MemTotal:       513572 kB
MemFree:         59212 kB
MemShared:           0 kB
Buffers:         80220 kB
Cached:         281116 kB
Active:          22340 kB
Inact_dirty:    338996 kB
Inact_clean:         0 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513572 kB
LowFree:         59212 kB
SwapTotal:      264560 kB
SwapFree:       264560 kB 

Not that it seems unrelated, but I do have filesystem type shm 
mounted on /dev/shm as suggested for POSIX shared memory.


-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338



-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
