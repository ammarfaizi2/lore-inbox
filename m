Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263669AbUDGOHy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263811AbUDGOHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:07:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55944 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263669AbUDGOHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:07:41 -0400
Subject: Re: panic when adding root=/LABEL=/  in grub.conf - newbie
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: sting sting <zstingx@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Sea2-F121U1x4ykaaEv0001bc59@hotmail.com>
References: <Sea2-F121U1x4ykaaEv0001bc59@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-78p8GY5AzLqdPgyEvAgi"
Organization: Red Hat UK
Message-Id: <1081346855.4680.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Apr 2004 16:07:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-78p8GY5AzLqdPgyEvAgi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-04-07 at 15:37, sting sting wrote:
> Hello,
>=20
> I am working with kenel 2.4.20 on Intel x86.
> Now I Had downloaded a kernel source to a different folder and build it.
> I added an entry in grub.conf
> When I choose to load that kernel everything is OK.
> It works wth no problem.
> But under /boot I see nothing of the original files (there is only one fi=
le=20
> there , kernel.h).


you need to use an initrd if you want mount-by-label to work for your
root filesystem.
on a RHL or Fedora system (and I suspect other distros too but I don't
know for sure) just doing a "make install" in the kernel source will
make one for you and put the kernel you just build into the grub config
etc etc etc.


--=-78p8GY5AzLqdPgyEvAgi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAdAsmxULwo51rQBIRAhlxAJwPGp5IrMJaoDPlDrOp6pCua6MUPgCgpTOC
SJH2UfUmUUwt0w/J0oo/Zbc=
=fxKL
-----END PGP SIGNATURE-----

--=-78p8GY5AzLqdPgyEvAgi--

