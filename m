Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282320AbRLDHam>; Tue, 4 Dec 2001 02:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282357AbRLDHac>; Tue, 4 Dec 2001 02:30:32 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33218 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282320AbRLDHaZ>; Tue, 4 Dec 2001 02:30:25 -0500
Date: Tue, 4 Dec 2001 00:29:51 -0700
Message-Id: <200112040729.fB47TpA02534@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v99.21 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 99.21 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.2/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.2/devfs-patch-current.gz

WARNING: you will need devfsd-v1.3.19 or later.

NOTE: the devfs-patch-v99.x patches are maintenance patches for the
old 2.2.x production kernels. Occasionally, features from a modern
kernel are back-ported, but this happens rarely.

This is against 2.2.20. Highlights of this release:

- Ported devfs-patch-v99.20 to kernel 2.2.20

- Updated README from master HTML file

- Added DEVFSD_NOTIFY_DELETE event

- Removed unused DEVFS_FL_SHOW_UNREG flag

- Send DEVFSD_NOTIFY_REGISTERED events in <devfs_mk_dir>

- Do not send CREATE, CHANGE, ASYNC_OPEN or DELETE events from devfsd
  or children

- Switched to process group check for devfsd privileges

- Fixed drivers/scsi/osst.c to account for <devfs_register> change

- Remove /dev/ide when IDE module unloaded

- Made drivers/block/cpqarray.c devfs-friendly

- Made drivers/block/cciss.c devfs-friendly

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
