Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTFWJGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265177AbTFWJGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:06:15 -0400
Received: from gate.in-addr.de ([212.8.193.158]:35537 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265020AbTFWJGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:06:14 -0400
Date: Mon, 23 Jun 2003 11:05:00 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] nbd driver for 2.5.72
Message-ID: <20030623090500.GG26081@marowsky-bree.de>
References: <3EF3F08B.5060305@aros.net> <E19Tbyp-0004mi-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <E19Tbyp-0004mi-00@calista.inka.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-06-21T08:36:07,
   Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net> said:

> Is anybody aware of a journalling nbd, which keeps track of unsynced
> changes, so a fast reintegration is possible?

drbd does that, port to 2.5 is in progress.

> Well perhaps this is a property of the md device, instead... hmm. Is there
> such a function available? Could be some left over from snapshot code.

Peter T. Breuer has also been working on intent logging for md, which
will also achieve largely the same thing, just with slightly different
properties. I'm not fully aware on the current status of this
implementation.


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
SuSE Labs - Research & Development, SuSE Linux AG
 =20
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+9sK8udf3XQV4S2cRAl1CAJ9Raeg/i8T1YgNVdCHbf2ou7NBuSwCffdGz
TuLRunDHWep5cm7ehwKHTfw=
=eIIC
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
