Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTH3RPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbTH3RPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 13:15:16 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:59343 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S261844AbTH3RPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 13:15:03 -0400
Subject: Re: Linux 2.4.22-ac1
From: Martin List-Petersen <martin@list-petersen.se>
To: andersen@codepoet.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030829213136.GC3150@codepoet.org>
References: <200308291258.h7TCwmU24496@devserv.devel.redhat.com>
	 <3F4F5401.1070401@basmevissen.nl>  <20030829213136.GC3150@codepoet.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G3cRS7ZAsPfPweaVq+hq"
Message-Id: <1062263687.9747.14.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Aug 2003 19:14:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G3cRS7ZAsPfPweaVq+hq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-29 at 23:31, Erik Andersen wrote:
> On Fri Aug 29, 2003 at 03:24:17PM +0200, Bas Mevissen wrote:
> > How do you feel about adding things like Alsa
>=20
> I made a patch adding alsa to 2.4.x a while back...  You just
> need to apply these three patches. =20
>=20
>     http://codepoet.org/kernel/080-proc_dir_entry.bz2
>     http://codepoet.org/kernel/081-export-rtc.bz2
>     http://codepoet.org/kernel/082_alsa-0.9.2.bz2
>=20
> I've not updated it since 2.4.22-rc2, but it should patch into
> 2.4.22 without any problem...  It works for me anyways. =20

Got problems with those patched. I applied them to 2.4.22-ac1 (didn't
complain much), however soundcore fails loading:

# depmod-ae
depmod: *** Unresolved symbols in
/lib/modules/2.4.22-20030830-marlow/kernel/sound/soundcore.o
depmod:         snd_compat_devfs_remove

I've seen something like that in
http://www.geocrawler.com/archives/3/12349/2002/11/0/10252380/ on the
alsa-devel list.=20

Is your stuff pulled before that ?
Or is it just the fact, that i'm not automounting devfs ?

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
It is a hard matter, my fellow citizens, to argue with the belly,
since it has no ears.
-- Marcus Porcius Cato

--=-G3cRS7ZAsPfPweaVq+hq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/UNuHzAGaxP8W1ugRAro+AKDUuM/CJ/Hx+rWGIU08WKd2VTuFrgCfScQp
WZqgMgQKP7Jag3c4A8WlnMY=
=NH/N
-----END PGP SIGNATURE-----

--=-G3cRS7ZAsPfPweaVq+hq--

