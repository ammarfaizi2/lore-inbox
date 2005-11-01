Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVKANMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVKANMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 08:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVKANMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 08:12:48 -0500
Received: from attila.bofh.it ([213.92.8.2]:45002 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1750725AbVKANMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 08:12:48 -0500
Date: Tue, 1 Nov 2005 14:12:39 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051101131239.GA9480@wonderland.linux.it>
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org> <200511011340.41266.duncan.sands@math.u-psud.fr> <1130850242.21212.29.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1130850242.21212.29.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 01, David Woodhouse <dwmw2@infradead.org> wrote:

> Why can't we request the firmware again when the device is first used,
> if it wasn't present when the driver was first loaded?
For a start, because currently there is no device to use until the
firmware has been loaded.

If people really think that this is a problem which needs to be solved
then maybe a better solution would be to extend the $DEVPATH/loading to
allow loading the firmware at any time, even asyncronously after the
timeout.

--=20
ciao,
Marco

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDZ2nHFGfw2OHuP7ERAsu3AJsG1KuEVcZ3XHz9Bx8ZN/PTFqxs6QCcDEnD
hbQUW0P8at4fb5HfxHniKfc=
=xy71
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
