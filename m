Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281812AbRK1GZW>; Wed, 28 Nov 2001 01:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281805AbRK1GZM>; Wed, 28 Nov 2001 01:25:12 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30389 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281777AbRK1GY7>; Wed, 28 Nov 2001 01:24:59 -0500
Date: Tue, 27 Nov 2001 23:24:34 -0700
Message-Id: <200111280624.fAS6OYA11381@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v199 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 199 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.16-pre1. Highlights of this release:

- Removed obsolete usage of DEVFS_FL_NO_PERSISTENCE

- Send DEVFSD_NOTIFY_REGISTERED events in <devfs_mk_dir>

- Fixed locking bug in <devfs_d_revalidate_wait> due to typo

- Do not send CREATE, CHANGE, ASYNC_OPEN or DELETE events from devfsd
  or children

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
