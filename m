Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTIGQiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTIGQiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:38:06 -0400
Received: from nan-smtp-01.noos.net ([212.198.2.70]:52829 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S261947AbTIGQiC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:38:02 -0400
Subject: Re: Sensors and linux 2.6.0-test4-bk8 question
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Ton Hospel <linux-kernel@ton.iguana.be>
Cc: linux-kernel@vger.kernel.org, lm78@stimpy.netroedge.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-chixyFUpo6IEDLquwfMA"
Organization: Adresse personnelle
Message-Id: <1062952680.9123.0.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Sun, 07 Sep 2003 18:38:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-chixyFUpo6IEDLquwfMA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ton Hospel replied to me
|> I know libsensors is not yet 2.6 aware, but I thought sensed values
|> where available in sysfs if one wanted to manually read them. Since I
|> have via hardware:

|If there is any interest, I have a perl program that does a configurable=20
|display for 2.6.

Sure there is interest:)

|>=20
|> Now there is no sensor-related message as far as I can see in my dmesg,
|> and I do not seem to find any temperature/fan related info in /sys:
|>=20

|You still need the bus and chip drivers before anything appears.
|Which ones is basically the same as with the old lmsensors stuff, so
|look in their docs.

But how can I check the damn things work ? Sensors writers seem to=20
have eschewed the nice messages every other driver writer put in dmesg to
tell me their stuff is correctly loaded.

For example I have :
"SMBus Via Pro adapter at 5000"

in "/sys/devices/pci0000:00/0000:00:11.0/i2c-3/name" so I suppose via-pro
at least is loaded (fully ?). Which should be the bus stuff I think. For
the chip stuff that would be VIA686A (?) But how am I supposed to check the=
=20
darn thing works with nothing in dmesg ? I've already combed sysfs for clue=
s=20
and found nothing.

Regards,

--=20
Nicolas Mailhot

--=-chixyFUpo6IEDLquwfMA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/W17oI2bVKDsp8g0RArq5AJ9wCCiHz7E1qhCRp/bUthk0iCHjYACfYgtv
afSzSP7MgSMehFoRdLKhvrI=
=/tNe
-----END PGP SIGNATURE-----

--=-chixyFUpo6IEDLquwfMA--

