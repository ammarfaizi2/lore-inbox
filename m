Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263480AbRFRGCR>; Mon, 18 Jun 2001 02:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263496AbRFRGCI>; Mon, 18 Jun 2001 02:02:08 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28067 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263480AbRFRGBw>; Mon, 18 Jun 2001 02:01:52 -0400
Date: Mon, 18 Jun 2001 00:01:03 -0600
Message-Id: <200106180601.f5I613D29992@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: [PATCH] devfs v181 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 181 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.6-pre3. Highlights of this release:

- Answered question posed by Al Viro and removed his comments from <devfs_open>

- Moved setting of registered flag after other fields are changed

- Fixed race between <devfsd_close> and <devfsd_notify_one>

- Global VFS changes added bogus BKL to devfsd_close(): removed

- Widened locking in <devfs_readlink> and <devfs_follow_link>

- Replaced <devfsd_read> stack usage with <devfsd_ioctl> kmalloc

- Simplified locking in <devfsd_ioctl> and fixed memory leak

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
