Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVEDTuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEDTuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 15:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEDTuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 15:50:40 -0400
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:58037 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S261197AbVEDTua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 15:50:30 -0400
Subject: Re: ata over ethernet question
From: David Hollis <dhollis@davehollis.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1416215015.20050504193114@dns.toxicfilms.tv>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0x9tvVQfDommJI3xLQwM"
Date: Wed, 04 May 2005 15:48:36 -0400
Message-Id: <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0x9tvVQfDommJI3xLQwM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-04 at 19:31 +0200, Maciej Soltysiak wrote:
> Hi,
>=20
> AOE is a bit new for me.
>=20
> Would it be possible to use tha AOE driver to
> attach one ATA drive in a host over ethernet to another
> host ? Or is it support for specific hardware devices only?
>=20
> You know, something like:
> # fdisk <device_on_another_host>
> # mkfs.ext2 <device_on_another_host/partition1>
> # mount <device_on_another_host/partition1> /mnt/part1
>=20

That seems to be the basic idea but there doesn't seem to be a provider
stack just yet, just a 'client' (though I could be wrong).  AOE is
similar in concept to iSCSI with the biggest difference being that AOE
runs over Ethernet and is thus non-routeable.  iSCSI operates over IP so
you can do all kinds of fun IP games with it.

> --
> Maciej
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
David Hollis <dhollis@davehollis.com>

--=-0x9tvVQfDommJI3xLQwM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCeScTxasLqOyGHncRAr5AAKCpDCOao3mNAgd6/8/sRhV221JBUACfe3Xu
h8buSkrT18VumI1YtztKVEU=
=rS68
-----END PGP SIGNATURE-----

--=-0x9tvVQfDommJI3xLQwM--

