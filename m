Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVA1PUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVA1PUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVA1PUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:20:04 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:59540 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261448AbVA1PT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:19:56 -0500
Date: Fri, 28 Jan 2005 17:19:54 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
Message-ID: <20050128151954.GQ2829@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20050111223652.D30946@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2005 at 10:36:52PM +0000, Russell King wrote:
> However, since it's been rather a long time, I will need to go
> back and redo this patch, along with all the other patches which
> get ARMv6 VIPT aliasing caches working, and then confirm that this
> does indeed end up with something which works.
>=20
> I just don't want to go chasing my tail on something which essentially
> is unacceptable.
>=20
A bit late entering this thread (I didn't see it initially), but..

Having the pfn available would be welcome for the SH-4 VIPT and sh64
cases at least (or most likely any VIPT L1 for that matter), for the
same reasons that have already been noted..

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB+lga1K+teJFxZ9wRAkqrAKCEXjVOXjfOGRr7KHvJtoEsiUgSgwCeJe7Z
b/9f87C1DdOiH93JBnJy6SA=
=Fjox
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
