Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTFLU0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264985AbTFLU0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:26:10 -0400
Received: from mail.gmx.de ([213.165.64.20]:30913 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264984AbTFLU0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:26:00 -0400
Date: Thu, 12 Jun 2003 22:39:40 +0200
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: laptopkernel-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: 2.4.21-rc8-laptop1 released
Message-Id: <20030612223940.7fcc00a1.hanno@gmx.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Snq'2zVL/?7osJ"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Snq'2zVL/?7osJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The second release of laptopkernel is out.
Get it at
https://savannah.nongnu.org/projects/laptopkernel/


2.4.21-rc8-laptop1

Updated patches: swsusp, supermount, agpgart, drm, broadcom
New patches: acpi4asus, laptop_mode, sis-fb

Patch:  acpi-20030523 (www.sf.net/projects/acpi)
The ACPI in current kernels is very outdated. Most laptops won't have
any Powermanagement without the ACPI-Patch and some even won't boot.

Patch: swsusp-1.0_pre7 (www.sf.net/projects/swsusp)
Software Suspend makes hibernation possible in linux, which is a very
important feature for laptops.

Patch:  supermount-1.2.7 (http://supermount-ng.sf.net)
Supermount is a useful feature for desktop-pcs.

Patch:  agpgart from 2.4.21-rc7-ac1 (www.kernel.org)
Laptops with the Centrino chipset need this for working agpgart, which
is needed for hardware graphics acceleration (dri).

Patch:  drm modules from 2.4.21-rc7-ac1 (www.kernel.org)
This update is needed for proper working dri in XFree 4.3.

Patch:  radeonfb from Benjamin Herrenschmidt (rsync -avz
rsync.penguinppc.org::benh-devel/) Radeon 9000 won't work with radeonfb
found in the current kernel.

Patch:  bcm4400-2.0.2 + bcm5700-6.0.2 driver (from broadcom-ftp)
Needed for Broadcom Network cards found in many laptops.

Patch:  vivicam usb mass storage support (from Lycoris-Kernel)
Needed for Vivicam 355 (working as USB mass storage).

Patch:  acpi4asus-0.23 (www.sf.net/projects/acpi4asus)
Adds support for special acpi-events on asus-laptops.

Patch:  laptop_mode (www.sf.net/projects/swsusp)
Adds laptop_mode, which can save battery power.

Patch:  SiS framebuffer update (www.winischhofer.net)
Needed for some SiS-Cards.

Patch:  Optimization for pentium3/4 (trivial)
Makes gcc3-optimizations for pentium3/4 possible.
(Note: pentium4-optimizations should only be used with gcc 3.2.3 and
above. If you have an older gcc, please use pentium3.)

--=.Snq'2zVL/?7osJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6OUPr2QksT29OyARAmYqAKCTotEm2zw6Ipfa39FVLiOwPgreCwCeMLJ+
xtigq6H1lOR+0Km1QxMCvuE=
=EdB0
-----END PGP SIGNATURE-----

--=.Snq'2zVL/?7osJ--
