Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315911AbSENRZL>; Tue, 14 May 2002 13:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315913AbSENRZK>; Tue, 14 May 2002 13:25:10 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:51073 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315912AbSENRZJ>; Tue, 14 May 2002 13:25:09 -0400
Date: Tue, 14 May 2002 11:24:29 -0600
Message-Id: <200205141724.g4EHOTY11470@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199.14 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199.14 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.19-pre8. Highlights of this release:

- Copied macro for error messages from fs/devfs/base.c to
  fs/devfs/util.c and made use of this macro

- Added BKL to <devfs_open> because drivers still need it

- Protected <scan_dir_for_removable> and <get_removable_partition>
  from changing directory contents

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
