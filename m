Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266067AbRGGIkt>; Sat, 7 Jul 2001 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGGIkj>; Sat, 7 Jul 2001 04:40:39 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:4562 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S266067AbRGGIk1>;
	Sat, 7 Jul 2001 04:40:27 -0400
Message-Id: <m15IndK-000OzlC@amadeus.home.nl>
Date: Sat, 7 Jul 2001 09:40:10 +0100 (BST)
From: arjan@fenrus.demon.nl
To: dushaw@apl.washington.edu (Brian Dushaw)
Subject: Re: ASUS CUV4X-D Dual CPU's - Failure to boot...
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107062244260.3175-100000@munk.apl.washington.edu>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0107062244260.3175-100000@munk.apl.washington.edu> you wrote:
> Dear Kernel People,
>   A friend of mine has a new PC with an ASUS CUV4X-D motherboard
> and dual 1GHZ PIII's.  We have installed RedHat 7.1.  The original
> RedHat SMP kernel (2.4.2) did not boot; it froze with some complaints
> about APIC.  The backup single processor kernel 2.4.2 booted o.k.,
> however.   The upgraded kernel from RedHat (2.4.3) also refused to boot
> properly - the boot up will start and the screen will then go blank
> before I can discern any informative messages.  I also downloaded the
> latest 2.4.6 kernel which had the identical problem, and then I also
> applied the latest Alan-Cox patch for 2.4.6 which did not solve the
> problem.  The 2.4.6 kernel will boot when only a single processor
> is used, however.

For several people the following works:
1) Upgrade to the latest bios
2) Change the "MPS" level in the bios. It can have 3 values "1.4" "1.1" and
   "none". the default one doesn't work, one of the others does (but I
   forgot which one)

Greetings,
   Arjan van de Ven

