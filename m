Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUEFL0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUEFL0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 07:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUEFL0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 07:26:38 -0400
Received: from mail.donpac.ru ([80.254.111.2]:19855 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262019AbUEFL0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 07:26:36 -0400
Date: Thu, 6 May 2004 15:26:41 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Port PIIX4 I2C driver to new DMI probing
Message-ID: <20040506112641.GD3295@pazke>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <10838395553579@donpac.ru> <1083839558750@donpac.ru> <20040506115358.A14696@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <20040506115358.A14696@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 127, 05 06, 2004 at 11:53:58AM +0100, Christoph Hellwig wrote:
> AFAIK the piix is used on a bunch of non-x86 platforms. =20

No problem here, on non-x86 dmi_check_system() is defined as:

static inline int dmi_check_system(struct dmi_system_id *list) { return 0; }

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmiDxby9O0+A2ZecRAl0DAJ47xi+l1Oc/R9CK/iAIid+52g7p6gCdGkE+
YY6KLhHB7ham2A9huYL91dY=
=Qf+Q
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
