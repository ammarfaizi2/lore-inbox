Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTFCUFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFCUFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:05:06 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17423 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264077AbTFCUFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:05:05 -0400
Date: Tue, 3 Jun 2003 22:18:31 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Paul <set@pobox.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Config issue (CONFIG_X86_TSC) Re: Linux 2.4.21-rc6
Message-ID: <20030603201831.GK30457@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Paul <set@pobox.com>, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <20030603194537.GO22874@squish.home.loc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Content-Disposition: inline
In-Reply-To: <20030603194537.GO22874@squish.home.loc>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-06-03 15:45:37 -0400, Paul <set@pobox.com>
wrote in message <20030603194537.GO22874@squish.home.loc>:
> Marcelo Tosatti <marcelo@conectiva.com.br>, on Wed May 28, 2003 [09:55:39=
 PM] said:
> > Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's fix
> > for the IO stalls/deadlocks.
> >=20
> > Please test it.
> >=20
> 	Hi;
>=20
> 	It seems if I run 'make menuconfig', and the only change
> I make is to change the processor type from its default to
> 486, "CONFIG_X86_TSC=3Dy", remains in the .config, which results
> in a kernel that wont boot on a 486.
> 	Running 'make oldconfig' seems to fix it up, though...

Yeah, that's a but hitting i80386 also, I had sent a patch for that some
time ago to LKML. There's simply some CONFIG_X86_TSC=3Dn missing in the
case of i486 and i486.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3QKXHb1edYOZ4bsRAkoBAJ9LSRZ7BGDfROLSIz7MJv15amD0TwCfZheo
zzizgYlJ4yDC29JdnnHQd8s=
=xOXH
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
