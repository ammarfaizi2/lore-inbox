Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319474AbSIMBQL>; Thu, 12 Sep 2002 21:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319475AbSIMBQL>; Thu, 12 Sep 2002 21:16:11 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:49106 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S319474AbSIMBQK>;
	Thu, 12 Sep 2002 21:16:10 -0400
Date: Fri, 13 Sep 2002 11:20:56 +1000
From: Simon Fowler <simon@himi.org>
To: Allan Duncan <allan.d@bigpond.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Linux 2.4.20-pre4 & ff. blows away Xwindows with Matrox G400 and agpgart
Message-ID: <20020913012056.GA10432@himi.org>
Mail-Followup-To: Allan Duncan <allan.d@bigpond.com>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
References: <3D7FF444.87980B8E@bigpond.com.suse.lists.linux.kernel> <p73ptvjpmec.fsf@oldwotan.suse.de> <20020912213201.GA9168@himi.org> <3D811B12.A6615688@bigpond.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <3D811B12.A6615688@bigpond.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2002 at 08:54:10AM +1000, Allan Duncan wrote:
> Not in my case, at least for 2.4.20-pre4.
>=20
2.4.19 works for me with nopentium, 2.4.20-pre5 fails with nopentium
and works without it - I can't add anything beyond that.

> At which kernels does the nopentium become obsolete?  Alan Cox mentioned =
some
> confusion about this.  Obviously the latest ones, but does this extend as=
 far
> back as 2.4.19?
>=20
> In order to close in on what changes are triggering this, I found the pat=
ch for
> sched.c for -pre3 and ran that, and find that -pre3  is fine with or with=
out
> nopentium, so that narrows it to what was altered pre3 to pre4.
>=20
> There was nothing obvious in Marcelo's log of changes, so I will trawl th=
rough
> the diffs themselves tonight.
>=20
> At the same time, I noticed that there seems to a fair bit of touchy
> behaviour of AGP out there, so maybe what is proving fatal to me is the s=
ame as
> the cause of flaky for others.

AGP/DRI has been flaky for me in all sorts of ways, but then I've been
using the DRI CVS code which does lots of strange things, so I can't
pin the problems on AGP . . .

Simon

--=20
PGP public key Id 0x144A991C, or ftp://bg77.anu.edu.au/pub/himi/himi.asc
(crappy) Homepage: http://bg77.anu.edu.au
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://bg77.anu.edu.au/pub/mirrors/css/=20

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9gT13QPlfmRRKmRwRAmPNAJ0Y1epu+WByrdQOQMMxC4rZ4trhNQCfTKFu
y8QFqwYxzD+erTA9G9oTDa0=
=d27+
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
