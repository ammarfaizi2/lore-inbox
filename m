Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTDGQ7C (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263549AbTDGQ7C (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:59:02 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:13706 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263546AbTDGQ7B (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 12:59:01 -0400
Date: Mon, 7 Apr 2003 19:10:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030407171037.GB8178@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some days ago, I've started a -je [*] tree which will focus on memory
reduction for the linux kernel.

The RATIONALE is that on a ppc with some flash, memory, network and
nothing much else, I don't feel like parsing MS-DOS partitions,
offering IPX networking etc., but that junk is still included in
2.[45].current - unconditionally. And there is more...

My first GOAL is to add config options that rip the code out for any
platform that doesn't need, yet keeps it in for everyone that does. If
I don't know what the code is needed for, I'll just rip it out and
wait for bug reports - hopefully.

If I feel that any particular patch is clean enough for mainline, I'll
forward it to Linus/Marcello.

WHO should use this tree:
- Anyone concerned about memory footprint of the linux kernel, both of
the image and during runtime. This will mainly be embedded developers,
I guess.
- Anyone. :)
Bugreports of any kind will help me to clean up the patches and get
them included in mainline. I personally run them on my PIII notebook,
right now, and things didn't break. (Yet?)

HOW can you help:
- Any patch that reduces the memory footprint on _any_ platform is
welcome. Even the worst hacks should be cleaned up over time to work
for everyone.
- Test the patches and:
 - Send bugreports. They will help to clean up the patches.
 - Send works-for-me reports with a rough outline of the hardware
 used.  When things start to work for many people on many platforms,
 it may be time for mainline.
- Send any other patches and convince me that they help embedded
people by my definition (whichever that may be at that time).

WHAT patches will I ignore/reject:
- Anything that does not help embedded (my definition, see above).
That stuff should go into -ac, -dj, -mm, -aa or whereever.

Finallly, WHERE can you get it:
http://wh.fh-wedel.de/~joern/software/kernel/je/24/patch-2.4.20-je1
http://wh.fh-wedel.de/~joern/software/kernel/je/25/patch-2.5.66-je1

DISCLAIMER:
No, the server does not support directory browsing, there is no
mailing list and there are currently only three patches in the 2.4
tree and two in the 2.5 tree. 2.5 is untested, looks broken and I
should put some work in it.
These patches may cost you time, money and precious hardware, I don't
guarantee for anything and IANAL. Anything else?

Jörn

[*] Obviously, je stands for "just embedded", which means I only take
patches that help some embedded platform. What have you thought?

-- 
A surrounded army must be given a way out.
-- Sun Tzu
