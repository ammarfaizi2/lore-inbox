Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272230AbRHWFwu>; Thu, 23 Aug 2001 01:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272231AbRHWFwk>; Thu, 23 Aug 2001 01:52:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:11427 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S272230AbRHWFw1>; Thu, 23 Aug 2001 01:52:27 -0400
Date: Wed, 22 Aug 2001 23:52:40 -0600
Message-Id: <200108230552.f7N5qeo06460@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.18 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.18 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Removed harmless false positives in PERMISSIONS action

- Return ID=0 rather than exiting on failed lookup in passwd or group
  databases

- Do not exit in EXECUTE action if fork(2) fails

- Added documentation on regular subexpression support. Thanks to Adam
  J. Richter.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
