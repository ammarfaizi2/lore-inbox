Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTFXUTZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFXUTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 16:19:25 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:48112 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263011AbTFXUTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 16:19:22 -0400
Subject: Re: [2.5 patch] ULL postfixes for tg3.c
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, jgarzik@pobox.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <20030624.131228.78737223.davem@redhat.com>
References: <20030624174811.GW3710@fs.tum.de>
	 <20030624.131228.78737223.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oCtIoSVQcZ5xaYPkMaR+"
Organization: Red Hat, Inc.
Message-Id: <1056486739.1721.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 24 Jun 2003 22:32:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oCtIoSVQcZ5xaYPkMaR+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-24 at 22:12, David S. Miller wrote:
> I'll apply this, the INT64_MAX or whatever ideas are just
> stupid.  We're saying what "bits" the device supports when
> it does DMA, so we should pass in a "bit" mask.

however it might be a good idea to define a PCI_DMAMASK_64BIT (and 32
bit) with the right values ?

--=-oCtIoSVQcZ5xaYPkMaR+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA++LVTxULwo51rQBIRAnfNAJ41Uy5xGgcmKc9zVIOF438iPfFetgCeMvPC
hEoifRknNaNeHBE8NZW4/8I=
=PmNH
-----END PGP SIGNATURE-----

--=-oCtIoSVQcZ5xaYPkMaR+--
