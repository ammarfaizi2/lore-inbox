Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUJWANR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUJWANR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUJWALe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:11:34 -0400
Received: from pop.gmx.de ([213.165.64.20]:34491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269281AbUJWAJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:09:47 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>, Gerd Knorr <kraxel@bytesex.org>
Subject: Re: 2.6.9-mm1
Date: Sat, 23 Oct 2004 02:13:57 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org>
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2302706.dJhGO34usC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410230214.00100.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2302706.dJhGO34usC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 22 October 2004 12:20, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9=
=2Dm
>m1/

I got this error without starting any tv application:
saa7134[0]/irq[10,4251666]: r=3D0x20 s=3D0x00 PE
saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit

I don't know when it exactly occurs, it was there in dmesg after a few hour=
s=20
the machine was running. (btw, no cable was connected to the card).

card related info:
$ dmesg | grep saa
saa7130/34: v4l2 driver version 0.2.12 loaded
saa7134[0]: found at 0000:00:08.0, rev: 1, irq: 19, latency: 32, mmio:=20
0xe2426000
saa7134[0]: subsystem: 16be:0003, board: Medion 7134 [card=3D12,autodetecte=
d]
saa7134[0]: board init: gpio is 0
saa7134[0]: i2c eeprom 00: be 16 03 00 08 20 1c 55 43 43 a9 1c 55 43 43 a9
saa7134[0]: i2c eeprom 10: ff ff ff ff 15 00 0e 01 0c c0 08 00 00 00 00 00
saa7134[0]: i2c eeprom 20: 00 00 00 e3 ff ff ff ff ff ff ff ff ff ff ff ff
saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
saa7134[0]: registered device video0 [v4l2]
saa7134[0]: registered device vbi0
saa7134[0]: registered device radio0

best regards,
dominik

--nextPart2302706.dJhGO34usC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXmiSAvcoSHvsHMnAQJCQAP+LMEOOSEqcGDC9VTURQ1WFfzEw6ZgmkJy
QT8UGojcp1OrlzlkeyOtiAXXQmuETHO1MRKjfUOgiYgN8VtkxAkJQJmTj3BR10Ko
K+55eqYCwA+T0wbHBWcUz89VaK8SyOVSK1W224rNmSUMLCz70j4FUQJOtLBWS1xb
lT4BTTLRuck=
=NT4F
-----END PGP SIGNATURE-----

--nextPart2302706.dJhGO34usC--
