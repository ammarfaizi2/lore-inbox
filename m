Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQLRXEI>; Mon, 18 Dec 2000 18:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131071AbQLRXD7>; Mon, 18 Dec 2000 18:03:59 -0500
Received: from [194.73.73.138] ([194.73.73.138]:14209 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S130653AbQLRXDl>;
	Mon, 18 Dec 2000 18:03:41 -0500
Date: Mon, 18 Dec 2000 22:32:50 +0000 (GMT)
From: davej@suse.de
To: Powertweak mailing list <powertweak-linux@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxperf@humbolt.nl.linux.org, linux-performance@lists.microstate.com
Subject: [ANNOUNCE] Powertweak v0.99.0
In-Reply-To: <20001214004212.A11827@heim1.tu-clausthal.de>
Message-ID: <Pine.LNX.4.21.0012182226300.2391-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


v0.99.0 of the system performance tuning tool "Powertweak" is released.

Available from http://powertweak.sourceforge.net

 This release brought about a complete rewrite.
 Some of the major changes since the last public release are...

 - Should now work on all architectures.
   (Tested on ia32/Sparc/Alpha/PPC)
 - By default, Powertweak now starts as a daemon that should be
   run on bootup. (Old behaviour still possible with --no-daemon)
   The GUI now communicates with the daemon instead of doing
   the tweaking itself. 
 - Backends are now completely modular plugin libraries.
   This allowed for easier cross-platform usage, and a cleaner API.
 - Profiles.
   Tell Powertweak "This is a webserver" and have it auto-tune.
 - Rewritten /proc/sys tuning backend.
 - PCI backend now uses XML files to describe tweaks. 
   Several chipsets added since 0.1.17 release.
 - Addition of a disk elevator tuning backend.
 - CPU register tuning is now possible, as long as you have the
   cpuid/msr drivers in your kernel (2.2.18, or 2.4.0test)
 - Working text mode user interface.


regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
