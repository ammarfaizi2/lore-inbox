Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUG0Q6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUG0Q6g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUG0Q6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:58:35 -0400
Received: from h-66-134-46-235.snvacaid.covad.net ([66.134.46.235]:15498 "EHLO
	mail.cryptobackpack.org") by vger.kernel.org with ESMTP
	id S265214AbUG0Q6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:58:33 -0400
Date: Tue, 27 Jul 2004 09:55:17 -0700
From: David Bryson <david@tsumego.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans
Message-ID: <20040727165517.GA7727@heliosphan.in.cryptobackpack.org>
Reply-To: David Bryson <david@tsumego.com>
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com> <410450CA.9080708@hispalinux.es> <pan.2004.07.26.05.35.49.669188@dungeon.inka.de> <4104AB98.8070506@bigfoot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <4104AB98.8070506@bigfoot.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 25, 2004 at 11:58:32PM -0700 or thereabouts, Erik Steffl wrote:
> >devfs allowes you to not have the driver loaded till you try to use it.
> >so udev _cannot_ do what devfs does.
> >
> >still I agree that the way kernel/hotplug/udev work is much better and
> >supporting the old style devfs works is not necessary. but please be
> >honest about the differences.
>=20
>   which means that now iPod automatically connects to firewire (and=20
> looses info on random tracks, sometime some other settings), instead of=
=20
> only connecting when I try to actually access it (the device).
>=20

I have been using ipods with linux for about 3 years.
And I see that it says "do not disconnect" even after I have unmounted
the file system.  I just disconnect it at this point and have not
had any problems.

>   it looks like there is no user level (end user, not admin) control on=
=20
> when the device drivers are loaded anymore - or is there?
>=20
>   Is there any way to load drivers on demand (obviously it's not job of=
=20
> udev but whose job it is?). What about unloading them - I unmount the=20
> disk and i think the iPod is disconnecred but it still says connected -=
=20
> is there any way to disconnect it (I guess similar problems arise with=20
> other hotplug devices)
>=20

This has been discussed in length on lkml many times during the
writing of udev.  IIRC the argument was something like:
 "we shouldn't be unloading modules because the memory taken up by a
 module in memory(a few k) isn't worth writing the code to save"

I also recall there was something about end user behavior, but I don't
remember the details.  Read the archives.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBBoj1LfsM4nS2FiARApMTAKCHLu07aE8o0/nDomsm276Xl59jeQCglQlH
t49DmS4vVAIn5/Llz8kh3O0=
=Y4tX
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
