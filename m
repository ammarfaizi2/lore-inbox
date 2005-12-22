Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVLVBNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVLVBNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 20:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLVBNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 20:13:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35853 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965007AbVLVBNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 20:13:22 -0500
Date: Thu, 22 Dec 2005 02:13:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       aabdulla@nvidia.com, jgarzik@pobox.com, netdev@vger.kernel.org,
       ak@suse.de, discuss@x86-64.org, perex@suse.cz,
       alsa-devel@alsa-project.org, gregkh@suse.de
Subject: 2.6.15-rc6: known regressions in the kernel Bugzilla
Message-ID: <20051222011320.GL3917@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following bugs in the kernel Bugzilla [1] contain regressions in 
2.6.15-rc compared to 2.6.14 with patches:
- #5632 forcedeth driver occasionally hangs
- #5758 x86_64: PANIC: early exception

The following bug in the kernel Bugzilla contains a regressions in 
2.6.15-rc without a patch:
- #5760 No sound with snd_intel8x0 & ALi M5455 chipset
        (kobject_register failed)

If we want people to test -rc kernels, we should also try hard to fix 
the regressions they report (even more if there are already patches 
for them)...

I've Cc'ed all people who might be able comment on one or more of these 
issues.

cu
Adrian

[1] http://bugzilla.kernel.org/

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

