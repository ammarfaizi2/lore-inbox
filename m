Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312314AbSCYG7a>; Mon, 25 Mar 2002 01:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312322AbSCYG7U>; Mon, 25 Mar 2002 01:59:20 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43907 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312327AbSCYG7K>; Mon, 25 Mar 2002 01:59:10 -0500
Date: Sun, 24 Mar 2002 23:58:45 -0700
Message-Id: <200203250658.g2P6wjt23915@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.25 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.25 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Minor GNUmakefile tweak for newer versions of sort(1)

- Added signal handler for SIGUSR1 (re-read config but don't generate
  synthetic events)

- Make /lib/devfsd the default directory for shared objects

- Set close-on-exec flag for .devfsd control file

- Set umask so that mknod(2) open(2) and mkdir(2) have complete
  control over permissions

- Added sample entries to devfsd.conf for USB mouse

- Added ide-floppy to modules.devfs list for /dev/discs

- Added /dev/pg and /dev/pg* to modules.devfs list for SCSI generic
  driver

- Added entry to modules.devfs for AGPGART driver

- Added entry to modules.devfs for raw I/O driver.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
