Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbQJ1Fa3>; Sat, 28 Oct 2000 01:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130831AbQJ1FaT>; Sat, 28 Oct 2000 01:30:19 -0400
Received: from mx1.eskimo.com ([204.122.16.48]:37650 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S129915AbQJ1FaN>;
	Sat, 28 Oct 2000 01:30:13 -0400
Date: Fri, 27 Oct 2000 22:30:09 -0700 (PDT)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: update: i21143 (tulip) and 2.2.17 (upgrade to .91-g and egcs-1.1.2 seems to have fixed it)
Message-ID: <Pine.SUN.3.96.1001027221305.9711A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update on the hang during ftp on stock Debian potato (2.2.17-pre6 IIRC)
with i21143 tulip pci ethernet:

I changed to gcc-2.91.66 (egcs-1.1.2; Debian afaik used gcc 2.7.2.3
or 2.95.2 to compile the pre-compiled vanilla distribution kernel in
potato) and upgraded the 2.2.17-pre_something kernel to the final 2.2.17
(with the .91-g tulip driver), using binutils-2.9.1.0.25, glibc-2.1.3,
and compiled a monolithic kernel while running 2.0.38.

Everything seems ok (simple needs). Too many changes to pin down the cause
of the earlier deadlock that I reported, and it's too soon to see if there
will still be sporadic wrong ext2fs block counts at e2fsck time, but no
deadlocks so far, no oopses, ftp works, ping works, http works, etc.

So the kernel upgrade and kernel compiler change in combination is at
least much more stable, without being to say why exactly (ie "for anyone
that had doubts, there are kernels after 2.0.38 where a real tulip card
is reliable, if you have the lucky compiler").

:-),

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

"Everybody's ignorant, just in different subjects."  Will Rogers



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
