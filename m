Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbVJ3Tfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbVJ3Tfo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJ3Tfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:35:44 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:63669 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S932247AbVJ3Tfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:35:43 -0500
Date: Sun, 30 Oct 2005 20:35:40 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
Message-ID: <20051030193540.GD19592@vanheusden.com>
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com>
	<200510292023.01984.gene.heskett@verizon.net>
	<200510301431.54439.s0348365@sms.ed.ac.uk>
	<dk32bf$quc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <dk32bf$quc$1@sea.gmane.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Oct 31 17:21:10 CET 2005
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > [snip]
> >>Does anyone know if there is a hardware RNG in my Athlons?  XP-2800
> >>here, XP-1400 in the shop box, & a K6-III in the firewall.
> > It's a mainboard feature, not a CPU feature.
> And is there a docmentation on how to find which RNG device you have?
> Or is there lsrng (like lspci) :-)
> Most of the device names I have never heard of, but working with 5+ MB ve=
ndors and all the different
> models of MB I really have no idea where do I have this and that...
> So, any method of autodetecting a RNG device?
> And a question, I always wanted to ask: is there a cheap hardware random =
device usable in linux that
> is PCI/USB/serial whatever pluggable? For MBs without RNG in the chipset.

Consider:
audio-entropyd: use a cheap soundcard for generating entropy (http://www.va=
nheusden.com/aed/)
video-entropyd: use that obsolete webcam for same thing (http://www.vanheus=
den.com/ved/)


Folkert van Heusden

--=20
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkNlIIw8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuSB0An1h4zhjp
omV3JlC+EgGQuE+0gNVjAJ9U7VNfEbegYhg8ELk5IZSdmXOiag==
=T6Iq
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
