Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUACR0w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 12:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUACR0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 12:26:52 -0500
Received: from mail.actcom.net.il ([192.114.47.15]:219 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263596AbUACR0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 12:26:50 -0500
Date: Sat, 3 Jan 2004 19:26:41 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, H.T.M.v.d.Maarel@marin.nl
Subject: Re: [patch against 2.6.1-rc1-mm1] replace check_region with request_region in isp16.c
Message-ID: <20040103172639.GQ1718@actcom.co.il>
References: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fZkDq/H4AmqaB8D"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0401031750330.4664@jju_lnx.backbone.dif.dk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0fZkDq/H4AmqaB8D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 03, 2004 at 06:06:20PM +0100, Jesper Juhl wrote:

> One thing that surprised me was that the isp16 driver does not seem to
> ever call request_region, it only ever calls check_region which confuses
> me a bit - wouldn't it need to (also with older kernels) always call
> request_region ?

I think so. It looks broken as it was, playing with the IO region
without requesting it first. Is anyone actually using this driver?=20

> I would appreciate it is someone could take a quick look at the patch and
> verify that it does the correct thing.

Looks correct to me.=20

Chers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--0fZkDq/H4AmqaB8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9vtPKRs727/VN8sRArRYAKCkF9ttiUyrVTIc4CVfB1f/bwtHGwCeKg5I
T/lyh0fYL+420tm7XzpoVhY=
=BuRz
-----END PGP SIGNATURE-----

--0fZkDq/H4AmqaB8D--
