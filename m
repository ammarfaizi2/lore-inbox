Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbRG3VT1>; Mon, 30 Jul 2001 17:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268118AbRG3VTR>; Mon, 30 Jul 2001 17:19:17 -0400
Received: from [209.226.93.226] ([209.226.93.226]:5113 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S268156AbRG3VTE>; Mon, 30 Jul 2001 17:19:04 -0400
Date: Mon, 30 Jul 2001 17:18:29 -0400
Message-Id: <200107302118.f6ULITu00621@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org, devfs-announce-list@mobilix.ras.ucalgary.ca
Subject: devfsd-v1.3.12 available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

  Hi, all. I've just released version 1.3.12 of my devfsd (devfs
daemon) at: http://www.atnf.csiro.au/~rgooch/linux/

Tarball directly available from:
ftp://ftp.??.kernel.org/pub/linux/daemons/devfsd/devfsd.tar.gz

AND:
ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd.tar.gz

This works with devfs-patch-v130, kernel 2.3.46 and devfs-patch-v99.7
(or later).

The main changes are:

- Added compatibility entries for I2C devices. Thanks to Chris Rankin

- Support multiple regular subexpressions. Thanks to Chris Rankin

- Bug fix in MFUNCTION (bogus CFUNCTION could be called)

- Bug fix for when execvp(3) failes (child did not exit)

- Fixed potential buffer overrun problems. Thanks to Sebastian Krahmer

- Added rpm.spec file. Thanks to Willian Stearns

- Added devfsd.conf(5) man page. Thanks to Russell Coker

- Included sample "mysymlink" shared object extension. Thanks to
  Russell Coker

- Improved modules.devfs configuration file

- Added PREFIX and MANDIR to GNUmakefile

- Documentation updates.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
