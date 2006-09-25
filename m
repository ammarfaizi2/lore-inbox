Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWIYMKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWIYMKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWIYMKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:10:08 -0400
Received: from hs-grafik.net ([80.237.205.72]:45318 "EHLO hs-grafik.net")
	by vger.kernel.org with ESMTP id S1750809AbWIYMKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:10:06 -0400
From: Alexander Gran <alex@grans.eu>
To: Tilman Schmidt <tilman@imap.cc>
Subject: Re: [2.6.18-rc7-mm1] slow boot
Date: Mon, 25 Sep 2006 14:09:59 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <4516B966.3010909@imap.cc>
In-Reply-To: <4516B966.3010909@imap.cc>
X-Face: ){635DT*1Z+Z}$~Bf[[i"X:f2i+:Za[:Q0<UzyJPoAm(;y"@=?iso-8859-15?q?LwMhWM4=5D=60x1bDaQDpet=3B=3Be=0A=09N=5CBIb8o=5BF!fdHrI-?=
 =?iso-8859-15?q?=7E=24ctS=3F!?=,U+0}](xD}_b]awZrK=>753Wk;RwhCU`Bt(I^/Jxl~5zIH<
 =?iso-8859-15?q?=0A=09XplI=3A9GKEcr/JPqzW=3BR=5FqDQe*=23CE=7E70=3Bj=25Hg8?=
 =?iso-8859-15?q?CNh*4?=<
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1423870.Wt5x5ZRnlU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609251409.59927@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1423870.Wt5x5ZRnlU
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

simillar behavior here, but at different parts. 2.6.18-rc7-mm1 takes way=20
longer than 2.6.16-mm1 (the last one working here to boot.
I have delays (seconds!) between:=20
intel8x0_measure_ac97_clock: measured 50450 usecs
intel8x0: clocking to 48000
and=20
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/serio0/serio2/input3

I'll try to find out more, however I'm quite busy (and ill...) atm. If Tilm=
an=20
hadn't mailed, I wouldn't report either, but it looks I'm not the only one=
=20
with these problem ;-O
BTW: No real debuging enabled here, just sysrq and dmesg buffer size.

regards
Alex

=2D-=20
Encrypted Mails welcome.
PGP-Key at http://www.grans.eu/misc/pgpkey.asc | Key-ID: 0x6D7DD291
More info at http://www.grans.eu/Alexander_Gran.html

--nextPart1423870.Wt5x5ZRnlU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFF8cX/aHb+2190pERAoy7AKCAc/VJBI7WBg9txynv5OG51aTHBwCdErsy
edynTuAb5H7qW7V7Zf06KBI=
=F6Gm
-----END PGP SIGNATURE-----

--nextPart1423870.Wt5x5ZRnlU--
