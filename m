Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265777AbUACA1u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 19:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUACA1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 19:27:50 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:24228 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265777AbUACA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 19:27:47 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Fri, 2 Jan 2004 19:27:45 -0500
To: linux-kernel@vger.kernel.org
Subject: ide modules in 2.6.0 (old problem from 2.4)
Message-ID: <20040103002745.GA4298@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i had stumbled upon this problem in 2.4, and it was fixed, but
it's cropped up in 2.6.0 now.

i've compiled all ide support as modules, and now usb-storage
and ide, etc won't load.


WARNING: Module
/lib/modules/2.6.0/kernel/drivers/scsi/ide-scsi.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/usb/storage/usb-storage.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0/kernel/drivers/ide/ide-io.ko
ignored, due to loop
WARNING: Module /lib/modules/2.6.0/kernel/drivers/ide/ide-cd.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-floppy.ko ignored, due
to loop
WARNING: Loop detected:
/lib/modules/2.6.0/kernel/drivers/ide/ide-iops.ko needs ide.ko
which needs ide-iops.ko again!
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-iops.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-taskfile.ko ignored,
due to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-probe.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-default.ko ignored,
due to loop
WARNING: Module /lib/modules/2.6.0/kernel/drivers/ide/ide.ko
ignored, due to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-tape.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/ide-disk.ko ignored, due
to loop
WARNING: Module
/lib/modules/2.6.0/kernel/drivers/ide/pci/amd74xx.ko ignored,
due to loop

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE/9gyBCGPRljI8080RAmtzAJ9W1jG+tr2kUtvQrZTrObm71wiEmwCgjh+8
mOt4f70JAI/76YPIHQpyJu0=
=On9g
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
