Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265977AbSKDHrZ>; Mon, 4 Nov 2002 02:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265978AbSKDHrZ>; Mon, 4 Nov 2002 02:47:25 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:31244 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S265977AbSKDHrY>;
	Mon, 4 Nov 2002 02:47:24 -0500
Date: Mon, 4 Nov 2002 10:52:52 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [Q] how to mount ext2 partition accidentally mounted as ext3
Message-ID: <20021104075252.GA575@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello all,

Currently I'm working on resurrection of SGI Visual Workstation support=20
for 2.5 and some progress was made last week.=20
VISWS kernel even mounts root fs now (doesn't matter thet framebuffer drive=
r=20
can't draw anything on the screen and uhci-hcd doesn't work :))

But I made one stupid mistake: EXT3 filesystem was enabled in .config file
used for VISWS kernel compilation. So after the first boot of this kernel,
I found that old 2.2.10 kernel making my VISWS self hosting can't mount
root fs complaining about nonsupported filesystem feature.

My question is how can I make this fs mountable by 2.2.10 again ?

Best regards.

P.S. Does anyone on this planet owns VISWS datasheets ?

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9xidUBm4rlNOo3YgRAifDAJ0d6Cr4q3bStkuWM8SfkDadSVSbYQCfQoBJ
mY2Pu4y9/p8wS5B5/AztJdo=
=jA96
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
