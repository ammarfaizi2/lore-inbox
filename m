Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUELSlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUELSlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265162AbUELSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:41:55 -0400
Received: from wblv-251-231.telkomadsl.co.za ([165.165.251.231]:42635 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264903AbUELSlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:41:52 -0400
Subject: Re: Sound with noise since 2.6.5
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian Almenar <aalmenar@conectium.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hzn8ddbre.wl@alsa2.suse.de>
References: <20040511144540.1ab51299@er-murazor.conectium.com>
	 <s5hzn8ddbre.wl@alsa2.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zYR31sMK3FEXYXCOV1Zd"
Message-Id: <1084387533.19414.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 20:45:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zYR31sMK3FEXYXCOV1Zd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-12 at 15:18, Takashi Iwai wrote:
> At Tue, 11 May 2004 14:45:40 -0400,
> Adrian Almenar wrote:
> >=20
> > [1  <text/plain; US-ASCII (7bit)>]
> > Hi,
> >=20
> > Since i installed 2.6.5 i cant get sound to work ok, i always have nois=
e like a tv without a signal but the sound its there but with that noise.
> > I tried with 2.6.6 but its the same, 2.6.4 doesnt have this problem.
> >=20
> > Module: intel8x0
> >=20
> > lspci -v reports:
> > 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97=
 Audio (rev 12)
> >         Subsystem: GVC/BCM Advanced Research: Unknown device 2147
> >         Flags: bus master, medium devsel, latency 0, IRQ 17
> >         I/O ports at ec00
> >         I/O ports at e800 [size=3D64]
> >=20
> >=20
> > dmesg says:
> > May 11 12:37:52 er-murazor kernel: intel8x0_measure_ac97_clock: measure=
d 49263 usecs
> > May 11 12:37:52 er-murazor kernel: intel8x0: clocking to 48000
> >=20
> >=20
> > Im attaching my .config
> >=20
> > Also i have alsa-lib 1.0.4.
> >=20
> > Anything else you need please ask me i will gladly help on this issue.
>=20
> which ac97 codec chip?
>=20
> a typical problem is 'IEC958 Input Monitor' is turned on.
> if you have such one, turn it off.
>=20
>=20

Hi

Pretty much the same issue.  I have much the same setup software side,
but its a Asus P4C800-E with a SoundMax AD1985 chip.  If more is needed,
let me know.


Thanks,

--=20
Martin Schlemmer

--=-zYR31sMK3FEXYXCOV1Zd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAonDNqburzKaJYLYRAvejAJ4rL27EbSh+Rqz6nnvCleYXDi5MxgCfWIDq
D5OJG+JBXwFGxMuzCxDvK6o=
=sn4i
-----END PGP SIGNATURE-----

--=-zYR31sMK3FEXYXCOV1Zd--

