Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTIRRPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbTIRRP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 13:15:29 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:63228 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261921AbTIRRP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 13:15:28 -0400
Subject: Re: netpoll/netconsole minor tweaks
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Wright <chrisw@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030918094832.A16499@osdlab.pdx.osdl.net>
References: <20030917112447.A24623@osdlab.pdx.osdl.net>
	 <1063888205.15962.20.camel@dhcp23.swansea.linux.org.uk>
	 <20030918094832.A16499@osdlab.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dRqZB4Pwm7F8JrVJUf8q"
Organization: Red Hat, Inc.
Message-Id: <1063905237.2978.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Thu, 18 Sep 2003 19:13:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dRqZB4Pwm7F8JrVJUf8q
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Hrm, there's many spots that aren't using it.  What's the benefit, less
> power consumption?=20

Less power consumption, and on HT/SMT CPU's it's a "yield" to the other
half/halves.
>
>  Is it worth a patch to convert other things over?
>=20

yes


--=-dRqZB4Pwm7F8JrVJUf8q
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/aefVxULwo51rQBIRAj77AKCQXcRy/Zvdh9Uvcj1/i5Ogb7OmCgCgnA+3
atUtr6beX0PPr7lGBimkpCs=
=1tO6
-----END PGP SIGNATURE-----

--=-dRqZB4Pwm7F8JrVJUf8q--
