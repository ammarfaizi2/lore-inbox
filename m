Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTABJ2Y>; Thu, 2 Jan 2003 04:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTABJ2Y>; Thu, 2 Jan 2003 04:28:24 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:19694 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265095AbTABJ2W>; Thu, 2 Jan 2003 04:28:22 -0500
Subject: Re: [PATCH] Modules 3/3: Sort sections
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Richard Henderson <rth@twiddle.net>
Cc: "David S. Miller" <davem@redhat.com>, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, ak@suse.de, paulus@samba.org,
       rmk@arm.linux.org.uk
In-Reply-To: <20030101205836.A30574@twiddle.net>
References: <20030102030044.D066C2C05E@lists.samba.org>
	 <20030101205404.B30272@twiddle.net>
	 <20030101.205003.37279830.davem@redhat.com>
	 <20030101205836.A30574@twiddle.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oSdoL5DwUUd8vimQQ5vo"
Organization: Red Hat, Inc.
Message-Id: <1041500184.1308.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 02 Jan 2003 10:36:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oSdoL5DwUUd8vimQQ5vo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-01-02 at 05:58, Richard Henderson wrote:
> On Wed, Jan 01, 2003 at 08:50:03PM -0800, David S. Miller wrote:
> >    Incidentally, why do we do strstr(name, ".init") instead
> >    of strncmp(name, ".init", 5)?  Is there any particular
> >    need for the .init to come at the end?
> >=20
> > I think this is to get .foo.init sections.
>=20
> Obviously.  Perhaps the question was worded badly.  Instead read
> it as "Why don't we force this to be called .init.foo instead?"

-ffunction-sections ?

--=-oSdoL5DwUUd8vimQQ5vo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+FAgXxULwo51rQBIRAnlwAJ9cS1TDrzBaINySCJtyOVmQzAPYzACgo3yP
QCl+EsHZJKsVprOv/DQWMgE=
=gGvZ
-----END PGP SIGNATURE-----

--=-oSdoL5DwUUd8vimQQ5vo--
