Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136512AbRAHBpI>; Sun, 7 Jan 2001 20:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbRAHBo7>; Sun, 7 Jan 2001 20:44:59 -0500
Received: from cd168990-a.ctjams1.mb.wave.home.com ([24.108.112.42]:4780 "EHLO
	cd168990-a.ctjams1.mb.wave.home.com") by vger.kernel.org with ESMTP
	id <S136512AbRAHBos>; Sun, 7 Jan 2001 20:44:48 -0500
Date: Sun, 7 Jan 2001 19:44:36 -0600
From: Evan Thompson <evaner@bigfoot.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Related VIA PCI crazyness?
Message-ID: <20010107194436.A22050@evaner.penguinpowered.com>
Reply-To: evaner@bigfoot.com
Mail-Followup-To: Evan Thompson <evaner@bigfoot.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010107122800.A636@kantaka.co.uk> <200101072352.PAA28348@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101072352.PAA28348@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Jan 07, 2001 at 03:52:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could anybody with a VIA chip who has the energy please do something for
> me:
>  - enable DEBUG in arch/i386/kernel/pci-i386.h
>  - do a "/sbin/lspci -xxvvv" on the interrupt routing chip (it's the
>    "ISA bridge" chip - the VIA numbers are 82c586, 82c596, the PCI
>    numbers for them are 1106:0586 and 1106:0596, I think)
>  - do a cat /proc/pci

Do you want any output from the enabling of DEBUG, or will doing that
give more info in the other two steps?

Once I get a reply, and once either you release 2.4.1 or Alan releases
-ac4, I'll do that for you (I have a policy of not recompiling the same
kernel twice...I'm just odd that way.  Everybody needs a way to be odd,
and this is mine.  Odd is good).  I like helping people.

Kernels are fun!
-- 
+----------------------------------+-----------------------------------+
| Evan Thompson                    |            POWERED BY:            |
| evaner@bigfoot.com               | Linux cd168990-a 2.4.0-ac3 #1 Sat |
| Freelance Computer Nerd          |  Jan 6 19:40:43 CST 2001 i686     |
| http://evaner.penguinpowered.com |   unknown (w/version number fix)  |
+----------------------------------+-----------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
