Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284950AbRLQBW3>; Sun, 16 Dec 2001 20:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLQBWK>; Sun, 16 Dec 2001 20:22:10 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33449 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284952AbRLQBV7>; Sun, 16 Dec 2001 20:21:59 -0500
Date: Sun, 16 Dec 2001 18:21:39 -0700
Message-Id: <200112170121.fBH1Ldp32763@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.5 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.5 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

NOTE: this is the patch that I'll be sending to Marcelo soon. PLEASE
TEST this patch if you use devfs, otherwise don't complain if there
are lingering problems. This patch should fix all known remaining
problems, including the devfs/blkdev races that Al Viro has mentioned.

This is against 2.4.17-rc1. Highlights of this release:

- Added clarifying comments in response to preliminary EMC code review
  (missed in ChangeLog in devfs-patch-v199.4)

- Added poisoning to <devfs_put>

- Improved debugging messages

- Fixed unregister bugs in drivers/md/lvm-fs.c

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
