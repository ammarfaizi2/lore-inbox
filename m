Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVAQXgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVAQXgZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVAQXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 18:34:15 -0500
Received: from smtp08.auna.com ([62.81.186.18]:14543 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261521AbVAQXbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 18:31:50 -0500
Date: Mon, 17 Jan 2005 23:31:47 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-rc1-mm1
To: Daniel Drake <dsd@gentoo.org>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20050114002352.5a038710.akpm@osdl.org>
	<20050116005930.GA2273@zion.rivenstone.net> <41EAD805.70807@gentoo.org>
In-Reply-To: <41EAD805.70807@gentoo.org> (from dsd@gentoo.org on Sun Jan 16
	22:09:25 2005)
X-Mailer: Balsa 2.2.6
Message-Id: <1106004708l.24046l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-5TugaiMmySCUtTxI6i4l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-5TugaiMmySCUtTxI6i4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On 2005.01.16, Daniel Drake wrote:
> Hi,
>=20
> Joseph Fannin wrote:
> > On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
> >=20
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc=
1/2.6.11-rc1-mm1/
> >=20
> >=20
> >>waiting-10s-before-mounting-root-filesystem.patch
> >>  retry mounting the root filesystem at boot time
> >=20
> >=20
> >     With this patch, initrds seem to get 'skipped'.  I think this is
> > probably the cause for the reports of problems with RAID too.
>=20
> This patch should do the job. Replaces the existing=20
> waiting-10s-before-mounting-root-filesystem.patch in 2.6.11-rc1-mm1.
>=20
> Daniel
>=20

> Retry up to 20 times if mounting the root device fails.  This fixes booti=
ng
> from usb-storage devices, which no longer make their partitions immediate=
ly
> available. Also cleans up the mount_block_root() function.
>=20
> Based on an earlier patch from William Park <opengeometry@yahoo.ca>
>=20
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
>=20

This does not patch against -mm1. -mm1 looks like a mix of plain 2.6.10
and your code.
Could you revamp it against -mm1, please ? I looked at it but seems out
of my understanding...

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam4 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #2


--=-5TugaiMmySCUtTxI6i4l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB7ErkRlIHNEGnKMMRAg3AAJ4tDQRzg6LoOvlCzv9CgXSbSzj6ZACgo6C9
OZ3zt4bQv69phoVoOes189M=
=KzzZ
-----END PGP SIGNATURE-----

--=-5TugaiMmySCUtTxI6i4l--

