Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVCaTyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVCaTyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVCaTyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:54:36 -0500
Received: from mini002.webpack.hosteurope.de ([80.237.130.131]:52717 "EHLO
	mini002.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261710AbVCaTyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:54:23 -0500
Subject: Re: Call for help: list of machines with working S3
From: Maximilian Engelhardt <maxi@daemonizer.de>
Reply-To: maxi@daemonizer.de
To: romano@dea.icai.upco.es
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050318145028.GA22887@pern.dea.icai.upco.es>
References: <3xVNA-Qn-43@gated-at.bofh.it> <1111089912.9802.26.camel@mobile>
	 <20050318145028.GA22887@pern.dea.icai.upco.es>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iA7P9RkimDF+lD9Yg/uI"
Date: Thu, 31 Mar 2005 21:54:33 +0200
Message-Id: <1112298873.10156.18.camel@mobile>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iA7P9RkimDF+lD9Yg/uI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-18 at 15:50 +0100, Romano Giannetti wrote:
>=20
> It happens exactly the same on my laptop, sony vaio whose configuration i=
s=20
>=20
> http://www.dea.icai.upco.es/romano/linux/vaio-conf/laptop-config.html
>=20
> Next week is Easter holyday here, I will try to connect my Psion casio as
> serial terminal and see if I can catch something.=20

I was able to get some logs using CONFIG_LP_CONSOLE (the first time I
ever saw "Back to C!"):

Back to C!
PM: Finishing up.
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 10 (level,low) -> IRQ 10
MCE: The hardware reports a non fatal, correctable incident occurred on
CPU 0.
Bank 1: e200000000000001
hda: task_out_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_out_intr: error=3D0x04 { DriveStatusError }
ide: failed opcode was: unknown

keeps on always repeating last three messages until I reboot

Full log:
http://home.daemonizer.de/resume.png

kernel version is 2.6.11
config: http://home.daemonizer.de/config-2.6.11-S3test
dmesg from booting: http://home.daemonizer.de/dmesg-2.6.11-S3test
lspci: http://home.daemonizer.de/lspci
Gentoo Base System version 1.6.10

Hardware:
Acer Travelmate 661lci (centrino)
Intel(R) Pentium(R) M processor 1400MHz

please mail me if you need additional data.

Thanks for help,
Maxi

--=-iA7P9RkimDF+lD9Yg/uI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCTFV5Oimwv528XGERAulGAJ9W4nGTAJllv7R825mRp8tQAIs7bgCguh0V
l2L4M8jSNCLFMv8uwh7xFOM=
=g38s
-----END PGP SIGNATURE-----

--=-iA7P9RkimDF+lD9Yg/uI--
