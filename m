Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319484AbSIGNZy>; Sat, 7 Sep 2002 09:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319485AbSIGNZy>; Sat, 7 Sep 2002 09:25:54 -0400
Received: from B537c.pppool.de ([213.7.83.124]:58563 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S319484AbSIGNZw>; Sat, 7 Sep 2002 09:25:52 -0400
Subject: Re: [ANNOUNCE] devlabel: consistent device access through symlinking
From: Daniel Egger <degger@fhm.edu>
To: Gary_Lerhaupt@Dell.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6812BBB5@AUSXMPC122.aus.amer.dell.com>
References: <20BF5713E14D5B48AA289F72BD372D6812BBB5@AUSXMPC122.aus.amer.dell.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-wsdg4Nm9oh3Z9BU1HIIK"
X-Mailer: Ximian Evolution 1.0.7 
Date: 07 Sep 2002 15:34:43 +0200
Message-Id: <1031405684.12089.96.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wsdg4Nm9oh3Z9BU1HIIK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Fre, 2002-09-06 um 19.40 schrieb Gary_Lerhaupt@Dell.com:

> Attached is a program I have been working on to allow for consistent acce=
ss
> to storage devices.  It works by creating symlinks to actual storage devi=
ce
> names.  When coupled with the UUID of the disk in question, the symlink c=
an
> consistently point to the right data even if the device name changes.
> Devices can thus be referenced by their symlink only and this symlink is
> user-definable. =20

Except that for source RPMs sucking big time the stuff is REALLY cool!
I could also see benefits for other devices like HID where the current
ordering is done after a first come - first serve approach where the
minor device numbers follow the order the devices appear on the bus
which is quite easy to mess up and never consistent; Applying your
scheme to and-class devices also would allow to link whatever device
to a fixed device node which could solve many problems as far as
I can see.

Can you elaborate how you retrieve the IDs of a firewire or USB
controller?
=20
--=20
Servus,
       Daniel

--=-wsdg4Nm9oh3Z9BU1HIIK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9egBzchlzsq9KoIYRAmq4AJ9g7481XM215vs4CJ8D5MbgCM0QLwCcD6Gc
ea1M4f3lOlicf5yfKMoD6wA=
=ihle
-----END PGP SIGNATURE-----

--=-wsdg4Nm9oh3Z9BU1HIIK--

