Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSIKH4C>; Wed, 11 Sep 2002 03:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSIKH4C>; Wed, 11 Sep 2002 03:56:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:228 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318470AbSIKH4B>;
	Wed, 11 Sep 2002 03:56:01 -0400
Date: Wed, 11 Sep 2002 10:00:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.34 IDE
Message-ID: <20020911080036.GS21877@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've updated 2.5 IDE code to match what is currently in 2.4.20-pre5-ac4,
since is much nicer and better structured. There have also been some
cleanups along the way, all of which have been passed back to Alan for
the 2.4 tree.

If you feel adventorous, please try:

*.kernel.org:/pub/linux/kernel/people/axboe/patches/v2.5/2.5.34/ide-2.5.34-4.gz

Note that the patch is _huge_ because it moves files around! I've also
got this in a bk tree with proper file moving etc (and patch split in a
million pieces), but that's mainly for Linus to pull (ie its on
master right now, and I'm not inclined to move it). If someone wants to
see it though, I can probably put it somewhere public.

If you apply against 2.5.34-BK (instead of 2.5.34 virgin), note that
some parts are already in. In that case, remove the parts of the diff
that update:

arch/i386/pci/common.c
arch/i386/pci/i386.c
arch/i386/pci/pci.h
arch/i386/pci/visws.c
drivers/pci/pci.c
include/linux/blkdev.h
include/linux/hdreg.h
include/linux/pci.h
include/linux/pci_ids.h

-- 
Jens Axboe

