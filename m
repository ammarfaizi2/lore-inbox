Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284948AbRLZVQs>; Wed, 26 Dec 2001 16:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLZVQj>; Wed, 26 Dec 2001 16:16:39 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59075 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284940AbRLZVQ2>; Wed, 26 Dec 2001 16:16:28 -0500
Date: Wed, 26 Dec 2001 14:16:19 -0700
Message-Id: <200112262116.fBQLGJY22088@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.6 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.6 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.17. Highlights of this release:

- Corrected (made useful) debugging message in <unregister>

- Moved <kmem_cache_create> in <mount_devfs_fs> to <init_devfs_fs>

- Fixed drivers/md/lvm-fs.c to create "lvm" entry

- Added magic number to guard against scribbling drivers

- Only return old entry in <devfs_mk_dir> if a directory

- Defined macros for error and debug messages

- Updated README from master HTML file

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
