Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269685AbTGOVDF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbTGOVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:03:05 -0400
Received: from gate.in-addr.de ([212.8.193.158]:11395 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269685AbTGOVCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:02:53 -0400
Date: Tue, 15 Jul 2003 23:15:37 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>,
       Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Partitioned loop device..
Message-ID: <20030715211537.GQ29748@marowsky-bree.de>
References: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDP66DSfTvWAYVew"
Content-Disposition: inline
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fDP66DSfTvWAYVew
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-07-15T22:32:11,
   "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru> said:

> > You can already use Device-Mapper to create "partitions" on=20
> > your loop devices,=20
> You're right but I want _partitions_ but not "partitions" ;)
> It should appears like a real hardware disk, not virtual one.

There is no difference. What makes /dev/loop1a worse than /dev/hda1?
It's just block devices, that's it.

I have hopes that the entire partitioning code etc will be ripped out in
2.7 in favour of full userspace discovery + DM, and that MD will hit the
same fate...


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
SuSE Labs - Research & Development, SuSE Linux AG
 =20
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur

--fDP66DSfTvWAYVew
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/FG74udf3XQV4S2cRAme7AJ9eIfCd2su7pGjf2TxD2RfJJhfaBACfbMfO
iqv7tchJ94E/IufCr6yUspg=
=WG+A
-----END PGP SIGNATURE-----

--fDP66DSfTvWAYVew--
