Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWAGPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAGPXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWAGPXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:23:48 -0500
Received: from nsm.pl ([62.111.143.37]:48157 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750760AbWAGPXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:23:48 -0500
Date: Sat, 7 Jan 2006 16:23:25 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Almost 80% of UDP packets dropped
Message-ID: <20060107152325.GC9197@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com> <200601071704.52833.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M38YqGLZlgb6RLPS"
Content-Disposition: inline
In-Reply-To: <200601071704.52833.vda@ilport.com.ua>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M38YqGLZlgb6RLPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2006 at 05:04:52PM +0200, Denis Vlasenko wrote:
> On Saturday 07 January 2006 09:03, kernel coder wrote:
> > hi,
> >     I was trying to measure the UDP reception speed on my borad which
> > has MIPS 4kc processor with 133 MHZ speed.I was transfering 10mb file
> > from intel pentium 4 machine to MIPS board,but the recieved file was
> > only 900kB.
>=20
> UDP is connectionless. There is no way for sender to know that it must
> stop sending UDP packets because receiver cannot keep up. If sender
> and your network is producing and delivering UDP packets faster
> than receiver can consume them, packets will be lost.
>=20
> Use TCP instead.

 Or DCCP.

--=20
Tomasz Torcz                 "God, root, what's the difference?"
zdzichu@irc.-nie.spam-.pl         "God is more forgiving."


--M38YqGLZlgb6RLPS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDv9ztThhlKowQALQRAgAnAKDoDmaK/3pcWCcCiLBnXa7Rrht2CQCggc1x
bS01B9S4xIh2jihgK+6foDU=
=r0BR
-----END PGP SIGNATURE-----

--M38YqGLZlgb6RLPS--
