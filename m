Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276448AbRJKOw7>; Thu, 11 Oct 2001 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276453AbRJKOwt>; Thu, 11 Oct 2001 10:52:49 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:35478 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S276448AbRJKOwe>; Thu, 11 Oct 2001 10:52:34 -0400
Date: Thu, 11 Oct 2001 09:52:03 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: Thomas Hood <jdthood@mail.com>
Cc: "J . A . Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.10-ac11 parport_pc.c bugfix
Message-ID: <20011011095202.H1177@draal.physics.wisc.edu>
In-Reply-To: <1002766826.7434.38.camel@thanatos> <20011011154039.C3904@werewolf.able.es> <1002808349.10317.7.camel@thanatos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4LFBTxd4L5NLO6ly"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <1002808349.10317.7.camel@thanatos>; from jdthood@mail.com on Thu, Oct 11, 2001 at 09:52:27AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4LFBTxd4L5NLO6ly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thomas Hood [jdthood@mail.com] wrote:
> I guess the question is: Which way is more portable?  Is
> "(unsigned long)-1" liable to turn out as something other than
> ~0U?
>=20
> If your way of expressing it is more portable then we should
> make the change ... BOTH in pnp_bios.c and in parport_pc.c .
>=20
> Opinions?

unsigned long is 64-bits on 64-bit archs, and so (unsigned long)-1 will be
different than on intel...

I think that's ~0UL?

Maybe this is why I can't get pnp stuff to work on my alpha?

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--4LFBTxd4L5NLO6ly
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvFshIACgkQjwioWRGe9K1eagCg9ZCtB56y2uqO395UB2auoyoF
j9MAoOInVjPJKEZhulZV/miQ3z5Nzup1
=DfLD
-----END PGP SIGNATURE-----

--4LFBTxd4L5NLO6ly--
