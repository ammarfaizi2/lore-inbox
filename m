Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbRARBqF>; Wed, 17 Jan 2001 20:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130679AbRARBp4>; Wed, 17 Jan 2001 20:45:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:33298 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130352AbRARBpr>; Wed, 17 Jan 2001 20:45:47 -0500
Date: Wed, 17 Jan 2001 17:45:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What happened to your kernel changelogs?
In-Reply-To: <Pine.LNX.4.31.0101181223220.31432-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10101171745060.10878-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Current half-assed changelog:

2.4.1-pre8:
 - Don't drop a megabyte off the old-style memory size detection
 - remember to UnlockPage() in ramfs_writepage()
 - 3c59x driver update from Andrew Morton
 - egcs-1.1.2 miscompiles depca: workaround by Andrew Morton
 - dmfe.c module init fix: Andrew Morton
 - dynamic XMM support. Andrea Arkangeli.
 - ReiserFS merge
 - USB hotplug updates/fixes
 - boots on real i386 machines
 - blk-14 from Jens Axboe
 - fix DRM R128/AGP dependency
 - fix n_tty "canon" mode SMP race
 - ISDN fixes
 - ppp UP deadlock attack fix
 - FAT fat_cache SMP race fix
 - VM balancing tuning
 - Locked SHM segment deadlock fix
 - fork() page table copy race fix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
