Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVBOTi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVBOTi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVBOThT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:37:19 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:39943 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261832AbVBOTfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:35:38 -0500
Date: Tue, 15 Feb 2005 20:35:36 +0100
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.cx>
To: linux-kernel@vger.kernel.org
Cc: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: RTC Inappropriate ioctl for device
Message-ID: <20050215193536.GP12421@roxor.cx>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.cx>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Randy.Dunlap" <rddunlap@osdl.org>
References: <20050213214145.GN12421@roxor.cx> <42117047.6020209@osdl.org> <20050215111636.GO12421@roxor.cx> <421227DF.8060209@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
In-Reply-To: <421227DF.8060209@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2005 at 08:48:31AM -0800, Randy.Dunlap wrote:
> Please add/enable the second line here:
> CONFIG_HPET_TIMER=3Dy
> # CONFIG_HPET_EMULATE_RTC is not set
>=20
> and try it again.

It works now. Well, I had not seen "Provide RTC interrupt" in
menuconfig... :)

Thanks for the tip.

Cheers.

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCEk8II2xgxmW0sWIRAga3AKCWflEvjgZrsxBpAf2xNBykZPv3HACaAxJ0
2Hiysb7z69lbpdK9CeFG1SE=
=AeVT
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--
