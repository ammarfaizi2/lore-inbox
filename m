Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266018AbUFOXo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbUFOXo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUFOXo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:44:26 -0400
Received: from noc.safeweb.be ([82.138.76.65]:18324 "EHLO safeweb.be")
	by vger.kernel.org with ESMTP id S266018AbUFOXoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:44:24 -0400
Subject: Re: processes hung in D (raid5/dm/ext3)
From: Evaldo Gardenali <evaldo@gardenali.biz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040615162607.5805a97e.akpm@osdl.org>
References: <20040615062236.GA12818@porto.bmb.uga.edu>
	 <20040615030932.3ff1be80.akpm@osdl.org>
	 <20040615150036.GB12818@porto.bmb.uga.edu>
	 <20040615162607.5805a97e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MKGU91cjYMEGv83SFmwH"
Message-Id: <1087343060.2084.5.camel@server1.aguabranca.com.br>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 20:44:20 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MKGU91cjYMEGv83SFmwH
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi there

I always wondered if you guys would allow for killing a process like
this. I seldom have to reboot boxes with 30-40 users logged in doing
their work just because the evolution process of some user is stalled as
D. no dmesg error is given

Thanks
Evaldo

Em Ter, 2004-06-15 =E0s 20:26, Andrew Morton escreveu:
> OK, well I'd be suspecting that either devicemapper or raid5 lost an I/O
> completion, causing that page to never be unlocked.


--=-MKGU91cjYMEGv83SFmwH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
	assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAz4nU5121Y+8pAbIRAuQZAJ9e/7UXUB5yMCO+Lbk409hQUsXUYACgjYTo
zd8NYg1ECCYy5f4GEi2S9hQ=
=vxyS
-----END PGP SIGNATURE-----

--=-MKGU91cjYMEGv83SFmwH--

