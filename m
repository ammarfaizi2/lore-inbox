Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUF2Ggy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUF2Ggy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 02:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUF2Ggy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 02:36:54 -0400
Received: from mail.donpac.ru ([80.254.111.2]:32202 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265499AbUF2Ggw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 02:36:52 -0400
Date: Tue, 29 Jun 2004 10:36:45 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Thomas Sailer <sailer@scs.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] 2.6.7-mm2, Use it in AX.25 drivers
Message-ID: <20040629063645.GF13200@pazke>
Mail-Followup-To: Thomas Sailer <sailer@scs.ch>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <10880815524130@donpac.ru> <1088441634.4382.85.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <1088441634.4382.85.camel@kronenbourg.scs.ch>
User-Agent: Mutt/1.5.6+20040523i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 180, 06 28, 2004 at 06:53:54PM +0200, Thomas Sailer wrote:
> On Thu, 2004-06-24 at 14:52, Andrey Panin wrote:
> > This patch makes AX.25 drivers use common crc16 code.
>=20
> Hrm, isn't this bit of a misnamer?=20
>=20
> While the polynomial usually known as "CCITT" or "X25" is
> x^16+x^12+x^5+x^0, CRC-16 usually means the polynomial
> x^16+x^15+x^2+x^0. So to avoid confusion I suggest renaming it from
> CRC16 to CRCCCITT or similar...

Yeah I see, it's really CCITT CRC and it's really misnamed :(
I'll post a patch to fix it (probably tomorrow).

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Q39by9O0+A2ZecRAol7AJ9QolFzo3lwRKX2KXmAg3ZnJhCa2wCffaCf
W6kT8Qfk3BQuqYHwR7IFe20=
=cvS5
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
