Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270320AbRHHFIi>; Wed, 8 Aug 2001 01:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270322AbRHHFI1>; Wed, 8 Aug 2001 01:08:27 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30856 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270320AbRHHFIR>; Wed, 8 Aug 2001 01:08:17 -0400
Date: Tue, 7 Aug 2001 23:08:10 -0600
Message-Id: <200108080508.f7858A014375@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v185 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 185 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.8-pre6. Highlights of this release:

- Made <block_semaphore> and <char_semaphore> in fs/devfs/util.c
  private

- Fixed inode table races by removing it and using inode->u.generic_ip
  instead

- Moved <devfs_read_inode> into <get_vfs_inode>

- Moved <devfs_write_inode> into <devfs_notify_change>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
