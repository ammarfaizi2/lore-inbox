Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271943AbRHVGco>; Wed, 22 Aug 2001 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271944AbRHVGce>; Wed, 22 Aug 2001 02:32:34 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:7841 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271943AbRHVGcR>; Wed, 22 Aug 2001 02:32:17 -0400
Date: Wed, 22 Aug 2001 00:32:19 -0600
Message-Id: <200108220632.f7M6WJs26503@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v189 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 189 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.9. Highlights of this release:

- Removed nlink field from struct devfs_inode

- Removed auto-ownership for /dev/pty/* (BSD ptys) and used
  DEVFS_FL_CURRENT_OWNER|DEVFS_FL_NO_PERSISTENCE for /dev/pty/s* (just
  like Unix98 pty slaves) and made /dev/pty/m* rw-rw-rw- access

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
