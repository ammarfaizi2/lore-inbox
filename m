Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUJJVPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUJJVPT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJJVPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:15:18 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:20846 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268487AbUJJVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:15:09 -0400
Date: Sun, 10 Oct 2004 14:15:07 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041010211507.GB3316@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Andrew Morton <akpm@osdl.org>, roland@redhat.com,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041005063324.GA7445@darjeeling.triplehelix.org> <20041009101552.GA3727@stusta.de> <20041009140551.58fce532.akpm@osdl.org> <pan.2004.10.10.07.39.54.154306@triplehelix.org> <20041010004524.0bf6d42e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <20041010004524.0bf6d42e.akpm@osdl.org>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 10, 2004 at 12:45:24AM -0700, Andrew Morton wrote:
> Useful, thanks.

Maybe this is useful too?

Started make on that test Makefile, and

% strace -p 31810
Process 31810 attached - interrupt to quit
wait4(-1073750280, NULL, 0, NULL)       =3D -1 ECHILD (No child processes)

it then immediately proceeded to give the old 'no child processes.
Stop.' thing.

Strangely, the bug is experienced only sporadically when using make -j2
on a kbuild. Maybe that's just a coincidence.

--=20
Joshua Kwan

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQWmmWqOILr94RG8mAQJ3uA//ceYUqNEOlyA+YGgsnuSU6u2akZ/O3fe0
oiRH3H8oU+xPHb7dU7HCmk+v+ggfm4r4LFq6C9fI3icudqtl/PhUBndD4OWfUWLl
mwClZNezyJ4ofXforzNvL0Aakmw1ziKPRGX8j4vDKa6HJ7UzxI97Ck9l7h0sbXY9
ACK/uzVGCZtmom8ayXGu2UKwd8b7IvfQWxbl2tiABdXhmigI724rGaECI+AK7+Uj
GP0YsPKKE15rh64Q5j2EUCtvU8bdlSQs5QfhdyCIi1BiGRnR2OBMJ77vz2Z62I0A
6D3bs7gmVne/fsl9wnIVg8yX9TMpPsQl/0aE29r8hr7Vif9rnugLXH6m7a3OwEax
uKGfI6SDukABl//OXp+m9Jo3wrPvzGTM38YLLj/SVv//NJ+VuVHpjTXSbOwanL5v
kUpyPPXxysg60TyEmBofdyQLrLtTa4MLudSuy+P8D0ulDRO2EgWzC00b9S/cfUWF
pOHZDlgrKoyEGMMHhVZdhbtV1Wa2yEr4NbrLNu1ng2UOomIoTVbjQQEPnv3PHli6
ZZmMprjG19ujL486zmTU5L9aQhW6V/LKOC/UF6yZoGSd5q2BgqvBWZkcZZ8Xbopb
e1LIrOYrvQiBM5wxDIs3kEOdy40Ob0iryihvCbj2+uQbi2guQAxODUUZ+zAf7aOl
1ihRDFAwSgE=
=ahIL
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
