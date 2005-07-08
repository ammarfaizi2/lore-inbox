Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262630AbVGHGUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262630AbVGHGUZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVGHGUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:20:25 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:56227 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262630AbVGHGUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:20:22 -0400
Date: Fri, 8 Jul 2005 16:20:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: akpm@osdl.org, paulus@samba.org, anton@samba.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Kill bitfields in ppc64 hash code
Message-Id: <20050708162001.48a1f460.sfr@canb.auug.org.au>
In-Reply-To: <20050708055855.GD30761@localhost.localdomain>
References: <20050708044653.GC30761@localhost.localdomain>
	<20050708055855.GD30761@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__8_Jul_2005_16_20_01_+1000_j4QgbHauEMbglT1s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__8_Jul_2005_16_20_01_+1000_j4QgbHauEMbglT1s
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Jul 2005 15:58:55 +1000 David Gibson <david@gibson.dropbear.id.au=
> wrote:
>
> On Fri, Jul 08, 2005 at 02:46:54PM +1000, David Gibson wrote:
> > Andrew, please apply:
>=20
> Ahem.  Or perhaps the version which builds on iSeries too.
>=20
> This patch removes the use of bitfield types from the ppc64 hash table
> manipulation code.
>=20
> Signed-off-by: David Gibson <dwg@au1.ibm.com>

Looks good to me for iSeries (built and booted).

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__8_Jul_2005_16_20_01_+1000_j4QgbHauEMbglT1s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCzhsYFdBgD/zoJvwRAsW/AJ9M3spQUL7COfNjMEsNXVtG50qmigCcD371
DhW+E8rsb2pN0UWXbJa3Raw=
=+5IU
-----END PGP SIGNATURE-----

--Signature=_Fri__8_Jul_2005_16_20_01_+1000_j4QgbHauEMbglT1s--
