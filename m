Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265254AbTLZXP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbTLZXP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:15:27 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:390 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265254AbTLZXPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:15:19 -0500
Subject: Re: 2.6.0 sound output - wierd effects
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1480000.1072479655@[10.10.2.4]>
References: <1080000.1072475704@[10.10.2.4]>
	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CQEm0bm7UZ1lZRLMWhzm"
Message-Id: <1072480660.21020.64.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 27 Dec 2003 01:17:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CQEm0bm7UZ1lZRLMWhzm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-12-27 at 01:00, Martin J. Bligh wrote:
> --Martin Schlemmer <azarah@nosferatu.za.org> wrote (on Saturday, December=
 27, 2003 00:52:47 +0200):
>=20
> > On Fri, 2003-12-26 at 23:55, Martin J. Bligh wrote:
> >> Upgraded my home desktop to 2.6.0.=20
> >> Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confir=
med
> >> this happens on mainline, as well as -mjb.
> >>=20
> >> If I leave xmms playing (in random shuffle mode) every 2 minutes or so=
,
> >> I'll get some wierd effect for a few seconds, either static, or the tr=
ack=20
> >> will mysteriously speed up or slow down. Then all is back to normal fo=
r=20
> >> another couple of minutes.
> >>=20
> >> Anyone else seen this, or got any clues? Else I guess I'm stuck playin=
g
> >> bisection search.
> >>=20
> >> Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:=
16:36 2003 UTC).
> >> PCI: Found IRQ 11 for device 0000:00:02.7
> >> intel8x0: clocking to 48000
> >> ALSA device list:
> >> # 0: SiS SI7012 at 0xdc00, irq 11
> >>=20
> >> AMD Athlon(tm) XP 2100+, no power management or ACPI compiled in.
> >>=20
> >=20
> > I have had this as well, around there, and started using OSS, which
> > worked fine (ICH5 onboard - also).  Somewhere when I tried again, it
> > worked fine, so this is what I am using now.  What version userland
> > libs/utils ?  OSS emulation?
> >=20

> Userspace stuff is stock Debian Woody, but not sure which libs you
> want the version of. The following might help, but probably doesn't
>=20

Over here the your main one if not using oss emu is alsa-lib  I used
0.9.8 for most of the time, but latest 1.0_rc[12] works as well.
Also for completeness you might include the version of alsa-utils.

Then, what does lsmod give?  Also, does xmms use oss or alsa as output
driver - switching between the two may or may not improve things?


--=20
Martin Schlemmer

--=-CQEm0bm7UZ1lZRLMWhzm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7MGUqburzKaJYLYRAsU9AKCBzbO0NMfjZFBZ4h8GQ2vXUB4JhQCfWpZB
KqewlJk85TBOCVIzrbAMnLw=
=0vNz
-----END PGP SIGNATURE-----

--=-CQEm0bm7UZ1lZRLMWhzm--

