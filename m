Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290688AbSBLBbg>; Mon, 11 Feb 2002 20:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290687AbSBLBb1>; Mon, 11 Feb 2002 20:31:27 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:45027 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S290677AbSBLBbU>; Mon, 11 Feb 2002 20:31:20 -0500
Date: Tue, 12 Feb 2002 01:30:34 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.4-dj1
Message-ID: <20020212013034.A14368@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly compile fixes, and a point-release resync.
Diffsize hasn't come down as much as I expected, so I'll push a few
of the larger chunks to Linus tomorrow.

Patch against 2.5.4 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.4-dj1
o   Merge 2.5.4
o   Fix inverted parameters in NCR5380			(Rasmus Andersen)
o   NSC Geode Companion chip workaround.		(Hiroshi MIURA)
    | TODO: Nuke the CONFIG option, replace with
    | PCI detection.
o   Improve kiobuf_init performance.			(Various Intel folks)
o   uidhash cleanup.					(William Lee Irwin III)
o   Fix /proc 'read past end of buffer' bug.		(Thomas Hood)
o   PnPBIOS updates (ESCD support).			(Thomas Hood)
o   signal.c missing binfmt include compile fix.	(Udo A. Steinberg)
o   thread_saved_pc compile fix.			(Andrew Morton)
o   Various reiserfs updates.				(Oleg Drokin, Namesys)
o   Fix UP Preempt compilation.				(Mikael Pettersson)
o   Kill sleep_on in Olympic TR driver.			(Mike Phillips)
o   Drop 64bit DRM fixes.
o   Fix zftape compile.					(Me)
o   Hack around synclink non-compile.			(Me)


2.5.3-dj5
o   Merge 2.5.4pre5
o   Add some missing MODULE_LICENSE tags	(Hubert Mantel)
o   Fix ptrace PEEKUSR oops.			(Manfred Spraul, others)
o   Drop some bogus bits from USB & netdrivers.	(Me)
o   sbpcd bio fixes.				(Paul Gortmaker)
o   pci id trigraph warning fixes.		(Steven J. Hill)
o   Tridentfb resource management fixes.	(Geert Uytterhoeven)
o   53c700 locking cleanup.			(James Bottomley)
o   Workaround ext2 trying to free block -1	(Andreas Dilger)
o   Fix up deviceio Docbook generation.		(Jason Ferguson)
o   removal of isa_read/writes from ibmtr.	(Mike Phillips)
o   kthread abstraction.			(Christoph Hellwig)




-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
