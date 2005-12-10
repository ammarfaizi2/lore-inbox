Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVLJXoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVLJXoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 18:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVLJXoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 18:44:25 -0500
Received: from smtp06.auna.com ([62.81.186.16]:18088 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1030249AbVLJXoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 18:44:24 -0500
Date: Sun, 11 Dec 2005 00:46:11 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>, "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-mm1
Message-ID: <20051211004611.60248a2f@werewolf.auna.net>
In-Reply-To: <20051210233655.GH11094@kroah.com>
References: <20051204232153.258cd554.akpm@osdl.org>
	<20051206000524.74cb2ddc@werewolf.auna.net>
	<20051210233655.GH11094@kroah.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs81 (GTK+ 2.8.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_D1DY0we./4+81.+U18_6c/C";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Sun, 11 Dec 2005 00:44:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_D1DY0we./4+81.+U18_6c/C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Dec 2005 15:36:55 -0800, Greg KH <greg@kroah.com> wrote:

> On Tue, Dec 06, 2005 at 12:05:24AM +0100, J.A. Magallon wrote:
> > On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:
> >=20
> > >=20
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-=
rc5/2.6.15-rc5-mm1/
> > >=20
> > >=20
> >=20
> > I still get this oops on boot, then the machine freezes hard on the init
> > process:
> >=20
> > usb_set_configuration+0x22b/0x4df
> > usb_new_device+0x105/0x158
> > hub_port_connect_change+0x2de/0x37e
> > clear_port_feature+0x48/0x4d
> > hub_events+0x2aa/0x42f
> > hub_thread+0x14/0xe2
> > autoremove_wake_function+0x0/0x37
> > kthread+0x93/0x97
> > kthread+0x0/0x97
> > kernel_thread_helper+0x5/0xb
> >=20
> > udevd-event[694]: run_program: exec of program '/etc/udev/agents.d/usb/=
usbcore'
> > failed.
> >=20
> > I have udev-075, plain 2.6.15-rc5-mm1 + devfs-die + low1Gbmem.
> >=20
> > Any ideas ?
>=20
> Do you have the same problem with 2.6.15-rc5?
>=20
> What is in /etc/udev/agents.d/usb/usbcore?
> What distro is this?
> What kind of usb devices do you have attached?
>=20
> thanks,

Sorry for the delay. I'm just compiling all rcs from rc2 to rc5 and will
try to boot whith them.

For the rest of your questions:
- I have no /etc/udev/agents.d/usb/usbcore
- I have killed all the devfs compat scripts/rules (BTW, when will be final=
ly
  erradicated from  udev ;) ?
- Distro: Mandriva Cooker, updated daily, udev-077 now (the hangs I reported
  were with 075).

More info soon...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam3 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_D1DY0we./4+81.+U18_6c/C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDm2jDRlIHNEGnKMMRArQgAJ0Rf4PUq6kW5i91+1/xFhl4gQdY9gCgpRTU
XdBg6kBCh2ve8J8JkLNoXGs=
=tzs/
-----END PGP SIGNATURE-----

--Sig_D1DY0we./4+81.+U18_6c/C--
