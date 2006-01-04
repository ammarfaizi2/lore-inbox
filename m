Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWADXoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWADXoH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWADXoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:44:07 -0500
Received: from mail.gmx.net ([213.165.64.21]:55517 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750737AbWADXoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:44:06 -0500
X-Authenticated: #5082238
Date: Thu, 5 Jan 2006 00:44:04 +0100
From: Carsten Otto <c-otto@gmx.de>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intel e1000 fails after RAM upgrade
Message-ID: <20060104234404.GA23314@carsten-otto.halifax.rwth-aachen.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20051219195458.GA23650@carsten-otto.halifax.rwth-aachen.de> <20060102121752.GA29275@carsten-otto.halifax.rwth-aachen.de> <4807377b0601041538t98275acn54a36374a42346ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <4807377b0601041538t98275acn54a36374a42346ab@mail.gmail.com>
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 04, 2006 at 03:38:55PM -0800, Jesse Brandeburg wrote:
> I'm not sure it's e1000, is there any chance you can try a different
> network adapter (like not e1000 based)?  with the ethtool diags error
> there is something corrupting memory in your system or on your pci bus
> (most likely)
>=20
> My best recommendation is to check to make sure there aren't any bios
> updates for your system, make sure you aren't running overclocked on
> the pci bus, try different slots, try a different network adapter.=20
> Maybe you can try memtest86 overnight?
>=20
> Honestly right now it doesn't sound like a network problem, but a
> system problem.

I forgot to answer here, sorry.
The problem is solved, see here:
http://lkml.org/lkml/2006/1/2/21
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD4DBQFDvF3EjUF4jpCSQBQRApIhAJQJrQfVVnzWIXJPbd7cJHnWJnNHAKCXUNn3
b6ikzC5JzCWp/8shnMWTaQ==
=7uwD
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
