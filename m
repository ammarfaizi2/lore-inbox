Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTJUInv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbTJUInv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:43:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:57809 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263050AbTJUInt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:43:49 -0400
Date: Tue, 21 Oct 2003 10:43:44 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
Message-ID: <20031021084341.GB20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iHFviu+nrIzaPuhq"
Content-Disposition: inline
In-Reply-To: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iHFviu+nrIzaPuhq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-19 11:16:42 +0900, Norman Diamond <ndiamond@wta.att.ne.jp>
wrote in message <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60>:
> After a few other experiments, I used smartctl to direct the drive to do a
> long self-test.  When it completed, we observed that the drive had
> self-diagnosed a read failure on the same bad sector number as always, and
> we observed that the drive did not reallocate the bad block during long
> self-tests.

Maybe the drive can't remap the block because there's no free space in
the remap area available any more...

In this case, the real problem is that the drive doesn't tell in advance
that is already remapped some blocks.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--iHFviu+nrIzaPuhq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lPG9Hb1edYOZ4bsRAq75AJ435SHnfpvQLeSdDiiEPwhCMxGDPACfY+oH
KPm54JoGKqzaB7kKNVSZLOs=
=lNmY
-----END PGP SIGNATURE-----

--iHFviu+nrIzaPuhq--
