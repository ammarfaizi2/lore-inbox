Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUBYSab (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbUBYSab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:30:31 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:32429 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261533AbUBYSaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:30:20 -0500
Subject: Re: e1000 only works in 2.6.3 with UP kernel ?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Patrick Richard <patr@axion.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <403CE4E4.9010608@axion.net>
References: <403CE4E4.9010608@axion.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T1pVaPIM0tnsgEdHx88I"
Message-Id: <1077733813.8283.1287.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 25 Feb 2004 19:30:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T1pVaPIM0tnsgEdHx88I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-25 at 19:09, Patrick Richard wrote:
> Hi,
>=20
> I have been struggling to get the e1000 driver working _at all_ in=20
> 2.6.3. It works fine under 2.4.xx (same machine). This is all on an ASUS=20
> P4C800-E deluxe, using onboard e1000 and P4 with HT enabled.

[snip]

> Is anyone else seeing similar problems ? Seems like an interrupt/ACPI=20
> type of thing to me based on what is affecting it but what do I know.
>=20
> Does anyone have this working on an SMP kernel/machine with this=20
> motherboard ? Is this a mis-config on my part ? Like I said it works=20
> fine in 2.4 and in UP kernel.

This is a known problem with 2.6.3
Please try the latest 2.6.3-bk snapshot, the patch that introduced this
problem has been reverted.

--=20
/Martin

--=-T1pVaPIM0tnsgEdHx88I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAPOm1Wm2vlfa207ERAkC/AKChISnrNCJ+XlsWzAPCgQtZYc+9QwCgvs+5
4s16iGLqkgYOCE0sPDe/7JM=
=2tmM
-----END PGP SIGNATURE-----

--=-T1pVaPIM0tnsgEdHx88I--
