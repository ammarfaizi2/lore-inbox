Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263071AbTIAR3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 13:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTIAR3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 13:29:00 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54664 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263071AbTIAR2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 13:28:46 -0400
Date: Mon, 1 Sep 2003 19:28:43 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: pl2303 + uhci oops
Message-ID: <20030901172843.GE14376@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200309011827.50331.biker@villagepeople.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <200309011827.50331.biker@villagepeople.it>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-09-01 18:27:50 +0200, biker@villagepeople.it <biker@villagepeo=
ple.it>
wrote in message <200309011827.50331.biker@villagepeople.it>:
> > > Using a pl2303-based usb->serial adaptor with the uhci driver always =
ends=20
> > > with a oops.
> =20
> > Use 2.6.0-testX - it's fixed there:) I'm successfully using a GPS
> > receiver based on a pl2303. This one if from www.lact.de (ebay'ed).
> =20
> This is good, but since 99% of the people is still using 2.4.x, it would =
be=20
> nice if it was fixed there too... ^_^
> BTW, I'm very willing to help by providing any additional information tha=
t=20
> might be useful to solve the problem.

Well, it seems to be a common problem to serial USB devices - if they
send data right after you close(), you oops... However, I'm no longer
looking into 2.4.x. 2.6.x works almost perfectly for me (I'll need to
work out some patches for better i386 support), but 2.6.x basically _is_
more painfree than 2.4.x ATM and IMHO. At least, for my configurations.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/U4HLHb1edYOZ4bsRAjIQAJ9Os7IU+HOHc7dC2tZwnZ8xmrY5/QCgiUcZ
FTJdjguNby7k4P3xJry0YhY=
=l72z
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
