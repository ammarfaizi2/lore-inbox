Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130063AbRABWRv>; Tue, 2 Jan 2001 17:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131466AbRABWRc>; Tue, 2 Jan 2001 17:17:32 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:35079 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131094AbRABWR3>; Tue, 2 Jan 2001 17:17:29 -0500
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200101022144.WAA00639@kufel.dom>
Subject: Re: Happy new year^H^H^H^Hkernel..
To: kufel!stud.uni-dortmund.de!matthias.andree@green.mif.pg.gda.pl (Matthias
	Andree)
Date: Tue, 2 Jan 2001 22:44:27 +0100 (CET)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Kernel Mailing
	List)
In-Reply-To: <20010102191458.B4299@emma1.emma.line.org> from "Matthias Andree" at sty 02, 2001 07:14:58 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, 31 Dec 2000, Linus Torvalds wrote:
> 
> > Ok. I didn't make 2.4.0 in 2000. Tough. I tried, but we had some
> > last-minute stuff that needed fixing (ie the dirty page lists etc), and
> > the best I can do is make a prerelease.
> 
> I just compiled that one into a 1032 kB kernel, and it failed to be
> booted from GRUB 0.5.95 (some CVS version). I then made USB into
> modules, the kernel was 887 kB and booted. Is Linux 2.4 supposed to
> suffer from the 1 M limit still?

No.
$ ls -l /boot/bzImage
-rw-r--r--   1 root     root      1060541 Jan  2 22:18 /boot/bzImage
$ lilo -v
LILO version 20, Copyright 1992-1997 Werner Almesberger

$ uname -a
Linux kufel 2.4.0-prerelease #3 wto sty 2 21:33:36 CET 2001 i586 unknown

Maybe GRUB relies on the data (image size) in a build-in simple bootloader ?

Current i386 image size limit is about 2.5 MB

Andrzej

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
