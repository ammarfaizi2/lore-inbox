Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVIMROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVIMROL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVIMROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:14:11 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:59064 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S964880AbVIMROK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:14:10 -0400
Date: Tue, 13 Sep 2005 19:14:03 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
Message-ID: <20050913171403.GA3464@wavehammer.waldi.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <43232660.5070504@t-online.de> <EXCHG2003Aj5p1Fjxe0000006ad@EXCHG2003.microtech-ks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <EXCHG2003Aj5p1Fjxe0000006ad@EXCHG2003.microtech-ks.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2005 at 09:50:20AM -0500, Roger Heflin wrote:
> I guess I see 5 choices:

6.

> #1:
> Use lib for whatever the standard os/arch size is.
>=20
> Use lib32 for the non-standard size.

And what happens for machines with more than one 32 and one 64bit ABI?

> #2:=20
> Continue the current mess.
>=20
> #3:
> Use both lib32 and lib64 and maybe put a link from lib to the
> default one, probably lib64.
>=20
> #4:
> Use both lib32 and lib64 and don't put a link.
>=20
> #5:
> Designate the bit size in the name of the lib, ie libc.so64 or
> libc.so32 or something similar and put them all in the same
> directory and let the lib loading code take care of finding the
> correct size.

#6:
Use /lib/$arch-$os or similar and forgot about /lib/*.so.

Bastian

--=20
Beam me up, Scotty!  It ate my phaser!

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iEYEARECAAYFAkMnCNsACgkQnw66O/MvCNHCAACfQnhCJo19+erNTZoK+NbNxwk6
tooAn3vW+P5S5tCTfuwGbIQYh7jXtPR4
=5mxm
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
