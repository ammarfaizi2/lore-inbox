Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271478AbRHPF13>; Thu, 16 Aug 2001 01:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271481AbRHPF1U>; Thu, 16 Aug 2001 01:27:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49558 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271478AbRHPF1O>; Thu, 16 Aug 2001 01:27:14 -0400
Date: Wed, 15 Aug 2001 23:26:47 -0600
Message-Id: <200108160526.f7G5Qlx05483@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: devfsd-v1.3.16 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. I've just released version 1.3.16 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Move opendir(3) call to <do_scan_and_service>

- Be more tolerant of some system errors

- Fixed file descriptor leak in <action_copy>.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
