Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312966AbSC0Fuh>; Wed, 27 Mar 2002 00:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312676AbSC0Fu2>; Wed, 27 Mar 2002 00:50:28 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51339 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312675AbSC0FuS>; Wed, 27 Mar 2002 00:50:18 -0500
Date: Tue, 26 Mar 2002 22:49:58 -0700
Message-Id: <200203270549.g2R5nwa14492@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.10 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.10 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.19-pre4. Highlights of this release:

- Changed <devfs_rmdir> to allow later additions if not yet empty

- Added calls to <devfs_register_partitions> in drivers/block/blkpc.c
  <add_partition> and <del_partition>

- Updated README from master HTML file

- Fixed bug in <devfs_alloc_unique_number>: was clearing beyond
  bitfield

- Fixed bitfield data type for <devfs_*alloc_devnum>

- Made major bitfield type and initialiser 64 bit safe

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
