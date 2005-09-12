Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVILSuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVILSuI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVILSuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:50:07 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:416 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S932141AbVILSuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:50:06 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Alexander Nyberg <alexn@telia.com>
Subject: Re: 2.6.13-mm3 [OOPS] vfs, page_owner, full reproductively, badness in vsnprintf
Date: Mon, 12 Sep 2005 20:48:42 +0200
User-Agent: KMail/1.7.2
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050912024350.60e89eb1.akpm@osdl.org> <6bffcb0e050912044856628995@mail.gmail.com> <20050912175433.GA8574@localhost.localdomain>
In-Reply-To: <20050912175433.GA8574@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1446325.ptMvFJiQiV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509122049.15463.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1446325.ptMvFJiQiV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 September 2005 19:54, Alexander Nyberg wrote:
> Gah, I'm such a fantastic programmer.
>=20
> I don't know what mc is up to but the error checking in read_page_owner
> is flawed wrt snprintf which could cause the 'size' argument to snprintf
> to become negative and if so overwrite beyond 'buf'.

To prevent this, clever people invented the seq_file-API.
Even more clever people tend to use it :-)

I personally love it!


Regards

Ingo Oeser


--nextPart1446325.ptMvFJiQiV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJc2rU56oYWuOrkARArruAKCm7S9OvQ1ZPx+jB+IV6XSG9AuFVwCgxAZc
rTonF2ivkiEV0u7VWDh8JUA=
=m5HG
-----END PGP SIGNATURE-----

--nextPart1446325.ptMvFJiQiV--
