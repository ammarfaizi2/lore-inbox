Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130367AbQK1DQY>; Mon, 27 Nov 2000 22:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130550AbQK1DQO>; Mon, 27 Nov 2000 22:16:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59400 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130367AbQK1DQH>; Mon, 27 Nov 2000 22:16:07 -0500
Date: Mon, 27 Nov 2000 18:45:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test12-pre2
Message-ID: <Pine.LNX.4.10.10011271838080.15454-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, well. Some people saw the (unannounced, and not for public
consumption) pre1, so here's pre2. pre1 was just meant to be an interim
patch to sync up with the ISDN patches.

Due to the birth of my third daughter last week (yes, I got /.'ed), if you
sent me patches that aren't in pre2, you can pretty much consider them
lost.

		Linus

---

 - pre2:
    - Peter Anvin: more P4 configuration parsing
    - Stephen Tweedie: O_SYNC patches. Make O_SYNC/fsync/fdatasync
      do the right thing.
    - Keith Owens: make mdule loading use the right struct module size
    - Boszormenyi Zoltan: get MTRR's right for the >32-bit case
    - Alan Cox: various random documentation etc
    - Dario Ballabio: EATA and u14-34f update
    - Ivan Kokshaysky: unbreak alpha ruffian
    - Richard Henderson: PCI bridge initialization on alpha
    - Zach Brown: correct locking in Maestro driver
    - Geert Uytterhoeven: more m68k updates
    - Andrey Savochkin: eepro100 update
    - Dag Brattli: irda update
    - Johannes Erdfelt: USB update

 - pre1: (for ISDN synchronization _ONLY_! Not complete!)
    - Byron Stanoszek: correct decimal precision for CPU MHz in
      /proc/cpuinfo
    - Ollie Lho: SiS pirq routing.
    - Andries Brouwer: isofs cleanups
    - Matt Kraai: /proc read() on directories should return EISDIR, not EINVAL
    - me: be stricter about what we accept as a PCI bridge setup.
    - me: always set PCI interrupts to be level-triggered when we enable them.
    - me: updated PageDirty and swap cache handling
    - Peter Anvin: update A20 code to work without keyboard controller
    - Kai Germaschewski: ISDN updates
    - Russell King: ARM updates
    - Geert Uytterhoeven: m68k updates

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
