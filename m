Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030793AbWI0Uik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030793AbWI0Uik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030796AbWI0Uik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:38:40 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:15570 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S1030793AbWI0Uii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:38:38 -0400
Subject: Re: forcedeth - WOL [SOLVED]
From: Martin Filip <bugtraq@smoula.net>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060927183857.GA2963@atjola.homenet>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	 <20060927183857.GA2963@atjola.homenet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UXXMOZNWv+TI7uKTNLUq"
Date: Wed, 27 Sep 2006 22:38:06 +0200
Message-Id: <1159389486.8902.4.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UXXMOZNWv+TI7uKTNLUq
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

Bj=F6rn Steinbrink p=ED=B9e v St 27. 09. 2006 v 20:38 +0200:

> Did you check that WOL was enabled? I need to re-activate it after each
> boot (I guess that's normal, not sure though).
> The output of "ethtool eth0" should show:
>=20
>         Supports Wake-on: g
>         Wake-on: g
>=20
Yes, of course :)

> Also, I remember a bugzilla entry in which it was said that the MAC was
> somehow reversed by the driver. I that is still the case (I can't find
> the bugzilla entry right now), you might just reverse the MAC address in
> your WOL packet to workaround the bug.

Hey! this is really crazy :) but it works! To bo honest - I really do
not know what crazy bug could cause problems like this. I thought it's
NIC thing to manage all the work about WOL. I thought OS only sets NIC
into "WOL mode".

But seeing this - one packet for windows and one magic packet for linux
driver - I really do not get it.

--=20
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _________________________________________=20
/ BOFH Excuse #338: old inkjet cartridges \
\ emanate barium-based fumes              /
 -----------------------------------------=20
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

--=-UXXMOZNWv+TI7uKTNLUq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Toto je =?UTF-8?Q?digit=C3=A1ln=C4=9B?=
	=?ISO-8859-1?Q?_podepsan=E1?= =?UTF-8?Q?_=C4=8D=C3=A1st?=
	=?ISO-8859-1?Q?_zpr=E1vy?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGuEuzvp9bBLJ9XMRApRaAJ9T3vplkGjsrpw+MQQI7ihmKHTyfgCfUbfW
e99Uxxv7mScl6u4TevJHyjg=
=rTHe
-----END PGP SIGNATURE-----

--=-UXXMOZNWv+TI7uKTNLUq--

