Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUCKNPv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUCKNPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:15:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61093 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261252AbUCKNPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:15:13 -0500
Subject: Re: interruptible_sleep_on() from tasklet?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118873EE1755348B4812EA29C55A9721764AB@esnmail.esntechnologies.co.in>
References: <1118873EE1755348B4812EA29C55A9721764AB@esnmail.esntechnologies.co.in>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yKb4tQsJryxrAUHig8YT"
Organization: Red Hat, Inc.
Message-Id: <1079010904.4446.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 11 Mar 2004 14:15:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yKb4tQsJryxrAUHig8YT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-11 at 13:48, Jinu M. wrote:
> Hi All,
>=20
> Can we do interruptible_sleep_on or interruptible_sleep_on_timeout from a=
 tasklet?

no.

In fact you should *NEVER* use interruptible_sleep_on(_timeout) but
especially not from tasklets/irq handlers.

--=-yKb4tQsJryxrAUHig8YT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAUGZYxULwo51rQBIRApFwAKCPD1DXhqk4XJzhtEpHuyawrgf+jACfTIjJ
3gjKBUZ7zHqvec6X6mrlxoE=
=7GF/
-----END PGP SIGNATURE-----

--=-yKb4tQsJryxrAUHig8YT--

