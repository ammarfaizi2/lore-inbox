Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVGaS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVGaS0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 14:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVGaS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 14:26:54 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:16781 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S261868AbVGaSZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 14:25:59 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: domen@coderock.org
Subject: Re: [patch 3/5] Driver core: Documentation: use snprintf and strnlen
Date: Sun, 31 Jul 2005 20:25:42 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Jan Veldeman <Jan.Veldeman@advalvas.be>
References: <20050731111213.636613000@homer>
In-Reply-To: <20050731111213.636613000@homer>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3065627.m97MX9QZI1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507312025.54600.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3065627.m97MX9QZI1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Domen,

On Sunday 31 July 2005 13:12, domen@coderock.org wrote:
> From: Jan Veldeman <jan@mind.be>
> Documentation should give the good example of using snprintf and
> strnlen in stead of sprintf and strlen.
>=20
> PAGE_SIZE is used as the maximal length to reflect the behaviour of
> show/store.

The whole part of the Documentation is obsoleted by the fact,
that struct device has no structure member called "name".

People hacking sysfs should also try to hack the docu to match or
at least remove the obsolete parts of it.

So you can drop this patch altogether, I think.


Regards

Ingo Oeser



--nextPart3065627.m97MX9QZI1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC7ReyU56oYWuOrkARAoqkAKDFdb0jDjixLMEtsgVTOh0rapsY5wCgjlyN
xT+qEW+Qm32zhotjhmInz/4=
=KGiS
-----END PGP SIGNATURE-----

--nextPart3065627.m97MX9QZI1--
