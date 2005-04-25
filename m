Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVDYJLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVDYJLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVDYJLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:11:04 -0400
Received: from dea.vocord.ru ([217.67.177.50]:10976 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262455AbVDYJKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:10:36 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <d120d5000504210909f0e0713@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d5000504210909f0e0713@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Feuy3qShhFBqRTM0a4KF"
Organization: MIPT
Date: Mon, 25 Apr 2005 13:11:30 +0400
Message-Id: <1114420290.8527.56.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 25 Apr 2005 13:03:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Feuy3qShhFBqRTM0a4KF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-21 at 11:09 -0500, Dmitry Torokhov wrote:
> One more thing...
>=20
> On 4/21/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Thu, 2005-04-21 at 02:07 -0500, Dmitry Torokhov wrote:
> >=20
> > > w1-master-drop-attrs.patch
> > >    Get rid of unneeded master device attributes:
> > >    - 'pointer' and 'attempts' are meaningless for userspace;
> > >    - information provided by 'slaves' and 'slave_count' can be gather=
ed
> > >      from other sysfs bits;
> > >    - w1_slave_found has to be rearranged now that slave_count field i=
s gone.
> >=20
> > attempts is usefull for broken lines.
>=20
> It simply increments with every search i.e. every 10 secondsby default
> and does not provide indication of the quality of the wire.

When slaves can not be found until several attempts, it means line=20
is broken, how many time existing slave appeared/dissapeared during
/sys/bus/w1/devices/w1_master1/attempts says about link quality.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Feuy3qShhFBqRTM0a4KF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbLRCIKTPhE+8wY0RAmG1AKCOSRtTcjt5TQsFfsHjYHpjYxXeZwCffWXe
VPVevND8ByV/yJQCWb1wJj0=
=WNo1
-----END PGP SIGNATURE-----

--=-Feuy3qShhFBqRTM0a4KF--

