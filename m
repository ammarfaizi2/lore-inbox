Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbULaW00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbULaW00 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 17:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbULaW00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 17:26:26 -0500
Received: from mailer2-5.key-systems.net ([81.3.43.243]:28886 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S262160AbULaW0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 17:26:18 -0500
Message-ID: <41D5D206.1040107@mathematica.scientia.net>
Date: Fri, 31 Dec 2004 23:26:14 +0100
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Questions about the CMD640 and RZ1000 bugfix support options
X-Priority: 4 (Low)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig633C14C9158860683C66E8DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig633C14C9158860683C66E8DB
Content-Type: multipart/mixed;
 boundary="------------090500060908070701050202"

This is a multi-part message in MIME format.
--------------090500060908070701050202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

First of all: A happy new year in advance!

Now to my question:
In the kernel-configuration there are the two options:
CONFIG_BLK_DEV_CMD640        CMD640 chipset bugfix/support
and
CONFIG_BLK_DEV_RZ1000        RZ1000 chipset bugfix/support

At least the second of those two seems to cause some little slowdown 
("This may slow disk throughput by a few percent, but at least things 
will operate 100% reliably.").
1) Is the bigfixing code only activated when a buggy chipset is detected 
or do I even have a slowdown with proper a properchipset?
2) Can some help me to find out if my system has one of those two 
chipsets. This might be a dumb question but I'm not sure if 
CMD640/RZ1000 are only some little IDE controller chipsets or if they 
were some kind of Southbridge/Nortbridge.
If got a Epox 8KTA2 mainboard (having VIA VT82C686A/B chipset).

Thanks in advance!

Greetings,
Christoph Anton Mitterer.

--------------090500060908070701050202
Content-Type: text/x-vcard; charset=utf-8;
 name="cam.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cam.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQpvcmc6TXVuaWNoIFVuaXZlcnNpdHkgb2YgQXBwbGllZCBTY2ll
bmNlcztEZXBhcnRtZW50IG9mIE1hdGhlbWF0aWNzIGFuZCBDb21wdXRlciBTY2llbmNlDQph
ZHI7cXVvdGVkLXByaW50YWJsZTtxdW90ZWQtcHJpbnRhYmxlOjs7TG90aHN0cmE9QzM9OUZl
IDM0O009QzM9QkNuY2hlbjtGcmVpc3RhYXQgQmF5ZXJuOzgwMzM1O0ZlZGVyYWwgUmVwdWJs
aWMgb2YgR2VybWFueQ0KZW1haWw7aW50ZXJuZXQ6Y2FtQG1hdGhlbWF0aWNhLnNjaWVudGlh
Lm5ldA0KdGVsO2hvbWU6KzQ5IDg5IDI0NDA5MzkwDQp0ZWw7Y2VsbDorNDkgMTcyIDg2MTcz
NDENCngtbW96aWxsYS1odG1sOlRSVUUNCnVybDpodHRwOi8vZmhtLmVkdS8NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------090500060908070701050202--

--------------enig633C14C9158860683C66E8DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB1dIJmstaume4L0MRAtuxAKCvIOnF8xiT9wLBuZu9zIAKrBAZfwCgq8E/
P2D3l1FnIxBS37gO3+SO75A=
=kiQp
-----END PGP SIGNATURE-----

--------------enig633C14C9158860683C66E8DB--
