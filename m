Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUIELO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUIELO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 07:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUIELO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 07:14:56 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:167 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S264915AbUIELOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 07:14:51 -0400
Date: Sun, 5 Sep 2004 13:10:31 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Grzegorz Ja??kiewicz <gj@pointblue.com.pl>
Cc: Markus T??rnqvist <mjt@nysv.org>, Matt Mackall <mpm@selenic.com>,
       Nicholas Miell <nmiell@gmail.com>, Wichert Akkerman <wichert@wiggy.net>,
       Jeremy Allison <jra@samba.org>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, torvalds@osdl.org, reiser@namesys.com,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040905111031.GA26560@thundrix.ch>
Reply-To: tonnerre@thundrix.ch
References: <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <4137F669.2000505@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <4137F669.2000505@pointblue.com.pl>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Fri, Sep 03, 2004 at 06:43:21AM +0200, Grzegorz Ja??kiewicz wrote:
> >Then I guess OS X ships a broken implementation of cp, yes?
>=20
> Nope, GUI handles it perfectly. it's maybe 0.1% of users of MacOS that=20
> acctually care about cp being broken.

Actually, there is a (non-GNU) free implementation of the fileutils on
MacOS/X  that treats  and  copies  the .DS_Store  entries  (or say  is
metadata aware).

And  even  though  I might  agree  on  that  the principle  of  having
per-directory  database files is  somewhat hacky,  it appears  to work
like a charm (As long as userland programs do care about it).

On Linux we have a solution that actually works just the same and is a
lot cooler. It's called POSIX extended attributes...

			    Tonnerre

PS. If you want to talk further  on the subject of how MacOS/X does it
and how I would do it using extended attributes, discuss it in private
mail with me, since MacOS/X isn't really Linux. And no, I don't want a
single daemon do  that, but I want it to  be a standard implementation
that libc and fileutils support.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBOvQm/4bL7ovhw40RAgPbAJ9b8fFoSmSWVW/Boihev+7RC4MbLwCfUCwf
KU0vVdbLHZhxLk8PVAcoBbk=
=1Amf
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
