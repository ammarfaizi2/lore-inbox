Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283524AbRK3Gt2>; Fri, 30 Nov 2001 01:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283525AbRK3GtS>; Fri, 30 Nov 2001 01:49:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64697 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S283524AbRK3GtG>; Fri, 30 Nov 2001 01:49:06 -0500
Date: Thu, 29 Nov 2001 23:48:40 -0700
Message-Id: <200111300648.fAU6me909469@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.20 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.20 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

NOTE: this release finally provides complete permissions management.
Manually (i.e. non driver or devfsd) created inodes can now be
restored when devfsd starts up. This requires v1.2 of the devfs core
(available in 2.4.17-pre1) for best operation.

The main changes are:

- COPY action now sets sticky bit as required

- Added RESTORE directive.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
