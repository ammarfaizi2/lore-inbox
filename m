Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270594AbTGTBxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 21:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270595AbTGTBxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 21:53:34 -0400
Received: from dhcp160176008.columbus.rr.com ([24.160.176.8]:21001 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S270594AbTGTBxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 21:53:30 -0400
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Sat, 19 Jul 2003 22:08:27 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: Alvaro Lopes <alvieboy@alvie.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Oops with ALSA and OSS emulation - 2.6.0-test1
Message-ID: <20030720020827.GA986@rivenstone.net>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Alvaro Lopes <alvieboy@alvie.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F1815A1.4070409@alvie.com> <s5hbrvrkeja.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <s5hbrvrkeja.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2003 at 06:03:53PM +0200, Takashi Iwai wrote:
> At Fri, 18 Jul 2003 16:43:29 +0100,
> Alvaro Lopes wrote:
> >=20
> > I'm getting the following oops when I start some audio applications:
>=20
> i've heard that this might happen if you compile without frame
> pointer.  anyway it must be fixed...

    I can verify that this oops goes away when building the kernel
with frame pointers.  I have a SiS 7012 and was seeing the same oops.


--=20
Joseph Fannin
jhf@rivenstone.net

Rothchild's Rule -- "For every phenomenon, however complex, someone will
eventually come up with a simple and elegant theory. This theory will
be wrong."

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GfmbWv4KsgKfSVgRAttZAJ9GPKm7cND6IHBIwWyOM4vY6MjCWwCfb1Xj
mezmWoqgDyOP+Urn5watW9s=
=TP1q
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
