Return-Path: <linux-kernel-owner+w=401wt.eu-S1030299AbWLTTSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWLTTSq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWLTTSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:18:46 -0500
Received: from lug-owl.de ([195.71.106.12]:35414 "EHLO lug-owl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030299AbWLTTSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:18:45 -0500
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 14:18:45 EST
Date: Wed, 20 Dec 2006 19:57:05 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: two architectures,same source tree
Message-ID: <20061220185705.GS11078@lug-owl.de>
Mail-Followup-To: Yakov Lerner <iler.ml@gmail.com>,
	Kernel <linux-kernel@vger.kernel.org>
References: <f36b08ee0612201032m54956e7ay35ca5f63a65e788f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rW45g2D1DgwV0HVw"
Content-Disposition: inline
In-Reply-To: <f36b08ee0612201032m54956e7ay35ca5f63a65e788f@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rW45g2D1DgwV0HVw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-20 20:32:20 +0200, Yakov Lerner <iler.ml@gmail.com> wrote:
> Is it easily possible to build two architectures in
> the same source tree (so that intermediate fles
> and resut files do not interfere ) ?

Sure. Use a common source tree and two separate output directories.
You can set these with O=3D/path/to/output, but you need to do that
during *any* make calls, eg. already for make oldconfig/menuconfig.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                 Friends are relatives you make for yourself.
the second  :

--rW45g2D1DgwV0HVw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFiYeBHb1edYOZ4bsRAqDzAJ9x+hGY6RisH06y5v8nhiq7aVOiAQCfQOoZ
GE9zJEaPbCTuHhNWrt4hjoo=
=c2px
-----END PGP SIGNATURE-----

--rW45g2D1DgwV0HVw--
