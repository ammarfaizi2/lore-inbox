Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267844AbRHFKSR>; Mon, 6 Aug 2001 06:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267852AbRHFKSH>; Mon, 6 Aug 2001 06:18:07 -0400
Received: from adsl-63-198-217-24.dsl.snfc21.pacbell.net ([63.198.217.24]:772
	"EHLO hp.masroudeau.com") by vger.kernel.org with ESMTP
	id <S267850AbRHFKSB>; Mon, 6 Aug 2001 06:18:01 -0400
Date: Mon, 6 Aug 2001 03:15:34 -0700 (PDT)
From: Etienne Lorrain <etienne@masroudeau.com>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Gujin graphical bootloader 0.4
Message-ID: <Pine.LNX.4.33.0108060228220.10664-100000@hp.masroudeau.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello there,

  I released the 0.4 version of the GPL Gujin bootloader.

 Its homepage (with screenshoots) is at:
http://gujin.sourceforge.net/
 Its documentation (FAQ, HowTo) is at:
http://sourceforge.net/docman/display_doc.php?docid=1989&group_id=15465
 All other information and source/precompiled downloads at:
http://sourceforge.net/projects/gujin/

 In short, this bootloader:
 - Is for PCs with at least an 80386 and a VGA, VESA1 or VESA2+
   graphic card.
 - Loads Linux kernel images (zImage and bZimage) without the help
   of LILO, and short-circuit all real-mode code in the kernel to
   start at the first protected mode instruction of the kernel.
   You can use it to load unlimited size kernels and initrd, and
   easily select the text/graphic mode for running the kernel.
 - is nearly completely written in C using GCC, so it is easy to
   modify/improve it. It uses e2fsprogs-1.22 to understand E2FS
   filesystems and a completely rewritten zlib to decompress the
   kernel. FAT12/FAT16 support is working.
 - stay in real mode for the complete boot process, so should be
   compatible with all PCs.
 - Can be installed as a bootloader (only on a floppy right now)
   or as a DOS/Win boot.exe
 - 80 % of the code is already written, so I just need to write
   the last 80 % to have the 1.0 version -:) It is IHMO already
   a good rescue floppy disk or a good single floppy system
   loader (minimum configuration around 20 Kb).

 Have fun!
 Etienne.

