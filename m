Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280191AbRK1TOn>; Wed, 28 Nov 2001 14:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280028AbRK1TNK>; Wed, 28 Nov 2001 14:13:10 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30646 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S280130AbRK1TM5>; Wed, 28 Nov 2001 14:12:57 -0500
Date: Wed, 28 Nov 2001 12:12:14 -0700
Message-Id: <200111281912.fASJCEi18790@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.19 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.19 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Set environment to "safe mode" when invoking modprobe and add better
  debugging messages for /lib/modutils.so. Based on patch from
  Russell Coker

- Call setsid(2)/setpgid(2) to avoid console hangups and place all
  devfsd processes in the same process group

- Generate synthetic REGISTER event for directories at startup

- Made public function <mksymlink> which doesn't generate errors on
  existing symlinks

- Updated compatibility entry support for fixed Computone serial
  driver names

- Updated compatibility entry support for pending Cyclades serial
  driver names.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
