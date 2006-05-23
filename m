Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWEWUrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWEWUrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWEWUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:47:53 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:49025 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S932197AbWEWUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:47:52 -0400
Date: Tue, 23 May 2006 22:47:46 +0200
From: markus reichelt <ml@mareichelt.de>
Subject: Re: Compact Flash Serial ATA patch
In-reply-to: <1148410590.25255.115.camel@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20060523204746.GD9829@dantooine>
Organization: still stuck in reorganization mode
MIME-version: 1.0
Content-type: multipart/signed; boundary=s2ZSL+KKDSLx8OML;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.11
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://mareichelt.de/keys/c2a3fee4.asc
References: <1148379397.1182.4.camel@gt-alphapbx2>
 <1148410590.25255.115.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2006-05-23 at 04:16 -0600, Russell McConnachie wrote:
> > I am not exactly a programmer, I'm sure this can be written much
> > better but for anyone who may run into a similar problem with
> > compact flash.
>=20
> Some CF adapters do not include all the neccessary pins for DMA
> because they were designed to be cheap before the idea of CF using
> DMA seemed realistic.

Some CF adapters I've seen included all necessary pins but the pin
connections for DMA were missing. Someone at a slackware mailing list
was having the same problem, and if I recall correctly (better check
specs though) it can be fixed quite easily:

CF pin 44: disconnect from +V, connect to IDE pin 29.
CF pin 43: connect to IDE pin 21.

Typical transfer rates increased to about 10-12 MB/s

--=20
left blank, right bald

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEc3TyLMyTO8Kj/uQRAp3nAJ4k6V88cE13OX00eo1CgPstPYwoHgCfa3eU
k10Oymw4uf5xDT8b9tAVnAI=
=WSBC
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

