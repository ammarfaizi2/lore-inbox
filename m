Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUBEAUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbUBEAT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:19:28 -0500
Received: from smtp.golden.net ([199.166.210.31]:20235 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S264451AbUBEARt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:17:49 -0500
Date: Wed, 4 Feb 2004 19:17:33 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: kgdb support in vanilla 2.6.2
Message-ID: <20040205001733.GA31020@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Tom Rini <trini@kernel.crashing.org>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040204230133.GA8702@elf.ucw.cz> <20040204235215.GA1086@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20040204235215.GA1086@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2004 at 04:52:15PM -0700, Tom Rini wrote:
> > +++ b/Documentation/sh/kgdb.txt Tue Feb  3 19:45:43 2004
> > @@ -0,0 +1,179 @@
> > +
> > +This file describes the configuration and behavior of KGDB for the SH
> > +kernel. Based on a description from Henry Bell <henry.bell@st.com>, it
> > +has been modified to account for quirks in the current implementation.
> > +
> >=20
> > That's great, can we get i386 kgdb, too? Or at least amd64 kgdb
> > ;-). [Or was it a mistake? It seems unlikely that kgdb could enter
> > Linus tree without major flamewar...]
>=20
> FWIW, there has been PPC32 KGDB support in kernel.org for ages.  OTOH,
> I'm quite happy that SH kgdb support came in (mental note made to talk
> to Henry about the KGDB merging stuffs).
>=20
The SH kgdb work is a combination of effort by Henry Bell and Jeremy Siegel,
(ST and MV both had their own versions, Jeremy did the sync work between
the two) neither of which have touched it since mid 2.4 or so when it was
first merged into the LinuxSH tree.

Getting the SH kgdb stuff updated is on my TODO list, I'd definitely be
interested in getting this stuff in sync with Amit's work as well. Any
pointers?


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAIYud1K+teJFxZ9wRAvgYAJ9Dl3X2OY5IK6VxZU8cXS6zUrCeMACeKEIC
5z/ntrP/0BSMnOt+V9/LmCQ=
=5jcx
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
