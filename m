Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274125AbRISSEM>; Wed, 19 Sep 2001 14:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274127AbRISSEC>; Wed, 19 Sep 2001 14:04:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:44498 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S274125AbRISSDp>; Wed, 19 Sep 2001 14:03:45 -0400
Date: Wed, 19 Sep 2001 12:03:41 -0600
Message-Id: <200109191803.f8JI3fd22488@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v192 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 192 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

REMINDER: this patch and earlier patches include support for >2000
SCSI discs.

This is against 2.4.10-pre11. Highlights of this release:

- Removed unnecessary #ifdef CONFIG_DEVFS_FS from arch/i386/kernel/mtrr.c

- Created sdmalloc() and sdfree() macros in drivers/scsi/sd.c

- Ported to kernel 2.4.10-pre11

- Set inode->i_mapping->a_ops for block nodes in <get_vfs_inode>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
