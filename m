Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSEQU4X>; Fri, 17 May 2002 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSEQU4W>; Fri, 17 May 2002 16:56:22 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:4361 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316682AbSEQU4V>; Fri, 17 May 2002 16:56:21 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BBC.0072F8A9.00@smtpnotes.altec.com>
Date: Fri, 17 May 2002 15:53:40 -0500
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm not sure I understand what you're saying here.  Yes, the build system is
mostly the same across all these versions -- that's my point.  I want it to STAY
the same as long as possible.  What's the relationship between kbuild and the
size of the kernel source?  Are you saying a new build system would make the
kernel smaller?  Or do you mean that it would be faster, or would require
recompiling smaller portions of the kernel after patching?  That wouldn't help
me, because I'll never trust *any* build system -- even good ol' "make" itself
-- to make the right determination of what to recompile after applying one of
Linus's or Alan's patch sets.  I *always* "make mrproper" and recompile
*everything* after patching.  (Back in my Minix days I usually didn't stop with
recompiling the kernel, but recompiled everything -- libraries, user-space
programs like "cat" and "ls," etc. -- after applying patches.  Minix upgrades
frequently took me 10 hours or more on my 8088 system.)  As for speed, my
Pentium II laptop compiles 2.5.15 a lot faster than my old 486 desktop compiled
0.99pl13 (my first kernel).





Dave Jones <davej@suse.de> on 05/17/2002 03:09:22 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3




Compare and contrast..

-rw-r--r--    1 davej    users     31426560 Jan  9  2001 linux-2.0.39.tar
-rw-r--r--    1 davej    users     85442560 Nov  6  2001 linux-2.2.20.tar
-rw-r--r--    1 davej    users    131727360 Feb 25 20:15 linux-2.4.18.tar
-rw-r--r--    1 davej    users    152524800 May 10 00:11 linux-2.5.15.tar

Spot the pattern? Exponential growth. not only that, but for the most
part, the build system is the same across all of these. If we continue
growing at the current rate without doing something about the build
process, we're all going to be needing 8-way Opterons with several
GB of memory to get any work done.

If kbuild2.5 is faster, and produces the same end result (or better
still, more accurate builds), there's no valid reason to ignore it
that I can see.

    Dave.
--
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




