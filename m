Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWGHTYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWGHTYT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 15:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWGHTYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 15:24:18 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:59284 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030252AbWGHTYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 15:24:17 -0400
Message-ID: <44B00653.3030303@t-online.de>
Date: Sat, 08 Jul 2006 21:24:03 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc1: zd1211rw doesn't work yet?
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig824BBD34ADAE85A68D27EC26"
X-ID: GQXCg4ZGYe08pk7DwZAMzp4Fd-FiQbKHKtabzeDguDFBzxK0GoCQY5
X-TOI-MSGID: 9147f167-9ae1-412b-934d-11c3242d9376
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig824BBD34ADAE85A68D27EC26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

I have used the "external" zd1211 driver for months without problems,
but the integrated version in 2.6.18-rc1 does not work for me.

iwconfig says:

wlan0     802.11g zd1211  ESSID:""
          Mode:Managed  Frequency:2.412 GHz  Access Point: Invalid
          Bit Rate=3D1 Mb/s
          Encryption key:XXXX-XXXX-XXXX-XXXX-XXXX-XXXX-XX   Security mode=
:open
          Link Quality:0  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0

I had expected something like this (running iwconfig for 2.6.17.3
+ zd1211 rev80):

wlan0     802.11b/g NIC  ESSID:"harrinet"
          Mode:Managed  Frequency=3D2.432 GHz  Access Point: XX:XX:XX:XX:=
XX:XX
          Bit Rate:54 Mb/s
          Retry:off   RTS thr=3D2432 B   Fragment thr:off
          Encryption key:****-****-****-****-****-****-**   Security mode=
:open
          Power Management:off
          Link Quality=3D84/100  Signal level=3D55/100  Noise level=3D0/1=
00
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:44
          Tx excessive retries:145  Invalid misc:0   Missed beacon:0

Please note that there is no MAC for 2.6.18-rc1.

???


Any hint would be highly appreciated. Of course I would be glad to
help debugging.


Regards

Harri




--------------enig824BBD34ADAE85A68D27EC26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEsAZZUTlbRTxpHjcRAtNwAKCA1oW6enowTR83xEKQbW2gQwXYZQCcC29E
9bYmje+8M9GHK9x2Eqjbkk8=
=grhM
-----END PGP SIGNATURE-----

--------------enig824BBD34ADAE85A68D27EC26--
