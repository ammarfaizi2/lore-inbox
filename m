Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLXAnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTLXAnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 19:43:16 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:25277 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262740AbTLXAnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 19:43:14 -0500
Subject: Re: DevFS vs. udev
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Mark Mielke <mark@mark.mielke.cc>,
       Ian Kent <raven@themaw.net>, release@gentoo.org
In-Reply-To: <20031223220209.GB15946@kroah.com>
References: <E1AYl4w-0007A5-R3@O.Q.NET>
	 <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net>
	 <20031223173429.GA9032@mark.mielke.cc>  <20031223220209.GB15946@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W0EOw03liLlpF2g/CdPa"
Message-Id: <1072226715.6917.50.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Dec 2003 02:45:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W0EOw03liLlpF2g/CdPa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-24 at 00:02, Greg KH wrote:
> On Tue, Dec 23, 2003 at 12:34:29PM -0500, Mark Mielke wrote:
> >=20
> > I blame the udev people for this thread. :-)
>=20
> I blame all of the Gentoo users for this thread, and the ability for
> them to constantly dig up old threads that have been hashed out many
> times in the past without ever checking the archives.
>=20

Did they actually say that use Gentoo ? :/  I might have missed a
few posts, as these do tend to stretch (actually, a quick search of
udev and gentoo in the same message only result in me asking
questions or posting bugs, and then of course your prev post) ...

As for us (Gentoo), I might be finger-slapped later on, but official
standing (and to what I am working) is that we will support udev instead
of devfs by default when 2.6 goes mainline as default distro kernel
(heck, current unstable *will* use udev with 2.6 kernel if installed
instead of devfs, given that /dev is not mounted devfs).

In general it was the easier path to go devfs, and at the stage where
Gentoo arose from another distro, devfs was the 'in thing', so naturally
what we supported (as we do try to cover the more advance/experimenting
users).  NOTE that Gentoo _can_ work 100% without devsfs, and without
hacking things to pieces (just kernel boot param needed).

Alas for me, you should have realized that I was on the udev boat pretty
soon, and if it seems that our users do tend to start these threads,
well, we can only hope that they catch on (if they do need that) ;)

Lastly, a small nit with udev currently - how long will it be for in
kernel changes to be in place so that we do not need the 1sec delay?
It really sucks when you use a script/whatever to populate /dev, and
reboot quite frequent for new kernel/rc-script testing :)


Thanks,

--=20

Martin Schlemmer




--=-W0EOw03liLlpF2g/CdPa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6OGbqburzKaJYLYRAnIIAJ9NmyqDU/FVcWdV+Vk2SoBEv4JS5wCffBQp
kGZclH1koDORbEJmA6pcQEs=
=gNe+
-----END PGP SIGNATURE-----

--=-W0EOw03liLlpF2g/CdPa--

