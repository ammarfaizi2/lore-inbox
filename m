Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314787AbSD2DwN>; Sun, 28 Apr 2002 23:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314791AbSD2DwM>; Sun, 28 Apr 2002 23:52:12 -0400
Received: from conn6m.toms.net ([64.32.246.219]:26601 "EHLO conn6m.toms.net")
	by vger.kernel.org with ESMTP id <S314787AbSD2DwM>;
	Sun, 28 Apr 2002 23:52:12 -0400
Date: Sun, 28 Apr 2002 23:50:18 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
To: linux-kernel@vger.rutgers.org
cc: torvalds@transmeta.com
Subject: I made a bzip2 bootloader and ramdisk patch, ?useful/not?
Message-ID: <Pine.LNX.4.44.0204282336490.32489-100000@conn6m.toms.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings-

I patched the kernel decompression and the ramdisk decompression
to use bzip2 instead of gzip (for tomsrtbt), is there sufficient
interest or openness to this that I should clean it up and fixup
the config stuff or is this something of such limited usefulness
that I should just keep it here?

In the past I have seen discussion to the effect that the memory
and CPU usage of bzip2 is so much higher that there is no point,
of course, that discussion was about _requests for a patch_, and
it seems possible that it might be seen as of greater use in the
context of _fait accompli_ (?sp).

The tradeoffs are obvious- it takes less space on the media (for
both the kernel and the root ramdisk), but massively more memory
and CPU time. Perhaps only something like tomsrtbt is willing to
pay the price...

Any-way, the patch as it stands, (that is, it works, but has not
been prettied up for prime-time) is available if anyone cares at:

        http://not.toms.net/tomsrtbt-sources/bz2.diff

-Tom Oehser, Tom@Toms.NET




