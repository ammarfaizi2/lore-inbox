Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266726AbRGKPgk>; Wed, 11 Jul 2001 11:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRGKPga>; Wed, 11 Jul 2001 11:36:30 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:41220 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S266726AbRGKPgM>; Wed, 11 Jul 2001 11:36:12 -0400
Date: Wed, 11 Jul 2001 09:35:37 -0600
Message-Id: <200107111535.f6BFZbp09425@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: [PATCH] devfs v182 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 182 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

NOTE: this is an important fix for people with renumbering devices in
/dev/discs or /dev/cdroms. Please test and report results to me.

This is against 2.4.7-pre6. Highlights of this release:

- Created <devfs_*alloc_major> and <devfs_*alloc_devnum>

- Removed broken devnum allocation and use <devfs_alloc_devnum>

- Fixed old devnum leak by calling new <devfs_dealloc_devnum>

- Created <devfs_*alloc_unique_number>

- Fixed number leak for /dev/cdroms/cdrom%d

- Fixed number leak for /dev/discs/disc%d

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
