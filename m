Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289081AbSAUGjw>; Mon, 21 Jan 2002 01:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289082AbSAUGjd>; Mon, 21 Jan 2002 01:39:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:24969 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289081AbSAUGjR>; Mon, 21 Jan 2002 01:39:17 -0500
Date: Sun, 20 Jan 2002 23:39:11 -0700
Message-Id: <200201210639.g0L6dBp22342@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.22 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.22 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Fixed <write_old_sd_name> when there are more than 26 SCSI discs

- Fixed <get_old_name> to ignore new compatibility names for IDE
  devices. Consolidated SCSI code. Consolidated IDE code

- Fixed <action_compat> to ignore new compatibility names for IDE
  devices.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
