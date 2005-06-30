Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVF3J7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVF3J7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVF3J7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:59:54 -0400
Received: from nysv.org ([213.157.66.145]:56476 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262921AbVF3J7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:59:48 -0400
Date: Thu, 30 Jun 2005 12:59:27 +0300
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050630095926.GN11013@nysv.org>
References: <20050629135820.GJ11013@nysv.org> <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ypm5kX6DjiKlr0N"
Content-Disposition: inline
In-Reply-To: <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1ypm5kX6DjiKlr0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2005 at 01:19:12PM -0400, Horst von Brand wrote:
>> What pisses me off is the fact that Gnome and friends implement
>> their own incompatible-with-others VFS's and automounters and
>> stuff.
>Then get them to agree on a common framework! They are trying hard to get
>other parts of the GUI work well together, so this isn't far off in
>wishfull thinking land.

Looking at the situ with devfs vs udev, which should have been clear
ages ago, I don't think this will easily happen.

What would a gnome developer say if I told him to bugger off,
for the storm front of ivman is approaching?

Having the mount system in userspace makes sense, it's implemented
and done.

Having metadata in some database chunk in userland makes less
sense. For something that handles files and directories already,
it must be easier to patch them to look at the assorted meta
stuff inside the data object/file-as-dir.

>> Surely supporting this in the kernel and extending the LSB
>> to require this is the best step to take without infringing
>> anyone's freedom as such.
>
>Right. So then we have Gnome's way of doing things (Gnome isn't just for
>Linux!), KDE's way, XFCE's way, ... (ditto). Plus the kernel way. Flambee
>with a monthly thread on all reachable fora about "Why on &%@# does the
>%&~#@ GUI not use the *#%&@ kernel's way?!".

Sure it's not "Dictum, factum" but having the kernel team bless
an extended VFS which allows for metadata in any given FS is
a significantly bigger thing than a pissing contest between Gnome,
KDE and XFCE.

Gnome not being only for Linux, well, make the official stance that
the userspace VFS part is deprecated and to be used only on non-conforming
systems.

I haven't really used Gnome in long times, but if I have a picture
and Nautilus shows me a thumbnail of it, doesn't the thumbnail live
in a metadata VFS in userspace?
That's a lot less usable than an in-kernel solution, where
a serialized file can be sent to a conforming system or just
the most important, or wanted, part of the file to a non-conforming one.

That's the one thing all distros and managers and all have in
common, the kernel.

>This is /not/ the way of fxing that particular problem. Shoving random
>stuff into the kernel /can't/ force its use. At least not until Linux is
>the only Unixy system around, and that is still some way off. And when that
>has happened, the kernel's way must be /clearly/ better for /all/ users, or
>it won't matter.

No use in making bigger deals of other Unixes on which Gnome
and friends may run; my opinion and is that Linux should extend=20
things further than the tradition so far has been.

Maybe being better than the competitors may include breaking some
rules, changing the playing field, making it more flexible.

And the file system, and the VFS, is one of those things that are=20
nice to have in the kernel.

On a digressing side note, I found this classic:
http://kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

"If the kernel tomorrow switches to randomly assign major and minor numbers
to different devices, it would work just fine (this is exactly
what I am proposing to do in 2.7...)"

Apparently there isn't a 2.7 and no solid-enough testing ground
for this either..

--=20
mjt


--1ypm5kX6DjiKlr0N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCw8J+IqNMpVm8OhwRAn8nAKCaAy2kNUmAeMeFRJw8dOVs4dr52ACcDQ7N
h67/US+qTGchTwv4F0uRVvs=
=7MXA
-----END PGP SIGNATURE-----

--1ypm5kX6DjiKlr0N--
