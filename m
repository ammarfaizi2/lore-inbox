Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUBIU7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 15:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUBIU7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 15:59:52 -0500
Received: from [195.167.170.152] ([195.167.170.152]:39319 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S265155AbUBIU7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 15:59:49 -0500
Date: Mon, 9 Feb 2004 20:59:47 +0000
From: Athanasius <link@miggy.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209205947.GO29203@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk> <20040209124739.GC1738@mail.shareable.org> <20040209134005.GA15739@axis.demon.co.uk> <Pine.LNX.4.53.0402090853020.8894@chaos> <20040209175119.GC1795@intern.kubla.de> <Pine.LNX.4.53.0402091327020.9986@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402091327020.9986@chaos>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2004 at 01:27:24PM -0500, Richard B. Johnson wrote:
> Really? Then you don't have anybody trying to log-in
> from the network using telnet, then do you?
>=20
> The BSD virtual terminals go in pairs, /dev/ptyp* /dev/ttyp*
>=20
> # ls -la /dev/ttyp*
> crw--w----   1 rjohnson tty        3,   0 Feb  9 13:17 /dev/ttyp0

  Then your telnetd needs 'fixing'.  This works fine, with /dev/pts on
my Debian stable/Woody system:

20:56:57 0$ w athan
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
athan    pts/26   XXXXXXXXXXXXXX   20:56    1:04   0.09s  0.09s  -bash

That's a telnet login just started.

  This is specifically using the 'telnetd-ssl' package in Debian.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkAn9MMACgkQIr2uvLNOS8MTDwCfU8G8t2aRJ68cspyve2tS//Tw
HxoAniMjDreNGAU7NumEW4V7Awx07tAL
=y4pe
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
