Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVIEKxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVIEKxU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 06:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbVIEKxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 06:53:20 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:24999 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751027AbVIEKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 06:53:19 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
Date: Mon, 5 Sep 2005 12:51:32 +0200
User-Agent: KMail/1.7.2
Cc: Corey Minyard <minyard@acm.org>, viro@zeniv.linux.org.uk,
       Matt_Domsch@dell.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050901064313.GB26264@ZenIV.linux.org.uk> <43175DEC.4000600@acm.org> <20050901203043.GB10893@mipter.zuzino.mipt.ru>
In-Reply-To: <20050901203043.GB10893@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1366123.aI1Obq8JSJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509051251.41928.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1366123.aI1Obq8JSJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thursday 01 September 2005 22:30, Alexey Dobriyan wrote:
> On Thu, Sep 01, 2005 at 03:00:44PM -0500, Corey Minyard wrote:
> > Plus the scanning function I wrote handles arbitrary leading and=20
> > trailing space, etc.  Not a big deal, but a little nicer.
>=20
> You can say from the beggining that
>=20
> 	echo -n "    2   " >/proc/FUBAR
> =09
> is illegal and don't add bloat to kernel.

No, user interfaces should be robust.
Just remember the mantra "Be liberal in what you accept and
conservative in what you send."

I would suggest adding sth. like Coreys user_strtoul() to lib/string.c
which would reduce bloat and security threats for the kernel.


Regards

Ingo Oeser


--nextPart1366123.aI1Obq8JSJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDHCM9U56oYWuOrkARAjGaAJ943DjqZV0AZkVYKaIkJOBvDIzTagCgyJNT
5CbtOT7ikTosF5YI19AQcFs=
=KWkr
-----END PGP SIGNATURE-----

--nextPart1366123.aI1Obq8JSJ--
