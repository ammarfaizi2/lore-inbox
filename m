Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTEARLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbTEARLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:11:13 -0400
Received: from dialpool-210-214-83-111.maa.sify.net ([210.214.83.111]:35977
	"EHLO softhome.net") by vger.kernel.org with ESMTP id S261444AbTEARLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:11:12 -0400
Date: Thu, 1 May 2003 22:52:38 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
Message-ID: <20030501172238.GA13756@localhost.localdomain>
References: <200305010756_MC3-1-36E1-623@compuserve.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <200305010756_MC3-1-36E1-623@compuserve.com>
X-GPG-Fingerprint: A977 433E B71E 2D1C 6114  9F33 F390 527D 70D1 2799
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2003 at 07:54:03AM -0400, Chuck Ebbert wrote:
> Martin J. Bligh wrote:
>=20
> >> So there are many edits that needed to be done in lots of
> >> Kconfig and Makefiles if one selectively pulls or omits certain
> >> sub-directories.
> >
> > Indeed, I ran across the same thing a while back. Would be *really* nic=
e to
> > fix, if only so some poor sod over a modem can download a smaller tarba=
ll,
> > or save some diskspace.
>=20
>  I have seven source trees on disk right now.  Getting rid off all
> the archs but i386 would not only save tons of space, it would also
> make 'grep -r' go faster and stop spewing irrelevant hits for archs
> that I couldn't care less about.
>=20
>=20
> ------
>  Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I agree with you. Making different trees for different archs will make the =
tarball much smaller. Usually people only use one architecture and the othe=
r code lies waste. I think this has been discussed many times but It really=
 is worth doing.
--=20

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+sVfe85BSfXDRJ5kRAjrbAJ0dFYQYJCEXOgBm2JvOlDh+5Vp8+gCfbx6K
IFQ0AijyuFT61rdVJS/eMdA=
=h5u1
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
