Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314723AbSD2BBn>; Sun, 28 Apr 2002 21:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314726AbSD2BBm>; Sun, 28 Apr 2002 21:01:42 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22185 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S314723AbSD2BBm>; Sun, 28 Apr 2002 21:01:42 -0400
Date: Sun, 28 Apr 2002 19:01:05 -0600
Message-Id: <200204290101.g3T115B32078@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v211 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 211 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.5/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.5/devfs-patch-current.gz

NOTE: kernel 2.5.1 and later require devfsd-v1.3.19 or later.

This is against 2.5.10. Highlights of this release:

- Do not put miscellaneous character devices in /dev/misc if they
  specify their own directory (i.e. contain a '/' character)

- Copied macro for error messages from fs/devfs/base.c to
  fs/devfs/util.c and made use of this macro

- Removed 2.4.x compatibility code from fs/devfs/base.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
