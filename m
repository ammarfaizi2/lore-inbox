Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTHLSJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTHLSJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:09:20 -0400
Received: from pool-141-155-151-209.ny5030.east.verizon.net ([141.155.151.209]:47825
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S271043AbTHLSJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:09:12 -0400
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Rahul Karnik <rahul@genebrew.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <3F384819.4070108@genebrew.com>
References: <1060543928.887.19.camel@blaze.homeip.net>
	 <2425882704.1060622541@aslan.btc.adaptec.com>
	 <1060623576.2826.9.camel@blaze.homeip.net> <3F37F1A4.2030404@genebrew.com>
	 <31044.199.181.174.146.1060650619.squirrel@www.blazebox.homeip.net>
	 <3F384819.4070108@genebrew.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZUldGi/aqxACuvx8Ez/Y"
Message-Id: <1060711760.854.6.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (Slackware Linux)
Date: Tue, 12 Aug 2003 14:09:20 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.14; AVE: 6.21.0.0; VDF: 6.21.0.10; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZUldGi/aqxACuvx8Ez/Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-08-11 at 21:51, Rahul Karnik wrote:

> acpi=3Doff turns off ACPI
> pci=3Dnoacpi turns off the use of ACPI for PCI IRQ routing
>=20
> I have APIC off both in BIOS and in my kernel, as I had problems when I=20
> tried it last. However, you should try again with the -mm kernels, as I=20
> think they have some work in them to make all of this start working again=
.
>=20
> Hope this helps,
> Rahul

I've tried all these options...regardless of ACPI being enabled or
disabled the driver still does not see the SCSI drive, both of my cdroms
are seen though.

Justin, I would be willing to test the 6.2.36 aic7xxx driver or variant
of if it was made available for 2.6.0-test3 kernel.

What else i could try? Any other suggestions would be welcome.

Paul

--=-ZUldGi/aqxACuvx8Ez/Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/OS1PIymMQsXoRDARAlStAJ4uFXgqa9P5Z1s8do0+s+pvbduqhgCfWBlZ
fa5puIo4y4y7Ce6RdtJlHYU=
=pGhW
-----END PGP SIGNATURE-----

--=-ZUldGi/aqxACuvx8Ez/Y--

