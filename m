Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTJRWmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 18:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTJRWmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 18:42:47 -0400
Received: from [38.119.218.103] ([38.119.218.103]:42919 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S261899AbTJRWmn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 18:42:43 -0400
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.047185 secs)
Date: Sat, 18 Oct 2003 17:42:40 -0500
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Network module (de4x5) wont load
Message-ID: <20031018224240.GA11644@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200310190028.57264.basneder@tdlnx.student.utwente.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <200310190028.57264.basneder@tdlnx.student.utwente.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Bas Nedermeijer:
> Hello,
>=20
> i tried the kernel-2.6.0-test7 and -test8, but my network driver doesnt s=
eem=20
> te load properly, the system hangs after it reports the driver is in "100=
=20
> mbit" mode. I'm using the de4x5 module, and i have the=20
> module-init-tools-0.9.15-pre2 to load my modules. I'm not sure the proble=
m is=20
> in the module loading, becausing compiling the module in kernel also hang=
s=20
> the system.

This same thing happens on my Alpha (4 x EV45, 512mb RAM).  The system
will boot fine so long as I never bring up networking... The driver
scans for and finds the devices, but as soon as the system attempts to
bring up an interface, it locks up.

On someone's suggestion, I had tried the -test5 version of de4x5.[ch]
(along with some reverted changes in Space.c), but it had the same
effects.

--=20
Nathan Poznick <kraken@drunkmonkey.org>

Nobody can describe a fool to the life, without much patient
self-inspection. - Frank Moore Colby


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/kcHgYOn9JTETs+URAuzHAJ4ufcXjnZbj9iXyy9NzsdYfhv3Q4wCfVLuA
ii2ewJHeKENiW+il6NPgEN0=
=8IJf
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
