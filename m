Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWB1UdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWB1UdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWB1UdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:33:00 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:27339 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932559AbWB1UdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:33:00 -0500
Message-ID: <4404B35F.5000900@t-online.de>
Date: Tue, 28 Feb 2006 21:32:31 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: snd_intel8x0, 2.6.15.4: Alsa oss works, but pure alsa is way too
 fast
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig819D05C65B8AEEC9900D1AF3"
X-ID: E2RcHkZF8eNEe48C6NXU5m0yQ3bWewIGAPiX46v0Rv4YKUHodRXgwy
X-TOI-MSGID: eb7a97c6-a16c-4c69-94c1-784695b5681f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig819D05C65B8AEEC9900D1AF3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

Playing videos via mplayer I've got a problem: The Alsa-oss
emulation (mplayer -ao oss) seems to work, but for pure Alsa
(mplayer -ao alsa) the sound seems to be played too fast. And
I get a stream of error messages on the terminal saying

alsa-play: write error: Broken pipe0.000   1/  1 ??% ??% ??,?% 0 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.022   4/  4 ??% ??% ??,?% 2 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.043  11/ 11  2% 19%  2.7% 5 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.047  13/ 13  2% 16%  2.9% 6 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.059  19/ 19  1% 11%  2.5% 9 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.067  20/ 20  1% 10%  2.5% 10 0
alsa-play: trying to reset soundcard
alsa-play: write error: Broken pipe0.058  24/ 24  1%  8%  2.6% 10 0
alsa-play: trying to reset soundcard
:
:

lspci:
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
uname -a:
Linux pluto 2.6.15.4 #2 PREEMPT Sun Feb 12 16:51:38 CET 2006 x86_64 GNU/Linux


Any help would be highly appreciated.


Regards

Harri

--------------enig819D05C65B8AEEC9900D1AF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEBLNpUTlbRTxpHjcRApLtAJ92Hk7TgD6vWB/v0yOEWm3G1C0s3ACeICqA
jDdRg+gtm7R27BPE6m22y58=
=DT8E
-----END PGP SIGNATURE-----

--------------enig819D05C65B8AEEC9900D1AF3--
