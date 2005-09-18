Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVIRPVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVIRPVV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVIRPVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 11:21:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932101AbVIRPVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 11:21:20 -0400
Subject: Re: [PATCH] introduce setup_timer() helper
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <432D70C8.EF7B0438@tv-sign.ru>
References: <432D70C8.EF7B0438@tv-sign.ru>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BmeL1qHC7K3/U3gQjNdl"
Organization: Red Hat, Inc.
Date: Sun, 18 Sep 2005 11:12:49 -0400
Message-Id: <1127056369.30256.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BmeL1qHC7K3/U3gQjNdl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> 				unsigned long data)
> +{
> +	timer->function =3D function;
> +	timer->data =3D data;
> +	init_timer(timer);
> +}

are you sure you want to do this in this order???
I'd expect the init_timer to be first...


--=-BmeL1qHC7K3/U3gQjNdl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDLYPxpv2rCoFn+CIRAl0LAJ9vKYUNxD1bHlRQtQufGAQ/4btZQwCfQKtl
aQs39LwJyzOpN7eSVar68SY=
=NG7S
-----END PGP SIGNATURE-----

--=-BmeL1qHC7K3/U3gQjNdl--

