Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSBDQlp>; Mon, 4 Feb 2002 11:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289074AbSBDQlg>; Mon, 4 Feb 2002 11:41:36 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16306 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289081AbSBDQlS>; Mon, 4 Feb 2002 11:41:18 -0500
Date: Mon, 4 Feb 2002 09:40:35 -0700
Message-Id: <200202041640.g14GeZx27277@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.23 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.23 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Added compatibility entries for parallel port generic ATAPI
  interface

- Minor documentation improvement

- Added sample configuration entries for devfsd.conf for media
  revalidation of compatibility entries

- Changed modules.devfs to use kernel naming scheme. Specifically,
  changed:
	/dev/sound	to	sound-slot-0
	scsi-hosts	to	scsi_hostadapter

- Added entries to modules.devfs for agpgart and Irda.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
