Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTDOMnS (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDOMnS 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:43:18 -0400
Received: from iucha.net ([209.98.146.184]:2425 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S261334AbTDOMnQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 08:43:16 -0400
Date: Tue, 15 Apr 2003 07:55:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030415125507.GA29143@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030415133608.A1447@cuculus.switch.gts.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20030415133608.A1447@cuculus.switch.gts.cz>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2003 at 01:36:09PM +0200, Petr Cisar wrote:
> Hello
>=20
> Since 2.5.60, I have been experiencing problems with a complete system fr=
eeze or random oopses when the X-server terminates. It is happening on both=
 machines I am using whose hardware configuration differs slightly, however=
 both of them are equipped with ATI video cards (ATI Rage 128 and ATI Radeo=
n 8500), and both of them run the same version of X-server. That's about al=
l they have in common.
>=20
> The version of X-server I am using is:
> XFree86 Version 4.3.0
> Release Date: 27 February 2003
>=20
> Since the crash either results in an oops obviously not having to do with=
 the core problem, or the system freezes dead (no ping, no reaction to SysR=
q key), I don't know how to get some debug information to describe the faul=
t more precisely.
>=20
> Has anyone notyiced similar problems and is there some documentation how =
to trace such deadly bugs ?

I got the same problem here:
   AMD Duron 1.2
   SIS 735 chipset
   ATI Radeon 8500

On 2.5.67 I get freezes with XFree86 4.3.0 . It works fine with 4.2.1 .

Exactly the same symptoms: the box is dead, no message on the serial
console.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+nAErNLPgdTuQ3+QRAi/tAJ4kzutFv3BnegHuCR6NEbdQpFWNZwCfWdpT
GlnSrOYjvaD+OW6F6quPmOs=
=NQgI
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
