Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAENnw>; Fri, 5 Jan 2001 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAENnm>; Fri, 5 Jan 2001 08:43:42 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:8205 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S129183AbRAENnd>;
	Fri, 5 Jan 2001 08:43:33 -0500
Date: Fri, 5 Jan 2001 07:41:31 -0600 (CST)
From: Brad Hartin <bhartin@satx.rr.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18: do_try_to_free_pages
Message-ID: <Pine.LNX.4.21.0101050732330.10424-100000@osprey.hartinhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recieved the following messages from the kernel yesterda morning.  It
doesn't appear that any running programs actually died, or ran out of
memory (128M physical/ 256M swap, only about 150M total or so in use when
I got back on the machine.

As a side note, during times of what I consider only moderate system
activity (burning a CD while xmms playing and doing stuff in netscape, for
example) I've had some system freezes.  While under X, everything freezes
solid, mouse pointer and all.  System is completely inaccessable.  After
about 2 minutes or so, everything begins responding again.

These problems began only when I moved to kernel 2.2.18.  I also have
Reiserfs 3.5.29 patched in, and in use.

System is a K6-2/450, 128MB ram, Matsonic 6120S motherboard, ALi chipset.
Just email me for any more details that are needed.

dmesg:

Jan  4 00:06:05 osprey kernel: VM: do_try_to_free_pages failed for X...
Jan  4 00:06:06 osprey last message repeated 6 times
Jan  4 00:06:06 osprey kernel: VM: do_try_to_free_pages failed for klogd...
Jan  4 00:06:07 osprey last message repeated 15 times
Jan  4 00:06:07 osprey kernel: VM: do_try_to_free_pages failed for kfm...
Jan  4 00:06:07 osprey last message repeated 14 times
Jan  4 00:06:07 osprey kernel: VM: do_try_to_free_pages failed for maudio...
Jan  4 00:06:07 osprey last message repeated 4 times
Jan  4 00:06:07 osprey kernel: VM: do_try_to_free_pages failed for xmms...
Jan  4 00:06:08 osprey last message repeated 10 times
Jan  4 00:06:08 osprey kernel: VM: do_try_to_free_pages failed for maudio...
Jan  4 00:06:08 osprey kernel: VM: do_try_to_free_pages failed for klogd...
Jan  4 00:06:09 osprey last message repeated 14 times
Jan  4 00:06:09 osprey kernel: VM: do_try_to_free_pages failed for identd...
Jan  4 00:06:09 osprey last message repeated 4 times
Jan  4 00:06:09 osprey kernel: VM: do_try_to_free_pages failed for maudio...
Jan  4 00:06:09 osprey last message repeated 10 times
Jan  4 00:06:09 osprey kernel: VM: do_try_M: do_try_to_free_pages failed for syslogd...
Jan  4 00:06:09 osprey kernel: VM: do_try_to_free_pages failed for init...
Jan  4 00:06:10 osprey last message repeated 14 times
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for identd...
Jan  4 00:06:10 osprey last message repeated 14 times
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for fetchmail...
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for xmms...
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for X...
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for maudio...
Jan  4 00:06:10 osprey kernel: VM: do_try_to_free_pages failed for X...
Jan  4 00:06:11 osprey last message repeated 14 times
Jan  4 00:06:11 osprey kernel: VM: do_try_to_free_pages failed for xmms...
Jan  4 00:06:11 osprey last message repeated 14 times
Jan  4 00:06:11 osprey kernel: VM: do_try_to_free_pages failed for wpexc...
Jan  4 00:06:12 osprey last message repeated 14 times
Jan  4 00:06:12 osprey kernel: VM: do_try_to_free_pages failed for fetchmail...
...............

Messages continue for all programs running at the time, and end with:

...............
Jan  4 00:06:16 osprey kernel: VM: do_try_to_free_pages failed for gpm...
Jan  4 00:06:17 osprey last message repeated 13 times
Jan  4 00:06:17 osprey kernel: VM: do_try_to_free_pages failed for crond...
Jan  4 00:06:17 osprey last message repeated 14 times                                         


-----------------------------------------
Brad Hartin - bhartin@strafco.com
Communications Administrator
Straus-Frank Enterprises Limited
Carquest retail/wholesale distributor for
areas in TX, OK, LA, AR, NM, and KS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
