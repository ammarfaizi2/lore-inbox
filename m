Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265350AbUAJTi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbUAJTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:38:12 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:136 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265338AbUAJThp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:37:45 -0500
Subject: Re: Q re /proc/bus/i2c
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: gene.heskett@verizon.net
Cc: John Lash <jlash@speakeasy.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200401101415.46745.gene.heskett@verizon.net>
References: <200401100117.42252.gene.heskett@verizon.net>
	 <20040110095911.7b99d40c.jlash@speakeasy.net>
	 <1073758800.9096.12.camel@nosferatu.lan>
	 <200401101415.46745.gene.heskett@verizon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yInL9AZEuz11DoLEjm+g"
Message-Id: <1073763636.9096.18.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 21:40:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yInL9AZEuz11DoLEjm+g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 21:15, Gene Heskett wrote:
> On Saturday 10 January 2004 13:20, Martin Schlemmer wrote:
> >On Sat, 2004-01-10 at 17:59, John Lash wrote:
> >> In a 2.6.x kernel, the sensors information is kept in sysfs. I
> >> haven't actually tried installing lmsensors on my 2.6 system, but
> >> if I look in: /sys/bus/i2c/devices/0-002d/
> >> I can see files for all of the sensors on my system.
> >>
> >> Check below in your last mail where it is complaining about
> >> "Algorithm: Unavailable from sysfs".
> >
> >Right, needs sysfs mounted.  You should (after creating /sys) add
> >the following to /etc/fstab:
> >
> >--
> >none	/sys	sysfs	defaults	0 0
> >--
>=20
> >From my fstab, and its been there for several months now:
> ---
> none    /sys    sysfs   defaults        0 0
> ---
> Also, from my mtab:
> Well, I was gonna quote that too, but apparently my entry in=20
> rc.sysinit doesn't record it in mtab.  I've got a message in the log=20
> to the effect that its already mounted or is otherwise busy.  I'd put=20
> that line in rc.sysinit a few (2-3) weeks ago, thinking it needed to=20
> be done earlier than the fstab driven mount.  I'll remove it from=20
> rc.sysinit and reboot for effects.
>=20
> Done.
>=20
> I also moved the mount of /proc/bus/usb to fstab while I was at it,=20
> and they are all recorded in mtab now:
> ---
> none /proc/bus/usb usbfs rw 0 0
> none /sys sysfs rw 0 0
> ---
> But the response from sensors is still as I posted before, "Algorithm:=20
> Unavailable from sysfs"
>=20
> tvtime still works, so thats promising.  Sounds like they (the Feed=20
> Bag Information folks) got something/someone(s) trapped on a plane at=20
> Dulles according to FOX News, who are of course makeing the usual=20
> mountain out of whats probably a molehill.
>=20
> Next thing to check?

What mobo (make, model, etc - sorry, missed that), and do you
have appropriate modules loaded.  Also, maybe add a dmesg.

--=20
Martin Schlemmer

--=-yInL9AZEuz11DoLEjm+g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAFU0qburzKaJYLYRAsmTAJ9a0sZ30ScOL18QsISfkGVz70KdewCfZeyA
N75W3UwZSZ2tSyW83Nv5qDk=
=finb
-----END PGP SIGNATURE-----

--=-yInL9AZEuz11DoLEjm+g--

