Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVHUEmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHUEmp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 00:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVHUEmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 00:42:45 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:55688 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750793AbVHUEmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 00:42:44 -0400
Message-ID: <4308062F.7080208@t-online.de>
Date: Sun, 21 Aug 2005 06:42:23 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.5: psmouse mouse detection doesn't work
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig047EE42CB107172D25CAE61B"
X-ID: SmazZwZeweuy+P0xc3RkLz7KP9k5NaiH9unABsh9Ksa0C-14s0UW6A
X-TOI-MSGID: 79e011cb-8757-4a21-925b-451aac1a8b51
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig047EE42CB107172D25CAE61B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi folks,

At boot time my Logitech mouse is detected as

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=event1 ts0 mouse0
B: EV=7
B: KEY=70000 0 0 0 0
B: REL=3

After manually reloading psmouse I get the expected

I: Bus=0011 Vendor=0002 Product=0002 Version=0049
N: Name="PS2++ Logitech Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=event1 ts0 mouse0
B: EV=7
B: KEY=f0000 0 0 0 0
B: REL=3

Using psmouse_noext=1 at boot time does not help.

How comes that this doesn't work on the first run?

I asked this more than a year ago, and somebody posted
a fix, but obviously it wasn't accepted.

What needs to be done to fix this?


Regards

Harri

--------------enig047EE42CB107172D25CAE61B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDCAYzUTlbRTxpHjcRAtT4AJ0WodEZz5XTZbqXndZhjeIZoe8v1QCffvMK
E54WUsFWPcsqgS5Col8CKB0=
=skSf
-----END PGP SIGNATURE-----

--------------enig047EE42CB107172D25CAE61B--
