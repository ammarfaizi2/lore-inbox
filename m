Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWBHDRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWBHDRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWBHDRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:17:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54144 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751131AbWBHDRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:17:47 -0500
To: torvalds@osdl.org
Subject: [PATCHSET]  misc annotations and fixes
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fpy-0006B8-Uf@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:17:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted trivial stuff all over the place.  Please, pull from
for-linus branch in git.kernel.org/pub/scm/linux/kernel/git/viro/bird.git/
Hopefully I haven't fscked it up - first attempt at passing stuff that way...
	Individual patches will go to l-k (hopefully with all relevant Cc)
in a few minutes.
	Shortlog follows:
Al Viro:
      remove bogus asm/bug.h includes.
      bogus asm/delay.h includes
      drive_info removal outside of arch/i386
      missing includes in drivers/net/mv643xx_eth.c
      fix breakage in ocp.c
      restore power-off on sparc32
      ppc: last_task_.... is defined only on non-SMP
      drivers/scsi/mac53c94.c __iomem annotations
      fallout from ptrace consolidation patch: cris/arch-v10
      missing include in ser_a2232
      fix __user annotations in fs/select.c
      ipv4 NULL noise removal
      timer.c NULL noise removal
      kernel/sys.c NULL noise removal
      dvb NULL noise removal
      drivers/char/watchdog/sbc_epx_c3.c __user annotations
      fix __user annotations in drivers/base/memory.c
      drivers/edac/i82875p_edac.c __user annotations
      cmm NULL noise removal, __user annotations
      scsi_transport_iscsi gfp_t annotations
      sg gfp_t annotations
      eeh_driver NULL noise removal
      bogus extern in low_i2c.c
      amd64 time.c __iomem annotations
      __user annotations of video_spu_palette
      net/ipv6/mcast.c NULL noise removal
      arch/x86_64/pci/mmconfig.c NULL noise removal
      nfsroot port= parameter fix [backport of 2.4 fix]
      umount_tree() decrements mount count on wrong dentry
