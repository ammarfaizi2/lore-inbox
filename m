Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265479AbSJXMfg>; Thu, 24 Oct 2002 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265481AbSJXMfg>; Thu, 24 Oct 2002 08:35:36 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:50187 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S265479AbSJXMff>;
	Thu, 24 Oct 2002 08:35:35 -0400
Date: Thu, 24 Oct 2002 16:39:40 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: yf <fyou@dsguardian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pls help me
Message-ID: <20021024123940.GA304@pazke.ipt>
Mail-Followup-To: yf <fyou@dsguardian.com>, linux-kernel@vger.kernel.org
References: <1035441048.727.3.camel@yf.dsguardian.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <1035441048.727.3.camel@yf.dsguardian.com>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A7=D1=82=D0=B2, =D0=9E=D0=BA=D1=82 24, 2002 at 02:30:45 +0800, yf wr=
ote:
> Hi, all,=20
>=20
> Recently I wrote a file-system under Linux. When mounting, it prints=20
> these messages. I use iget(sb, ino) to get the root inode.=20
>=20
> But when run into get_new_inode():wake_up(), it hangs there. Who could=20
> give me some hints?=20
>=20
> what the dmesg output:=20
> ************************************************************************
>=20
> =3D=3D> vvfs_init()=20
> =3D=3D> vvfs_read_super(<NULL>)=20
> =3D=3D> vvfs_connect(192.168.1.57, 52886)=20
> 2, 38606, 956410048=20
> <=3D=3D vvfs_connect()OK=20
> superblock ordinary filling ok=20
> =3D=3D> vvfs_alloc_inode()=20
> <=3D=3D vvfs_alloc_inode()=20
> =3D=3D> vvfs_read_inode(c67fb000)=20
> get sb sock=20
> get inode fid=20
> root inode=20
> fetch inode OK=20
> set server info OK=20
> <=3D=3D vvfs_read_inode()c67fb000=20
> Unable to handle kernel paging request at virtual address fffffffc=20

Address fffffffc looks like negative error code assigned to a pointer.

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9t+oMBm4rlNOo3YgRAhh+AJ9CLbt6Iq6esE0jeJXUTgC/hTnzYQCgjPRZ
g8FRSuKRuSpDL4cjbewEJWA=
=Auy9
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
