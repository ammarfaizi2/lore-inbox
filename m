Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTI3B1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 21:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbTI3B1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 21:27:45 -0400
Received: from adsl-67-124-157-90.dsl.pltn13.pacbell.net ([67.124.157.90]:3808
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263064AbTI3B1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 21:27:43 -0400
Date: Mon, 29 Sep 2003 18:27:42 -0700
To: linux-kernel@vger.kernel.org
Cc: stephena@users.sourceforge.net
Subject: Re: Possible regression with 2.6.0-test6
Message-ID: <20030930012742.GB10262@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org,
	stephena@users.sourceforge.net
References: <200309290822.09859.stephena@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline
In-Reply-To: <200309290822.09859.stephena@users.sourceforge.net>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2003 at 08:22:09AM -0230, Stephen Anthony wrote:
> Since this new release has tweaked interactivity patches, I'm=20
> wondering if this has anything to do with it.

Yes. Con Kolivas' interactivity patches that have been merged into
mainline mean that if Mandrake's XFree86 runs at a negative nice value,
this will affect interactivity. Please set it to 0.

FWIW for others reading this thread, in Debian it is a matter of running
'dpkg-reconfigure xserver-common'.

(As I was writing this message I realized that Nick Piggin had already
answered, but because of the little Debian factoid I'm deciding to send
it anyway.)

--=20
Joshua Kwan

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBP3jcDaOILr94RG8mAQKuqw//d432dr4XBTTfCR/65w7y5bz/SWVu/3Ag
h7Vt/q2jjjs8taS1D8QkvYf2h7Gw9bzE6l97vPsV9DAY3a9oQHAHyQ/iKlneRHf5
Sz0GWo8igu8TAw4N/Ywn3ANFiTEx08yIFu+cZMWAyB7GeecTjbIgeNDYJ0xVvt2r
q1f/b7a4/h94ImJHptJYP5UFHJgBGtX9HdjpB0dF3/d8ShzaDRZsyl4EEqju3GSy
V702h6rk/NeFpzg3ZmxpEGEPFjPeQyX7W/kekUcdFQXpNIcE6HCXmkutAMFLSgiI
NcRLBJrjy/1q1p0pWl7iFvT68KPAynSU1C0+YGGHPQ4eRS95GVamX9fRAGaXeXib
trEeml6Z5mghlBAOGsgQ2ON5riJxAUjFWlNxgUIadszMpoCpfX08fvQ/7HOnwRsm
DM177LKM3q0LUFjouDZg0BEhngzR8APA7/RjQyQbs9X/CSw2p8FpQjavHFHw9Hb3
4LH85nGC9xL9/3yIIfa1bS0vobxonv8oRvhg/v6oKT+DFtIWAQdbfOraDDijbVLu
XrRI5kAci1ydwXKJG8I64S3b+t1/Cy6I3SNM5AcSMkrRWb54egAIPBvNfHO3AOfg
wz/l2dExHHSOa9F/8WkvMMmTW8L4eH0jv4k9VVEhjAaSa8auvquJPNKasew2KQbz
6k0Gnza7sGg=
=GDqO
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
