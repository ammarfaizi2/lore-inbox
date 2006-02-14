Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWBNPoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWBNPoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWBNPoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:44:23 -0500
Received: from sipsolutions.net ([66.160.135.76]:1549 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S964807AbWBNPoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:44:23 -0500
Subject: Re: [RFC 2/4] firewire: dynamic cdev allocation below firewire
	major
From: Johannes Berg <johannes@sipsolutions.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jody McIntyre <scjody@modernduck.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <1139865008.2904.13.camel@laptopd505.fenrus.org>
References: <1138919238.3621.12.camel@localhost>
	 <1138920012.3621.19.camel@localhost>
	 <20060213035150.GE3072@conscoop.ottawa.on.ca>
	 <1139815941.2997.9.camel@laptopd505.fenrus.org>
	 <1139832174.6388.31.camel@localhost>
	 <1139865008.2904.13.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oNSR1nBAApz+ehVl41du"
Date: Tue, 14 Feb 2006 16:41:46 +0100
Message-Id: <1139931706.6388.53.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oNSR1nBAApz+ehVl41du
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-02-13 at 22:10 +0100, Arjan van de Ven wrote:

> it's not 256 it's 2^20.... but still :)=20
> (eg there are 20 bits to a minor, 12 to a major)

Umm, right. But I guess Stefan's right too, I should instead allocate a
single major and use it's minors.

johannes

--=-oNSR1nBAApz+ehVl41du
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUAQ/H6OKVg1VMiehFYAQIEzw//ahTPx2/UNV5uu/fi6U94zIXtfPi7yAgf
fyH2ROC2vl+8RCyHm+zSyg3UlBHsCjF/XwpfWz/PBnDbMLOnc1332RJCD0IH0iBZ
0M84q5FYn8rhgdYNF5pzpMe8QX/j1yPjo5sg9YmvO4koFHBy3pMwg52gCVjwt34P
nSJIGNjVVRj8qw0Lk1V6PpDgSyIcm+VU/1pm3DwmAcWbNquFpQb7ER+oB63RR1BQ
+7fXYaDrre+OXlJ8tD2w+62TOrKm1ksBvr7q/T4D64GU6iz91TpJS+jUC8lzuc4m
A/txIGjitN56hphQJbrwpv1L5/eNff4GQhZ4Jlx4rnf7N+uRNvNIV5ZRmDsJfMu1
vOyUKIXCaWl1FpGW4XkFYnW88tp4yVZsyizhJoHcWyrdgOHuRFGuY3HTcGaKoORk
Gi3aG1k9liMX9pkFEiAnY6ZaEVRf15NXswOddaZ/gZ2w4/p9RMKpOyw3HrWW4rDd
omQB3pJ4fINIULzjsF2ByvWaVG5qUD1uy0JOGru7lNzUbFcw+E0iDQeGLYur3CmA
zjdDTnzR7KtJVedEOiwb2yl5plCTzdXrbtTjINRz+pbP0u10vaAbaX4JfJORY0Jg
sqpldOw8qtf4cx9UuXi6UatVrAAIkxVWX2sAXLHEO2b47pRIhypEbu2KRTEAXjA6
RBxTvUVdgQ0=
=uxSh
-----END PGP SIGNATURE-----

--=-oNSR1nBAApz+ehVl41du--

