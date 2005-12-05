Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVLEXEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVLEXEE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbVLEXEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:04:04 -0500
Received: from smtp05.auna.com ([62.81.186.15]:60901 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S1751491AbVLEXEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:04:02 -0500
Date: Tue, 6 Dec 2005 00:05:24 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051206000524.74cb2ddc@werewolf.auna.net>
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
References: <20051204232153.258cd554.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs67 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=t.fYmvNPMlyhn2JZIuN+_6";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Tue, 6 Dec 2005 00:03:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_=t.fYmvNPMlyhn2JZIuN+_6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/=
2.6.15-rc5-mm1/
>=20
>=20

I still get this oops on boot, then the machine freezes hard on the init
process:

usb_set_configuration+0x22b/0x4df
usb_new_device+0x105/0x158
hub_port_connect_change+0x2de/0x37e
clear_port_feature+0x48/0x4d
hub_events+0x2aa/0x42f
hub_thread+0x14/0xe2
autoremove_wake_function+0x0/0x37
kthread+0x93/0x97
kthread+0x0/0x97
kernel_thread_helper+0x5/0xb

udevd-event[694]: run_program: exec of program '/etc/udev/agents.d/usb/usbc=
ore'
failed.

I have udev-075, plain 2.6.15-rc5-mm1 + devfs-die + low1Gbmem.

Any ideas ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam3 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_=t.fYmvNPMlyhn2JZIuN+_6
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlMe0RlIHNEGnKMMRAjrKAJ9bMrMTEVtOz59u7GBLwK1rIk0cLACffNS4
O9lz2Gp1CT69TT0QGDe9hoQ=
=dRft
-----END PGP SIGNATURE-----

--Sig_=t.fYmvNPMlyhn2JZIuN+_6--
