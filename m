Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268989AbRHBQUk>; Thu, 2 Aug 2001 12:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269039AbRHBQUa>; Thu, 2 Aug 2001 12:20:30 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:30053 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268989AbRHBQUU>; Thu, 2 Aug 2001 12:20:20 -0400
Date: Thu, 2 Aug 2001 18:18:34 +0200
From: Kurt Garloff <garloff@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, brent@linux1.org, linux-kernel@vger.kernel.org,
        mantel@suse.de, rubini@vision.unipv.it, torvalds@transmeta.com
Subject: Re: [PATCH] make psaux reconnect adjustable
Message-ID: <20010802181834.B14708@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>, Andries.Brouwer@cwi.nl,
	alan@lxorguk.ukuu.org.uk, brent@linux1.org,
	linux-kernel@vger.kernel.org, mantel@suse.de,
	rubini@vision.unipv.it, torvalds@transmeta.com
In-Reply-To: <200108021602.QAA113498@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <200108021602.QAA113498@vlet.cwi.nl>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2001 at 04:02:38PM +0000, Andries Brouwer wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>:
>=20
> > 2.2 has had the sysctl for ages, and it defaults to off

I would definitely not object to defaulting to off.

> Not precisely - it is a boot parameter "psaux-reconnect".
> That is better than a sysctl.

Why should that be better than a sysctl? Boot parameters are ugly. You=20
need to reboot in order to change them ...

Your other mail implies that we can fix the problem without manual
intervention by parsing AA 00 instead of just AA. If it's true, I'd=20
consider that the best solution.=20
Otherwise, I'd like my patch to be applied maybe with a changed default.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7aX1ZxmLh6hyYd04RApT9AKDHFa2hTt8CIkrzSQ2hLGjNUBBsugCgpXHZ
6yFa+mIM8HhuiH2NRCRhd04=
=5vOe
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
