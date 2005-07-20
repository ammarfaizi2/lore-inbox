Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVGTOUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVGTOUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGTOUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:20:21 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:15587 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261238AbVGTOUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:20:09 -0400
Date: Wed, 20 Jul 2005 17:20:08 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: snogglethorpe@gmail.com, miles@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: defconfig for v850, please
Message-ID: <20050720142008.GA6762@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jan Dittmer <jdittmer@ppp0.net>, snogglethorpe@gmail.com,
	miles@gnu.org, linux-kernel@vger.kernel.org
References: <42DE17DC.7050506@ppp0.net> <fc339e4a05072002355e4062d6@mail.gmail.com> <42DE1DDE.90503@ppp0.net> <fc339e4a0507200302d9f0141@mail.gmail.com> <20050720115218.GB9754@linux-sh.org> <42DE4B44.80504@ppp0.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <42DE4B44.80504@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 03:01:56PM +0200, Jan Dittmer wrote:
> Still, for basic compile testing and testing patches on other
> architectures it would be nice, when the patch writer can test his/her
> patch with a simple defconfig, without knowing a common platform for
> this target arch.

This is what KBUILD_DEFCONFIG is for. A general purpose defconfig that
has no hope of being kept up-to-date is worse than useless.

> arm is another one which uses this style, ia64 for example uses configs/*
> and defconfig. But on arm and sh `make defconfig` works contrary to v850.
>=20
That's because it looks at KBUILD_DEFCONFIG.. We absolutely do not want
to have an arch/foo/defconfig for most of these architectures, and I
doubt that v850 is an exception. Note that sh also does not have one.

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFC3l2Y1K+teJFxZ9wRArWnAJ9nPux965SVDVAKPP/EAgqXDZgUZwCePls3
IvHMp0/rhvM8Nh7flqLTPO4=
=n1dd
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
