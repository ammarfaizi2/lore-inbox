Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbRE3Nw3>; Wed, 30 May 2001 09:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbRE3NwT>; Wed, 30 May 2001 09:52:19 -0400
Received: from lpce023.lss.emc.com ([168.159.62.23]:13572 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262793AbRE3NwH>; Wed, 30 May 2001 09:52:07 -0400
Date: Wed, 30 May 2001 09:38:07 -0400
Message-Id: <200105301338.f4UDc7N00601@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: [PATCH] devfs v177 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Version 177 of my devfs patch is now available from:
http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
The devfs FAQ is also available here.

Patch directly available from:
ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz

This is against 2.4.5. Highlights of this release:

- Updated README from master HTML file

- Documentation cleanups

- Ensure <devfs_generate_path> terminates string for root entry
  Thanks to Tim Jansen <tim@tjansen.de>

- Exported <devfs_get_name> to modules

- Make <devfs_mk_symlink> send events to devfsd

- Cleaned up option processing in <devfs_setup>

- Fixed bugs in handling symlinks: could leak or cause Oops

- Cleaned up directory handling by separating fops
  Thanks to Alexander Viro <viro@math.psu.edu>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
