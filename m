Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282066AbRKVHpG>; Thu, 22 Nov 2001 02:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282067AbRKVHo4>; Thu, 22 Nov 2001 02:44:56 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52901 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S282066AbRKVHoo>; Thu, 22 Nov 2001 02:44:44 -0500
Date: Thu, 22 Nov 2001 00:44:08 -0700
Message-Id: <200111220744.fAM7i8s28650@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v198 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 198 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

NOTE: this patch is important because it removes the limitation on the
number of events that can be queued to devfsd. People who were
experiencing lost events (i.e. with ISDN cards or the sd-many patch
and the driver loaded as a module) should find the problem resolved.

PLEASE: test out this code. I've had only one person report back to me
so far. If it works, let me know that too. Don't just complain if it
doesn't work.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.15-pre9. Highlights of this release:

- Discard temporary buffer, now use "%s" for dentry names

- Don't generate path in <try_modload>: use fake entry instead

- Use "existing" directory in <_devfs_make_parent_for_leaf>

- Use slab cache rather than fixed buffer for devfsd events

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
