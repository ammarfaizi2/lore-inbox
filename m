Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268533AbUILImP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268533AbUILImP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUILImP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:42:15 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:35231 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268533AbUILImH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:42:07 -0400
Date: Sun, 12 Sep 2004 01:42:04 -0700
To: alsa-devel@lists.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Some problems with snd-au8830
Message-ID: <20040912084204.GA22712@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	alsa-devel@lists.sourceforge.net,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello ALSA developers (cc: LKML for any inspiration),

Some snd-au8830 concerns..

I've recently been using my Aureal Vortex2 SQ2500 with ALSA's snd-au8830
to do some recording, and I got a humongous pile of these in my dmesg:

vortex: IRQ reg error
vortex: IRQ fifo error
vortex: IRQ dma error

and at the end of each batch:

vortex: 0 virt=3D0, real=3D0, delta=3D-1

Also, I can't seem to start up JACK using the ALSA backend:

loading driver ..
creating alsa driver ...
hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead
ALSA: cannot set period size to 1024 frames for capture
ALSA: cannot configure capture channel
cannot load driver module alsa

It only works when I use -p 512 (512 frames/period) and disable capture
outputs:

$ jackd -d alsa -p512 -P

creating alsa driver ... hw:0|-|512|2|48000|0|0|nomon|swmeter|-|32bit
control device hw:0
configuring for 48000Hz, period =3D 512 frames, buffer =3D 2 periods
Couldn't open hw:0 for 32bit samples trying 24bit instead
Couldn't open hw:0 for 24bit samples trying 16bit instead

It all works perfectly with my other machine which uses snd-intel8x0.
(Except, of course, that there's no nice hardware mixing.) Any ideas?

Thanks!

--=20
Joshua Kwan

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUQL3KOILr94RG8mAQLi/A//dYWegIpCxPx3vQB6kHAs1501j2ujVjvj
wQ4jbi/anDe9lID+p3e4SVqmfbJbHfH5pnb0+Dkr4Fh3UQ+/Uena/DBLJQJ3KQYE
UiQneRPu5swQfCEBAxu3tHXjmBscGcpZ3CJm4I30gIHj0m4ePUnaCKEdrOUMI9y1
LcpR0hP9GVUnrad7+fABJwwRLufU7iG2Hxp1ZHr9omVAj36f4MmYs+EripJoUNLC
b8MQtkzt267ojna/XhV0pjzmC2e2ostPTILmLGzuLwYlcL2WZf8KpKmJGal/W79z
BvJckkeisVwmE/e9IEPtGyQ/5YlEo6LXGl5jjU5iOwirau1ZkzaUkKI+H9W0lTPy
SUKnSnRqpg2BQjU5ElqnBtKYZ6OoqjLeL4r4LMW+Me24+h+Kt/wYNHZBfJabn288
l6IHF2i3oZ6Mhw3X4/N3pU4V0df/pqQIg+wCNdXCnWjxeMCjfPEFAFwpXBG5A96Z
/NHJok5dttkX/ShhZoN8z25pZ3jKQOrquZP24YBTKu2N7mjzLjgQlNhIEKSDOqJo
w8iARbztnLT7uoejINI4VRmd9uwtAIcmg74xmhQeJh7j3nrxAX6BU01Iry2Ku8aI
ZiwTXA36VJJnOjNZh7iHZjLQkM9V+NZzqFHw9sLKtUer9ytTgcta5lS0c3hq8MIb
nT8RcyHwpRA=
=Bopd
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
