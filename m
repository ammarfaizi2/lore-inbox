Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVA0HYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVA0HYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVA0HYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:24:19 -0500
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:3342 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S262526AbVA0HXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:23:55 -0500
Message-Id: <200501270723.j0R7NUxR017093@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Sabarinathan <sabarinathan@comodo.com>
Cc: sudhir@digitallink.com.np, linux-kernel@vger.kernel.org
Subject: Re: confguring grub to load new kernel 
In-Reply-To: Your message of "Thu, 27 Jan 2005 12:43:34 +0530."
             <41F8949E.1050308@comodo.com> 
From: Valdis.Kletnieks@vt.edu
References: <18910-220051427616499@M2W055.mail2web.com>
            <41F8949E.1050308@comodo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106810609_17814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jan 2005 02:23:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106810609_17814P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Jan 2005 12:43:34 +0530, Sabarinathan said:

> Put this entry in your grub.conf file
>=20
> title Red Hat Linux  (2.6.10)
>         root (hd0,5)
>         kernel /boot/vmlinuz-2.6.10 ro root=3DLABEL=3D/ rhgb quiet
>         initrd /boot/initrd-2.6.10.img

And *DONT* remove this one:

> >title Red Hat Linux (2.4.20-8)
> >        root (hd0,5)
> >        kernel /boot/vmlinuz-2.4.20-8 ro root=3DLABEL=3D/
> >        initrd /boot/initrd-2.4.20-8.img

So if you screwed up your 2.6.10 (did you remember to upgrade to
module-init-tools, and udev if you need it, and any other userspace
upgrades you need?) you can boot back to 2.4 easily and fix what you brok=
e
or failed to upgrade....

--==_Exmh_1106810609_17814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB+JbxcC3lWbTT17ARAkl1AJ4gXm6zhzSFLGxl5/FW0RmSUViKlgCg4Dl6
suEoXtrOS4XVQ0r2LSUEUAY=
=qMb6
-----END PGP SIGNATURE-----

--==_Exmh_1106810609_17814P--
