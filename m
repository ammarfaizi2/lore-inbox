Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313455AbSDGT5w>; Sun, 7 Apr 2002 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313457AbSDGT5v>; Sun, 7 Apr 2002 15:57:51 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22173 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S313455AbSDGT5u>; Sun, 7 Apr 2002 15:57:50 -0400
Date: Sun, 7 Apr 2002 13:56:40 -0600
Message-Id: <200204071956.g37Juer24892@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v209 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 209 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.8-pre2. Highlights of this release:

- Updated README from master HTML file

- Removed silently introduced calls to lock_kernel() and
  unlock_kernel() due to recent VFS locking changes. BKL isn't
  required in devfs 

- Changed <devfs_rmdir> to allow later additions if not yet empty

- Added calls to <devfs_register_partitions> in drivers/block/blkpc.c
  <add_partition> and <del_partition>

- Fixed bug in <devfs_alloc_unique_number>: was clearing beyond
  bitfield

- Fixed bitfield data type for <devfs_*alloc_devnum>

- Made major bitfield type and initialiser 64 bit safe

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
