Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSGUV44>; Sun, 21 Jul 2002 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSGUV44>; Sun, 21 Jul 2002 17:56:56 -0400
Received: from revdns.flarg.info ([213.152.47.18]:8840 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315120AbSGUV4z>;
	Sun, 21 Jul 2002 17:56:55 -0400
Date: Sun, 21 Jul 2002 22:58:45 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.27-dj1
Message-ID: <20020721215845.GA23019@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly resyncing with the various trees that have sprouted in
the last week, and applying obvious stuff that didn't take much thinking.
Syncing with 4 new releases is no small feat, so this patchset is
*mostly* just a standing still release.
I'll start digging through the *huge* backlog of patches next time.

As usual,..

Patch against 2.5.27 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.27-dj1
o   Drop 99% of input layer changes in favour of mainline.
o   Merge selected bits of 2.4.19rc2 & rc3.
    | Plus some fixes from Christoph Hellwig and others.
o   Fix 64 bit compile issues with uptime wrap patch	(Tim Schmielau)
o   Additional Intel cache descriptors.			(Andy Grover)
o   Update CPU frequency scaling to latest CVS.		(Dominik Brodowski)
    | Missing the ARM bits which rejected.
o   Allow building of serio related drivers as modules.	(Craig Kysela)
o   Restrict frobbing of escd.				(Zwane Mwaikambo)
o   Fix set_bit abuse in epca & specialix drivers.	(Alan Cox)
o   Q40 keyboards only appear on a Q40.			(Alan Cox)
o   Correct headers so miropcm-rds builds.		(Alan Cox)
o   Missing tqueue inclusion in aironet driver.		(Alan Cox)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
