Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbUAACBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 21:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265322AbUAACBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 21:01:16 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:17126 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265320AbUAACBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 21:01:12 -0500
Subject: Re: udev and devfs - The final word
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <3FF34B09.9040302@myrealbox.com>
References: <fa.af64864.ugabhg@ifi.uio.no> <fa.de7jae9.1jk0pjt@ifi.uio.no>
	 <3FF34B09.9040302@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EGKOmYVo1TdteYslwUas"
Message-Id: <1072922622.7243.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 04:03:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EGKOmYVo1TdteYslwUas
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 00:17, walt wrote:

> Note that the portage system already includes 'hotplug' and 'udev'
> but possibly lagging behind a bit:  hotplug-20030805-r3 and udev-011.
>=20

Afiak, we are current on udev :D  As for hotplug, I will have to check -
I see the latest usb patches cause usb.agent to complain about "09" not
valid token or such, but I have not looked into it yet.

> I have installed them both but just have not been able to get udev
> working yet -- I don't yet understand the problems well enough to tell
> you why, unfortutately.  (udev is still marked 'experimental' so I'm
> probably omitting important steps somewhere.)
>=20

Well, ideally you need baselayout-1.8.6.12-r3 as well ...  But if you
do have issues, try to bother me first, as it could be something I did
or did not do ;)

> If you could get udev working in gentoo you would become an instant
> hero rather than the target of nasty emails.  Think of how great
> that would be for your New Year!  We would become the wind beneath
> your wings instead of the rotten tomatoes in your mailbox  ;0)

Hmm, It works fine here?  With sysfs patches from Greg (not yet into
official linux bk), I only had to run alsa's script to create device
nodes, and create /dev/{core,stdin,stdout,stderr} - the rest udev
creates - although, yes we do have the ramdisk/tarball feature to
save permissions/additions.

But once again, drop me a mail first with versions of udev, baselayout,
kernel, hotplug, etc, if you have latest unstable baselaout and still
cannot get it working - it is a Gentoo issue after all (as well as the
fact that I was under the impression that it should _just_work_ if you
have latest everything unstable =3D) ...


Thanks,

--=20

Martin Schlemmer


--=-EGKOmYVo1TdteYslwUas
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/83/+qburzKaJYLYRAkXeAKCQxKgK73smk0DCGI4iQFe1qbw0YgCfYHSO
iptjH+mX1imhS+z+fOUVTK0=
=S0sF
-----END PGP SIGNATURE-----

--=-EGKOmYVo1TdteYslwUas--

