Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275720AbRJFUmi>; Sat, 6 Oct 2001 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275719AbRJFUm2>; Sat, 6 Oct 2001 16:42:28 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:65153 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S275716AbRJFUmP>; Sat, 6 Oct 2001 16:42:15 -0400
Date: Sat, 6 Oct 2001 15:42:38 -0500
From: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
Message-ID: <20011006154238.B749@draal.physics.wisc.edu>
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3BBEA8CF.D2A4BAA8@zip.com.au>; from akpm@zip.com.au on Fri, Oct 05, 2001 at 11:46:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Andrew Morton [akpm@zip.com.au] wrote:
> Bob McElrath wrote:
> > 3) Is there a possibility that either of these will make it to non-x86
> >     platforms?  (for me: alpha)  The second patch looks like it would
> >     straightforwardly work on any arch, but the config.in for it is onl=
y in
> >     arch/i386.  Robert Love's patches would need some arch-specific asm=
...
>=20
> The rescheduling patch should work fine on any architecture - just copy
> the arch/i386/config.in changes.

I'm running it (2.4.10-pre4-low-latency) on my alpha now, so if you want to=
 add
the appropriate magic to arch/alpha/config.in, please do.

Unfortunately, the use-once stuff broke again in the vm of this kernel, and=
 now
I can't perceive any advantage due to low-latency because of all the swappi=
ng. :(

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAju/bL4ACgkQjwioWRGe9K1lRwCfQ9pyqMaKwQf+vUB/b9YQzl0S
Q6wAoLYxtyp0C+SCWPsdQje0Hf4+40k3
=ufVt
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
