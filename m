Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbSJBWuV>; Wed, 2 Oct 2002 18:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbSJBWuV>; Wed, 2 Oct 2002 18:50:21 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:58606 "EHLO
	blue.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262684AbSJBWuU>; Wed, 2 Oct 2002 18:50:20 -0400
Date: Wed, 2 Oct 2002 15:55:42 -0700
From: Seth Arnold <sarnold@wirex.com>
To: linux-security-module@wirex.com
Cc: Christoph Hellwig <hch@infradead.org>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20021002225542.GA12637@wirex.com>
Mail-Followup-To: linux-security-module@wirex.com,
	Christoph Hellwig <hch@infradead.org>, Valdis.Kletnieks@vt.edu,
	linux-kernel@vger.kernel.org
References: <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu> <20020927195919.A4635@infradead.org> <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu> <20021001175500.A26635@infradead.org> <200210021755.g92HtGLw010852@turing-police.cc.vt.edu> <20021002193940.A16376@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20021002193940.A16376@infradead.org>
User-Agent: Mutt/1.4i
X-Paranoia: Greetings CIA, FBI, MI5, NSA, ATF, Treasury, Ashcroft, Immigration!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2002 at 07:39:40PM +0100, Christoph Hellwig wrote:
> > It seems to me that you're arguing both sides here - first you say that
> > a full code audit is needed so you know 'WTF is going on', and then you=
're
> > saying that it's impossible to know.
>=20
> The person who performs the audit can know it.  But how often will that be
> the author of the LSM module?=20

We've said on this list a few times that it is important for security
module authors to understand the implications of their decisions.
Deciding to not mediate module parameters is a valid decision. Deciding
to mediate module parameters is a valid decision. One requires very
little thought and sidesteps the matter entirely. The other requires
quite a bit of thought and is difficult to get right -- but that is not
a problem for LSM, per se; it is for the authors of security modules.


--=20
http://immunix.org/

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2beW0ACgkQ+9nuM9mwoJl1kACffkVdcNtchGfevSTpJkfkM3A6
i4IAmgNtShMzUA4VJFvMgquNrlnkmbLj
=iAKC
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
