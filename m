Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbTDXHpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 03:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTDXHpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 03:45:17 -0400
Received: from freesurfmta02.sunrise.ch ([194.230.0.17]:16545 "EHLO
	freesurfmail.sunrise.ch") by vger.kernel.org with ESMTP
	id S261570AbTDXHpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 03:45:13 -0400
Date: Thu, 24 Apr 2003 09:55:32 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Duncan Laurie <duncan@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with a cobalt RaQ550 system and DMA (Serverworks OSB4 in impossible state)
Message-ID: <20030424075532.GF21689@puck.ch>
Mail-Followup-To: Olivier Bornet <Olivier.Bornet@puck.ch>,
	Duncan Laurie <duncan@sun.com>, linux-kernel@vger.kernel.org
References: <20030423212713.GD21689@puck.ch> <3EA7298E.7050600@sun.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <3EA7298E.7050600@sun.com>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Duncan,

> The only work around we have found is to limit these drives to ATA
> mode 4.  Supposedly newer Seagate firmware for these drives will report
> only UDMA mode 4 capable, but for earlier drives (like those probably
> found in your raq550) try this patch against 2.4.20.

Thanks ! This is the solution. I have applied the patch, and the sync
was now OK after about 1 hours for the 70 GB.

Is this patch already applyed on the 2.4.21-pre kernels ? If not can
someone apply it ?

One more time, thanks for your help.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p5h0dj3R/MU9khgRAsQZAJ9LTYNEx4CT7mtdXS0KoHIBTVg8EQCgn4No
LaYJns4sys4LkWm70j9aRxQ=
=/ZaL
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--
