Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTE0TAl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTE0TAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:00:40 -0400
Received: from pop.gmx.de ([213.165.64.20]:14783 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263407AbTE0TAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:00:37 -0400
Date: Tue, 27 May 2003 21:13:46 +0200
From: Hanno =?ISO-8859-15?Q?B=F6ck?= <hanno@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: laptopkernel-2.4.21-rc4-laptop1 released
Message-Id: <20030527211346.11bed9c1.hanno@gmx.de>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="_O3+Pog=.7B294Ks"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_O3+Pog=.7B294Ks
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I have started a project to create a kernel-patch containing various
laptop-specific things.
Especially it contains acpi, software suspend, supermount and some
hardware compatibility patches.

Our goal is to create a kernel that runs all hardware found in current
laptops.
If you have laptop-specific patches you think that should be in
laptopkernel, contact us or submit them through savannahs patch-tracker.

Full list of patches below, it can be downloaded at
http://savannah.nongnu.org/projects/laptopkernel/


laptopkernel-2.4.21-rc4-laptop1 contains the following patches:

Patch: acpi-20030523 (www.sf.net/projects/acpi)
The ACPI in current kernels is very outdated. Most laptops won't have
any Powermanagement without the ACPI-Patch and some even won't boot.

Patch: swsusp 19-27 (www.sf.net/projects/swsusp)
Software Suspend makes hibernation possible in linux, which is a very
important feature for laptops.

Patch: agpgart from 2.4.21-rc2-ac3 (www.kernel.org)
Laptops with the Centrino chipset need this for working agpgart, which
is needed for hardware graphics acceleration (dri).

Patch: drm modules from 2.4.21-rc2-ac3 (www.kernel.org)
This update is needed for proper working dri in XFree 4.3.

Patch: radeonfb from Benjamin Herrenschmidt (rsync -avz
rsync.penguinppc.org::benh-devel/) Radeon 9000 won't work with radeonfb
found in the current kernel.

Patch: bcm440+bcm5700 driver (from Gentoo-Sources)
Needed for Broadcom Network cards found in many laptops.

Patch: vivicam usb mass storage support (from Lycoris-Kernel)
Needed for Vivicam 355 (working as USB mass storage).

Patch: supermount-1.2.6 (http://supermount-ng.sf.net)
Supermount is a useful feature for desktop-pcs.

Patch: Optimization for pentium3/4 (trivial)
Makes gcc3-optimizations for pentium3/4 possible.
(Note: pentium4-optimizations should only be used with gcc 3.2.3 and
above. If you have an older gcc, please use pentium3.) 

--_O3+Pog=.7B294Ks
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+07jur2QksT29OyARAhjLAJ92OO7rJKm+/YEbDG24Elj9RHWhYwCeI60K
pZGuNjFC+paYaqFYoqaZWTI=
=daKm
-----END PGP SIGNATURE-----

--_O3+Pog=.7B294Ks--
