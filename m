Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUJGPKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUJGPKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUJGPJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:09:51 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:44943 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S264085AbUJGPHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:07:36 -0400
Date: Thu, 7 Oct 2004 17:05:15 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: "Andrei A. Voropaev" <av@simcon-mt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: large auto variables cause segfault under 2.6
Message-ID: <20041007150515.GA5590@thundrix.ch>
References: <20041005132741.GD28160@avorop.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20041005132741.GD28160@avorop.local>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Tue, Oct 05, 2004 at 03:27:41PM +0200, Andrei A. Voropaev wrote:
>   int main( int argc, char **argv )
>   {
>        unsigned char  bRet =3D 0;
>  =20
>        char tst[67123456];
>  =20
>  =20
>        const char* pcSupportedParams =3D "d:t:lV:C:cP:h";
>  =20
>        printf("pcSupportedParams =3D %s\n");
>        return 0;
>   }

It might also crash because your printf is printing something odd.

				Tonnerre


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBZVsq/4bL7ovhw40RAntxAJ0RxEaHq7uBaIzT7Do5nBk3voTbiwCgkC3T
XVnBKGDIDpsHFitLClslAmk=
=Dy+I
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
