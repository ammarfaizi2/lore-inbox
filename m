Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUC2SCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbUC2SCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:02:21 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:29452 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S263084AbUC2SCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:02:08 -0500
Subject: 2.6.5-rc2-as1 patchset of ckstaircase5 and cfq and aa4
From: Antony Suter <suterant@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3C/gg+z01OtOFv/irx44"
Message-Id: <1080583313.15630.69.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 30 Mar 2004 04:01:53 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3C/gg+z01OtOFv/irx44
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This is a small patchset of certain recent disparate patches that all
improve kernel performance.

http://www.users.on.net/sutera/2.6.5-rc2-as1.patch.gz
http://www.users.on.net/sutera/2.6.5-rc2-as1.patch.gz.sign

The three source patches, applied to 2.6.5-rc2, are:

* Con Kolivas's new staircase cpu scheduler patch 5.
"patch-2.6.4-staircase5"
http://kerneltrap.org/node/view/2744

* Jens Axboe's CFQ IO scheduler as appears in 2.6.5-rc2-mm3
"cfq-4.patch"
& essential for any desktop system &

* Andrea Arcangeli's Priority-Based Radix Search Tree VM - the whole aa
patch really
"2.6.5-rc2-aa4.bz2"
http://kerneltrap.org/node/view/2746

I felt a kernel imperative to try these patches together after reading
the recent concentration of fine kerneltrap marketing (*wink*). I
usually use akpm's mm patchset. ck's own patchset now has staircase5,
but also includes a lot of extra baggage. -as1 is short and sweet so as
to be able to test these items together. I'm just an efficiency madman.

Please post all your experiences with ck's staircase cpu scheduler, as
it sounds very promising. We won't mention that he posted the all new
scheduler, declared it stable, and then skipped the country for 2
months... (*wink*)

My experience has been very positive so far. -mm is usually quite good -
the cfq io scheduler just rox. I usually run mozilla, xchat, gkrellm2,
evolution, gaim, azureus on java, on xfree86. Add a compile of a random
bunch of gentoo packages, and mplayer (with largish disk read buffer)
doing software playback of a dvd to an xv window. Grab the next x window
and drag it around rapidly over mplayer. No playback video or audio
skips, and no mouse stuttering.

My gpg key ID 657EC71A, "Antony Suter (200402)
<suterant@sourceforge.net>", can be fetched from keyserver pgp.mit.edu
or http://www.users.on.net/sutera/suterant.asc

I verified any signatures of the patches I started with. Apologies if
you dislike receiving SMIME signed email. Yay my first kernel patch. Boo
I skipped sleep last night. #include <ascii-trailing-scrawl.h>

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-3C/gg+z01OtOFv/irx44
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAaGSRZu6XKGV+xxoRAtXYAJ9KyNLMYg3T1p7gr/SGgcQ8L0dJlACgnR2v
ROefwHpFEEtwdxd/sPd0X+4=
=a4x8
-----END PGP SIGNATURE-----

--=-3C/gg+z01OtOFv/irx44--

