Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130346AbQLOOux>; Fri, 15 Dec 2000 09:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbQLOOuo>; Fri, 15 Dec 2000 09:50:44 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:21187 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S130346AbQLOOuc>; Fri, 15 Dec 2000 09:50:32 -0500
Date: Fri, 15 Dec 2000 16:19:26 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Joseph Cheek <joseph@cheek.com>
Cc: linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: Re: test12: eth0 trasmit timed out after one hour uptime
Message-ID: <20001215161926.D829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A37FFC9.19F05305@cheek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A37FFC9.19F05305@cheek.com>; from joseph@cheek.com on Wed, Dec 13, 2000 at 03:01:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2000 at 03:01:29PM -0800, Joseph Cheek wrote:
> Dec 13 14:51:46 sanfrancisco kernel: NETDEV WATCHDOG: eth0: transmit
> timed out
> Dec 13 14:51:46 sanfrancisco kernel: eth0: transmit timed out, tx_status
> 00 status e680.
> Dec 13 14:51:46 sanfrancisco kernel:   Flags; bus-master 1, full 1;
> dirty 3306(10) current 3322(10).
> Dec 13 14:51:46 sanfrancisco kernel:   Transmit list 00000000 vs.
> c7c732a0.
> Dec 13 14:51:46 sanfrancisco kernel:   0: @c7c73200  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   1: @c7c73210  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   2: @c7c73220  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   3: @c7c73230  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   4: @c7c73240  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   5: @c7c73250  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   6: @c7c73260  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   7: @c7c73270  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   8: @c7c73280  length 8000002a
> status 8001002a
> Dec 13 14:51:46 sanfrancisco kernel:   9: @c7c73290  length 8000002a
> status 8001002a
> Dec 13 14:51:46 sanfrancisco kernel:   10: @c7c732a0  length 8000004b
> status 0001004b
> Dec 13 14:51:46 sanfrancisco kernel:   11: @c7c732b0  length 8000004b
> status 0001004b
> Dec 13 14:51:46 sanfrancisco kernel:   12: @c7c732c0  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   13: @c7c732d0  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   14: @c7c732e0  length 8000002a
> status 0001002a
> Dec 13 14:51:46 sanfrancisco kernel:   15: @c7c732f0  length 8000002a
> status 0001002a
 
I have this too since testX-Kernels are released.

I use a "3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)"
(actually two of them ;-)).

> after reboot it works fine again [i'll give it an hour...]  test12-pre8
> and before worked fine.  any ideas?

This seems to be code to debug these timeouts.

It didn't cause any harm AFICS, but I CC'ed the Author of this
code anyway.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
