Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314056AbSEVOFP>; Wed, 22 May 2002 10:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSEVOFO>; Wed, 22 May 2002 10:05:14 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:18447 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S314056AbSEVOFN>;
	Wed, 22 May 2002 10:05:13 -0400
Date: Wed, 22 May 2002 18:09:38 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLC82C105 IDE driver: missing __init
Message-ID: <20020522140938.GA314@pazke.ipt>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020522091648.GB312@pazke.ipt> <E17AVsU-0001aF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.15 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2002 at 02:10:06PM +0100, Alan Cox wrote:
> > slc82c105_bridge_revision() functions lacks __init modifier.
> > Attached patch (against 2.5.17) fixes it.
> > Compiles, but untested. Please consider applying.
>=20
> I wouldnt get too carried away with these. Once the IDE core is clean
> enough to allow hot plugging of IDE interfaces those __init's are all goi=
ng
> to need changing anyway

Then we'll grep and change them to __devinit.=20
But missing __init can't be changed :))

> (and yes you can get hot pluggable IDE setups already - the mobility stuff
>  for example has a case with a PCI split bridge, 3 or 4 PCI slots and
>  connects to the cardbus on a laptop)

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE866aiBm4rlNOo3YgRAgLiAJ4khTJzSnk2hk7Nnn/pofNuDSbX+ACgkQTX
/rtdFTeZwPwYsERjz5QhU0M=
=OFYX
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
