Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272458AbTGaLm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 07:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273012AbTGaLm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 07:42:27 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:397 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272458AbTGaLl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 07:41:28 -0400
Date: Thu, 31 Jul 2003 13:41:27 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731114127.GV1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4hvAEPussNf0ZjKL"
Content-Disposition: inline
In-Reply-To: <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4hvAEPussNf0ZjKL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-07-31 00:05:53 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk>
wrote in message <1059606259.10505.20.camel@dhcp22.swansea.linux.org.uk>:
> On Mer, 2003-07-30 at 21:33, Jan-Benedict Glaw wrote:
> > Well... For sure, I can write a LD_PRELOAD lib dealing with SIGILL, but
> > how do I enable it for the whole system. That is, I'd need to give
> > LD_PRELOAD=3Dxxx at the kernel's boot prompt to have it as en environme=
nt
> > variable for each and every process?
>=20
> /etc/ld.preload

/etc/ld.so.preload, that is. Only for the records:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--4hvAEPussNf0ZjKL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/KQBnHb1edYOZ4bsRAr0aAJ9QiaBJIg/61uaUrEZbasB1IYE5dACggA7W
bN+pCGrecdOtkbvmwEE8W7I=
=+xQ+
-----END PGP SIGNATURE-----

--4hvAEPussNf0ZjKL--
