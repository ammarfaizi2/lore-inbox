Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbUHKWKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbUHKWKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUHKWKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:10:44 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:38070 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S268261AbUHKWKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:10:41 -0400
Subject: Re: 2.6.8-rc3-np1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <4117494E.704@yahoo.com.au>
References: <4117494E.704@yahoo.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-10sA96UmuBAB35N5Hmpe"
Message-Id: <1092262435.8976.59.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 00:13:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-10sA96UmuBAB35N5Hmpe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-09 at 11:52, Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/2.6.8-rc3-np1/
>=20
> Patch is against 2.6.8-rc3-mm2 only at this stage due to significant
> memory management changes in there making it difficult to track Linus'
> tree as well.
>=20
> Feedback on the scheduler would be much appreciated, as it might get
> a run in Andrew's tree soon.
>=20

I am trying to get it patched against rc4-mm1, but it seems there
are some issues with the SMT bits - dependent_sleeper for example
is still around although it was removed with all previous patches
(and uses task_t.time_slice which is no longer there).

I assume you forgot to apply them?  Possible to get a complete
patch?  If not, I'll see if I can get something going after some
sleep.


Thanks,

--=20
Martin Schlemmer

--=-10sA96UmuBAB35N5Hmpe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGpojqburzKaJYLYRArRuAJ9YU4oyCkmC3pNruMTAnDsmAjB02ACeLJl9
LlJ8W9IK2mL5M5CN/33/wV4=
=6l7q
-----END PGP SIGNATURE-----

--=-10sA96UmuBAB35N5Hmpe--

