Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132118AbRASQjn>; Fri, 19 Jan 2001 11:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRASQje>; Fri, 19 Jan 2001 11:39:34 -0500
Received: from w146-179.echostar.com ([205.172.146.179]:17938 "EHLO
	linux0.echostar.com") by vger.kernel.org with ESMTP
	id <S132118AbRASQjS>; Fri, 19 Jan 2001 11:39:18 -0500
Message-ID: <3A686DB1.8096DA0D@echostar.com>
Date: Fri, 19 Jan 2001 09:39:13 -0700
From: "Ian S. Nelson" <ian.nelson@echostar.com>
Reply-To: ian.nelson@echostar.com
Organization: Echostar
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How come top and /proc/meminfo on 2.4.0 says 0K shared?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is this a bug?

We have a number of machines running 2.4.0 and /proc/meminfo says we're
sharing no memory.  top says that also, probably because it just reads
/proc/meminfo, or at least I assume that's how it works.    All the
individual procs show the memory they are sharing though.


thanks,
Ian


Here is /proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  261734400 251297792 10436608        0 12423168 124805120
Swap: 279650304 24297472 255352832
MemTotal:       255600 kB
MemFree:         10192 kB
MemShared:           0 kB
Buffers:         12132 kB
Cached:         121880 kB
Active:          91308 kB
Inact_dirty:     38136 kB
Inact_clean:      4568 kB
Inact_target:     1436 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255600 kB
LowFree:         10192 kB
SwapTotal:      273096 kB
SwapFree:       249368 kB


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
