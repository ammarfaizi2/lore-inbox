Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbRCEVDX>; Mon, 5 Mar 2001 16:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130671AbRCEVDL>; Mon, 5 Mar 2001 16:03:11 -0500
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:2574
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S130663AbRCEVCu>; Mon, 5 Mar 2001 16:02:50 -0500
Date: Mon, 5 Mar 2001 13:02:36 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage log verbosity
Message-ID: <20010305130236.C22066@one-eyed-alien.net>
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010305165502.A10344@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010305165502.A10344@werewolf.able.es>; from jamagallon@able.es on Mon, Mar 05, 2001 at 04:55:02PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Umm.. all the printk's are inclosed with the ifdef, courtsey of a little
bit of #define magic.  I use it all the time (after all, I'm the
maintainer), and when I want it to shut up, it shuts up.

Are you sure you recompiled and installed properly?  Re-ran 'make dep'?
I've had reports of this before -- every one of them was solved by a proper
recompilation.

Matt

On Mon, Mar 05, 2001 at 04:55:02PM +0100, J . A . Magallon wrote:
> Hi,
>=20
> I have recently started to use an USB cd toaster and have a little proble=
m.
> Writer is driven by usb-storage and scsi-cdrom and scsi-generic drivers.
> Burning works fine.
>=20
> The problem is that the usb-storage module spits so many info-debug
> messages (even if I configured no debug in kernel config) that after
> a cd burn I end up with a 25 MB file in /var/log/messages and other 25MB
> in /var/log/kernel/info, so it fills my / partition.
>=20
> If someone know a fast way to shut up usb-storage, I'll be gratefull.
> If not, I will try to make a patch to enclose all that printk's into
> #ifdef CONFIG_USB_STORAGE_DEBUG.
>=20
> --=20
> J.A. Magallon                                                      $> cd =
pub
> mailto:jamagallon@able.es                                          $> mor=
e beer
>=20
> Linux werewolf 2.4.2-ac11 #1 SMP Sat Mar 3 22:18:57 CET 2001 i686
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We've made a business out of making money from annoying and stupid people.
I think you fall under that category.
					-- Chief
User Friendly, 7/11/1998

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6o/7sz64nssGU+ykRAldjAJ9G0KJjG5Uvg2QQsUlyMYJKCJRqsgCfSI8F
/FddR2c72CVDRg0OEcL1654=
=Zwx5
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
