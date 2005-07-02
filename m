Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVGBQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVGBQrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVGBQrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:47:36 -0400
Received: from smtp2.irishbroadband.ie ([62.231.32.13]:54744 "EHLO
	smtp2.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261191AbVGBQrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:47:22 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120321322.5073.4.camel@mulgrave>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+gXiVETEcM9B9TC//Mvg"
Organization: Gentoo Linux
Date: Sat, 02 Jul 2005 17:46:28 +0100
Message-Id: <1120322788.22046.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+gXiVETEcM9B9TC//Mvg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 12:22 -0400, James Bottomley wrote:
> Well, my best guess is that this is a double bug.  I think the
> aic7xxx_core is processing the reject wrongly and the device is
> rejecting a QAS or IU negotiation attempt.
>=20
> So, see if the attached patch helps.

Unfortunately I see no visible changes in the output; the system hangs
at the same point.
What does that asynchronous line mean? I  see that on all kernels that
do not boot properly. 2.6.12; 2.6.12.1 and 2.6.12.2 do not display it,
and boot just fine.

target0:0:0: asynchronous

It appears even before vendor & model information is displayed for the
Fujitsu drive.

> James

Tony.


--=-+gXiVETEcM9B9TC//Mvg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxsTkp5vW4rUFj5oRAr/YAJ9tPuwTwJJ7nWywS5cPxoMtkfWpmQCfRbYV
3+VGphrHLIjhjPqzl9owsIs=
=RMKJ
-----END PGP SIGNATURE-----

--=-+gXiVETEcM9B9TC//Mvg--

