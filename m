Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267181AbUBMT1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267188AbUBMT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:27:45 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:56724 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S267181AbUBMT1l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:27:41 -0500
Subject: Re: [BK PATCHES] 2.6.x libata update
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040213184316.GA28871@gtf.org>
References: <20040213184316.GA28871@gtf.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IYFQTDH1LG8Ogqw+5WAT"
Message-Id: <1076700491.22542.38.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 13 Feb 2004 21:28:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IYFQTDH1LG8Ogqw+5WAT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-13 at 20:43, Jeff Garzik wrote:

Hi

> <jgarzik@redhat.com> (04/02/13 1.1634)
>    [libata] catch, and ack, spurious DMA interrupts
>   =20
>    Hardware issue on Intel ICH5 requires an additional ack sequence
>    over and above the normal IDE DMA interrupt ack requirements.  Issue
>    described in post to freebsd list:
>    http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
>   =20
>    Since the bug workaround only requires a single additional PIO or
>    MMIO read in the interrupt handler, it is applied to all chipsets
>    using the standard libata interrupt handler.
>   =20
>    Credit for research the issue, creating the patch, and testing the
>    patch all go to Jon Burgess.
>=20

Did you miss the mail I sent about this locking my box in under
20-30 mins?  It still looks the same as the previous one ....


Thanks,

--=20
Martin Schlemmer

--=-IYFQTDH1LG8Ogqw+5WAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBALSVLqburzKaJYLYRAscOAJ9mu8cp1B+v/5tzsmY8z0e6VqzKggCfUEhf
2Hcmy3jOyDVG2jRrXXkntRY=
=Fzb2
-----END PGP SIGNATURE-----

--=-IYFQTDH1LG8Ogqw+5WAT--

