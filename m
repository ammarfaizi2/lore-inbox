Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSE3OoB>; Thu, 30 May 2002 10:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSE3OoA>; Thu, 30 May 2002 10:44:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18326 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316674AbSE3OoA>;
	Thu, 30 May 2002 10:44:00 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 May 2002 16:43:57 +0200 (MEST)
Message-Id: <UTC200205301443.g4UEhvn20167.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > Of course - improvements are always welcome.
    > (But I try to be slightly more careful than you are.
    > Util-linux runs on all libc's and all kernels, from libc4 to glibc2
    > and from 0.99 to 2.5. So, changes must be compatible.)

    Having them compatible acroess an insane range of kernels
    is a nice but futile exercise.
    Perhaps this partly explains why:

    1. util-linux doesn't cover half of the system utilities needed on
        a sanely actual Linux system.

    2. The Linux vendors have to apply insane number of patches to it
        util it's moderately usable.

If you do the kernel ATA stuff, I'll take care of util-linux.

(Does it need more utilities? Probably those are in some other package.
Sometimes stuff is added, but not very often. However, your suggestions
are welcome.
Do the vendors add patches? Half of that is vendor extensions, that is
their business. Half of that is their stupidity. They blindly copy the
patches other vendors apply "it is a patch - must be an improvement";
sometimes I have to reject the same buggy patch more than a dozen times.
When I ask for the reason of a patch, they don't know themselves.)

    >     No need to invent here. No need to do the book keeping in kernel.
    > 
    > Some need. Things like mount-by-label want to know what partitions
    > exist in order to look at the labels on each.
    > Yes, we really need a list of disk-like devices.
    > The gendisk chain.

    No I don't see that point. Data which has to be persistant across
    reboots is simple data which has to reside on disk. That's the
    way it is in UNIX (PalmOS to name an example).

Maybe you never heard of mount-by-label?

Andries
