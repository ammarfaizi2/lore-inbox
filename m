Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266138AbUALNdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 08:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266164AbUALNdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 08:33:16 -0500
Received: from s2.smtp.oleane.net ([195.25.12.6]:26639 "EHLO
	s2.smtp.oleane.net") by vger.kernel.org with ESMTP id S266138AbUALNdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 08:33:10 -0500
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0ASeltTB7UjtO74PPW8a"
Organization: Adresse personnelle
Message-Id: <1073912540.16804.10.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 12 Jan 2004 14:02:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0ASeltTB7UjtO74PPW8a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Matt Mackall wrote :

> Then the dumb devices (which should be a small minority) just show up
> with a harmless excess of partitions.

You are underestimating the hardware manufacturers ingenuity. Cheap stuff
(camera card readers...) will always be dumb. In fact people have not even
been discussing there how dumb it can get. I happen to own a dual CF/SM
reader (was cheaper than the single SM reader I needed at the time). It
doesn't appear to support media change notification. In fact the reader
chip seems to simple to process both card slots at the same time. The
manufacturer solved this problem by using a mechanical plastic flap that
prevents insertion of a second card when there is already one in the
reader. There is no notification on what slot is in use to the OS. Both
windows and linux treat it as a dual reader (even though there can only be
a single card inserted at any point of time), export two drives and do
continuous polling just to find out which slot is in use.

Since the SM card is slot two, every single time I plug the reader I see
the CF part errorring out before the driver take a look at the SM one.

Cheers,

--=20
Nicolas Mailhot

--=-0ASeltTB7UjtO74PPW8a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAprcI2bVKDsp8g0RAqZPAJ9shYV8oMRhb51iqVz6pGtvRmXcGQCfcEbS
IwZWg9SkppbxIvd1tBwUK4c=
=bWR4
-----END PGP SIGNATURE-----

--=-0ASeltTB7UjtO74PPW8a--

