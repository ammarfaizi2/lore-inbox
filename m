Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTGWXDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271385AbTGWXDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 19:03:07 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:28392 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S271384AbTGWXDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 19:03:01 -0400
Subject: Re: [2.6.0-test1] ACPI slowdown
From: "Bryan D. Stine" <admin@kentonet.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <bfn3rj$lql$1@gatekeeper.tmr.com>
References: <878yqpptez.fsf@deneb.enyo.de> <bfn3rj$lql$1@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5rwxP6XO4lQ4ilvy8WE4"
Organization: KentoNET Communications
Message-Id: <1059002183.1484.18.camel@gaia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 19:16:23 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5rwxP6XO4lQ4ilvy8WE4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I had that problem with my old Athlon TBird. Changing config to make
thermal a module and not loading it solved my problem. I don't know how
to change the thermal limits from within the system using ACPI.


On Wed, 2003-07-23 at 18:56, bill davidsen wrote:
> In article <878yqpptez.fsf@deneb.enyo.de>,
> Florian Weimer  <fw@deneb.enyo.de> wrote:
> | If I enable ACPI on my box (Athlon XP at 1.6 GHz, Epox EP-8KHa+
> | mainboard), it becomes very slow (so slow that it's unusable).
> |=20
> | Is this a known issue?  Maybe the thermal limits are misconfigured,
> | and the CPU clock is throttled unnecessarily (if something like this
> | is supported at all).
>=20
> There have been reports before, check the archives. I seem to remember
> that the solution involved changing some unobvious kernel feature, but
> others have had similar problems.

--=-5rwxP6XO4lQ4ilvy8WE4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/HxdH4Cdq/Vbot6MRAlBYAJ4sYjaKHY7CU3COn7S5pyynzhepDwCgmW//
r0RWaQVza86LujIjllvHeoI=
=AzId
-----END PGP SIGNATURE-----

--=-5rwxP6XO4lQ4ilvy8WE4--

