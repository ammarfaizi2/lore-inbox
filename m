Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265606AbSJXTJH>; Thu, 24 Oct 2002 15:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265609AbSJXTI5>; Thu, 24 Oct 2002 15:08:57 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:11638 "EHLO
	mail.iucha.net") by vger.kernel.org with ESMTP id <S265606AbSJXTIx>;
	Thu, 24 Oct 2002 15:08:53 -0400
Date: Thu, 24 Oct 2002 14:15:01 -0500
To: Daniel Egger <degger@fhm.edu>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024191501.GA2438@iucha.net>
Mail-Followup-To: Daniel Egger <degger@fhm.edu>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org, arjanv@redhat.com
References: <3DB82ABF.8030706@colorfullife.com> <1035483003.5680.13.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1035483003.5680.13.camel@sonja.de.interearth.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

SIS735 (ECS7S5A mobo)
Duron 1200 MHz
512 MB PC100

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 24171 cycles per page
copy_page function '2.4 non MMX'         took 25359 cycles per page
copy_page function '2.4 MMX fallback'    took 25224 cycles per page
copy_page function '2.4 MMX version'     took 24149 cycles per page
copy_page function 'faster_copy'         took 15660 cycles per page
copy_page function 'even_faster'         took 15540 cycles per page
copy_page function 'no_prefetch'         took 13853 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 24325 cycles per page
copy_page function '2.4 non MMX'         took 25414 cycles per page
copy_page function '2.4 MMX fallback'    took 25317 cycles per page
copy_page function '2.4 MMX version'     took 24345 cycles per page
copy_page function 'faster_copy'         took 15718 cycles per page
copy_page function 'even_faster'         took 15553 cycles per page
copy_page function 'no_prefetch'         took 13855 cycles per page

Athlon test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $

copy_page() tests
copy_page function 'warm up run'         took 24225 cycles per page
copy_page function '2.4 non MMX'         took 25430 cycles per page
copy_page function '2.4 MMX fallback'    took 25398 cycles per page
copy_page function '2.4 MMX version'     took 24233 cycles per page
copy_page function 'faster_copy'         took 15737 cycles per page
copy_page function 'even_faster'         took 15584 cycles per page
copy_page function 'no_prefetch'         took 13855 cycles per page

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9uEa1NLPgdTuQ3+QRAoYQAJ4zXuYHRIAY/kLXSP2AqKwHnveu9ACghOmA
WV31tqCrZHk77wd2Fn8RBM0=
=bTbg
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
