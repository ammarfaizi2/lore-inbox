Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266840AbRGFUwA>; Fri, 6 Jul 2001 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266843AbRGFUvv>; Fri, 6 Jul 2001 16:51:51 -0400
Received: from moat2.centtech.com ([206.196.95.21]:36783 "EHLO
	prox.centtech.com") by vger.kernel.org with ESMTP
	id <S266840AbRGFUvg>; Fri, 6 Jul 2001 16:51:36 -0400
Message-ID: <3B4624C9.18290280@centtech.com>
Date: Fri, 06 Jul 2001 15:51:21 -0500
From: Eric Anderson <anderson@centtech.com>
Reply-To: anderson@centtech.com
Organization: Centaur Technology
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.14-5.0smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BIGMEM kernel question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am currently running a RedHat 7.1 machine with the 2.4.3-12enterprise
kernel.  My machine has 4GB of RAM, and 6GB of swap.  It appears that I
can only allocate 2930 MB (using heapc_linux and other programs).  What
do I need to do to get Linux to allow allocation of all available memory
(up to the 4GB)?  All the FAQs I have seen so far explain only how to
get Linux to recognize the 4GB, and not use it all in one process.  Any
help would be greatly appreciated.

Please CC this email address in any responses.

Thanks!
Eric Anderson

-------------------------
Here is my /proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  3824029696 69316608 3754713088        0  3624960 20070400
Swap: 2145296384     4096 2145292288
MemTotal:      3734404 kB
MemFree:       3666712 kB
MemShared:           0 kB
Buffers:          3540 kB
Cached:          19600 kB
Active:          22328 kB
Inact_dirty:       812 kB
Inact_clean:         0 kB
Inact_target:     4664 kB
HighTotal:     2883036 kB
HighFree:      2850584 kB
LowTotal:       851368 kB
LowFree:        816128 kB
SwapTotal:     6289320 kB
SwapFree:      6289316 kB



-- 
-------------------------------------------------------------------------------
Eric Anderson	 anderson@centtech.com    Centaur Technology    (512)
418-5700
For every complex problem, there is a solution that is simple, neat, and
wrong.
-------------------------------------------------------------------------------
