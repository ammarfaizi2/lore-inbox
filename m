Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264873AbUFHHSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbUFHHSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 03:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUFHHSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 03:18:32 -0400
Received: from mail.donpac.ru ([80.254.111.2]:22681 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264873AbUFHHSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 03:18:30 -0400
Date: Tue, 8 Jun 2004 11:18:28 +0400
From: Andrey Panin <pazke@donpac.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm2
Message-ID: <20040608071828.GC19170@pazke>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040603015356.709813e9.akpm@osdl.org> <20040607124125.GT3776@pazke> <20040607220157.1e67ec39.akpm@osdl.org> <20040608051808.GA19170@pazke> <20040607222513.6bebcbb6.akpm@osdl.org> <20040608063417.GB19170@pazke> <20040607234235.1728f826.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <20040607234235.1728f826.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 159, 06 07, 2004 at 11:42:35 -0700, Andrew Morton wrote:
> Andrey Panin <pazke@donpac.ru> wrote:
> >
> > > Thanks.  Could you please regenerate a new diff?  The last one I had
> >  > doesn't seem to apply.
> >=20
> >  Patch rediffed agains 2.6.7-rc2-mm2 attached.
>=20
> Thanks, that works.
>=20
> It would be good if you could convert a couple of the existing dmi checks
> over to this API.  That way people can see how to use them and we know th=
at
> the new code is getting some exercise.
> Choosing some commonly-used table entries would be best.

Do you remember the reason of dropping my previous DMI patchset ? ;)=20

I can do it again, but this conversion will lead to new reject
horrors, due to changes in cursed dmi_blacklist array.
=20
Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxWhDby9O0+A2ZecRAhnRAJ0TZNFLpN+oEaqzl0YtAsYH2Kk+ZwCbBhi1
BjibDrloKWMVNAslhwN1IAs=
=zqtn
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
