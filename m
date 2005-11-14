Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVKNTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVKNTYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVKNTYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:24:40 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:18916 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751249AbVKNTYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:24:40 -0500
Date: Mon, 14 Nov 2005 20:24:38 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [PATCH] Make usbdevice_fs.h (again) useable from userspace
Message-ID: <20051114192438.GM4773@sunbeam.de.gnumonks.org>
References: <20051114173727.GL4773@sunbeam.de.gnumonks.org> <1131990327.2821.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="djJN5oi3zFpblwUd"
Content-Disposition: inline
In-Reply-To: <1131990327.2821.44.camel@laptopd505.fenrus.org>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--djJN5oi3zFpblwUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2005 at 06:45:27PM +0100, Arjan van de Ven wrote:
> On Mon, 2005-11-14 at 18:37 +0100, Harald Welte wrote:
> > Make usbdevice_fs.h (again) useable from userspace
> >=20
> > If we have CONFIG_COMPAT enabled, then userspace programs using
> > usbdevice_fs.h won't compile anymore.
>=20
> how does the userspace application set CONFIG_COMPAT??

duh. good question.  Seems like the application was broken by somehow
including config.h, so we can safely ignore this.  Sorry for the noise.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--djJN5oi3zFpblwUd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDeOR2XaXGVTD0i/8RAlxYAKCmPqHbbsjbDogSifbU/cftzc/usACbB45n
VsgAJO8n7+Uw5YcmBBH98Wc=
=y57G
-----END PGP SIGNATURE-----

--djJN5oi3zFpblwUd--
