Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTIZWiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTIZWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:38:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:54723 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S261680AbTIZWit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:38:49 -0400
Date: Sat, 27 Sep 2003 00:38:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [0/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030926223848.GI29898@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030925180223.GC15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JMMA/5w7oqUUivCa"
Content-Disposition: inline
In-Reply-To: <20030925180223.GC15696@fs.tum.de>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JMMA/5w7oqUUivCa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-09-25 20:02:23 +0200, Adrian Bunk <bunk@fs.tum.de>
wrote in message <20030925180223.GC15696@fs.tum.de>:
> Changes since the last set of patches:
> [1/4]
> - changed the i386 CPU selection from a choice to single options for
>   every cpu

If only "slow" CPUs are selected (i386 .. Pentium Classic/MMX), I'd
really like to see HZ=3D100 (or even less) because on these machines, the
timer interrupt handler consumes a measureable amount of time...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--JMMA/5w7oqUUivCa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/dL/4Hb1edYOZ4bsRAql6AKCS9kb6WgyyWt7EvWIy7WTIQ4BATACeKbE3
fKj/MCVo2Gl59GHoQsRMtoE=
=BHwF
-----END PGP SIGNATURE-----

--JMMA/5w7oqUUivCa--
