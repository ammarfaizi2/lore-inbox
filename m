Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284968AbRLQC3F>; Sun, 16 Dec 2001 21:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284969AbRLQC2q>; Sun, 16 Dec 2001 21:28:46 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:47017 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284968AbRLQC21>; Sun, 16 Dec 2001 21:28:27 -0500
Date: Sun, 16 Dec 2001 19:27:57 -0700
Message-Id: <200112170227.fBH2RvG01603@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v204 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 204 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.1. Highlights of this release:

- Removed long obsolete rc.devfs

- Return old entry in <devfs_mk_dir> for 2.4.x kernels

- Updated README from master HTML file

- Increment refcount on module in <check_disc_changed>

- Created <devfs_get_handle> and exported <devfs_put>

- Increment refcount on module in <devfs_get_ops>

- Created <devfs_put_ops> and used where needed to fix races

- Added clarifying comments in response to preliminary EMC code review

- Added poisoning to <devfs_put>

- Improved debugging messages

- Fixed unregister bugs in drivers/md/lvm-fs.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
