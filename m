Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTCTSBn>; Thu, 20 Mar 2003 13:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbTCTSBn>; Thu, 20 Mar 2003 13:01:43 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:34065 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S261638AbTCTSBl>;
	Thu, 20 Mar 2003 13:01:41 -0500
Date: Thu, 20 Mar 2003 19:12:41 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030320181241.GJ28454@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3E78D0DE.307@zytor.com> <20030320163207.GH28454@lug-owl.de> <20030320092334.31ee2254.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U5yJ31ax00IavOwq"
Content-Disposition: inline
In-Reply-To: <20030320092334.31ee2254.rddunlap@osdl.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U5yJ31ax00IavOwq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-03-20 09:23:34 -0800, Randy.Dunlap <rddunlap@osdl.org>
wrote in message <20030320092334.31ee2254.rddunlap@osdl.org>:
> On Thu, 20 Mar 2003 17:32:07 +0100 Jan-Benedict Glaw <jbglaw@lug-owl.de> =
wrote:
>=20
> | However, please keep in mind that it's a *PITA* if you're working on a
> | machine with not > 500MHz and > 128MB RAM:
> |=20
> | jbglaw@schnarchnase:/tmp$ ls -l linux-2.5.65.tar.*
> | -rw-r--r--    1 jbglaw   jbglaw   31889910 Mar 20 11:37
> | linux-2.5.65.tar.bz2
> | -rw-r--r--    1 jbglaw   jbglaw   39711645 Mar 20 11:44
> | linux-2.5.65.tar.gz
> | jbglaw@schnarchnase:/tmp$ time tar xjf linux-2.5.65.tar.bz2
> |=20
> | real    194m21.665s
> | user    172m55.026s
> | sys     14m19.018s
> | jbglaw@schnarchnase:/tmp$ mv linux-2.5.65 linux-2.5.65xx
> | jbglaw@schnarchnase:/tmp$ time tar xzf linux-2.5.65.tar.gz
> |=20
> | real    39m39.294s
> | user    22m32.306s
> | sys     13m56.524s
> | jbglaw@schnarchnase:/tmp$ free
> |              total       used       free     shared    buffers     cach=
ed
> | Mem:         10100       9792        308          0        952       52=
32
> ...
> | jbglaw@schnarchnase:/tmp$ cat /proc/cpuinfo=20
> ...
> | bogomips        : 15.10
> |=20
> | jbglaw@schnarchnase:/tmp$ uname -a
> | Linux schnarchnase 2.5.65 #1 Thu Mar 20 07:39:11 CET 2003 i486 unknown =
unknown GNU/Linux
>=20
> What kind of processor/system is that?

It's a UMC chip - a i486 clone without FPU. (I thought that this chip
was an i386 clone but uname tells me different so I believe it.)

However, I've got two early i386 (original Intel brand) laying around
and I'm definitely like installing Linux on them, just to see it
running:-)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--U5yJ31ax00IavOwq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+egSZHb1edYOZ4bsRAgZPAJ41wBqNepdh4Dc+xyaoLt6CWneelACfS9WY
z0tfgNsShRNDxFN6VI6nJXM=
=s9GS
-----END PGP SIGNATURE-----

--U5yJ31ax00IavOwq--
