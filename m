Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbVIGHGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVIGHGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 03:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbVIGHGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 03:06:45 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:13519 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751082AbVIGHGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 03:06:45 -0400
Date: Wed, 7 Sep 2005 09:06:40 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Omnikey Cardman 4000 driver
Message-ID: <20050907070639.GP14984@sunbeam.de.gnumonks.org>
References: <20050906013545.GB16056@rama.de.gnumonks.org> <29495f1d05090512447da5bcb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liqSWPDvh3eyfZ9k"
Content-Disposition: inline
In-Reply-To: <29495f1d05090512447da5bcb5@mail.gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liqSWPDvh3eyfZ9k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2005 at 12:44:37PM -0700, Nish Aravamudan wrote:
> It looks like all callers of these functions pass in milliseconds? Any
> chance you can get rid of these two and use msleep_interruptible() and
> msleep() instead? As long as you are not using these functions around
> wait-queues, you are ok (which I think is the case here).=20

Ok, I've changed the driver accordingly and I'll repost after some more
testing.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--liqSWPDvh3eyfZ9k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDHpF/XaXGVTD0i/8RAqD5AJ97t3If2tyrXkniDkKnXiDblch1DwCgjud/
u4HZBckpYfRQ6hJTLQfMoV4=
=y9y3
-----END PGP SIGNATURE-----

--liqSWPDvh3eyfZ9k--
