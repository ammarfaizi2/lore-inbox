Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbTIDN5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTIDN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:57:42 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:56586 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S265016AbTIDN5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:57:39 -0400
Date: Thu, 4 Sep 2003 15:57:37 +0200
From: Frederic Gobry <frederic.gobry@smartdata.ch>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 does not detect my touchpad
Message-ID: <20030904135737.GA7956@rhin>
References: <20030904115044.GA7114@rhin> <20030904142534.A2949@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20030904142534.A2949@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If you #define DEBUG in i8042.c and make sure you use a large
> log buffer then all probing is logged via syslog, and we can
> see what was sent and how the touchpad reacted.

Here we go:

kernel: mice: PS/2 mouse device common for all mice
kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [0]
kernel: drivers/input/serio/i8042.c: 47 <- i8042 (return) [0]
kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [0]
kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
kernel: drivers/input/serio/i8042.c: f0 -> i8042 (parameter) [0]
kernel: drivers/input/serio/i8042.c: 0f <- i8042 (return) [0]
kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
kernel: drivers/input/serio/i8042.c: 56 -> i8042 (parameter) [0]
kernel: drivers/input/serio/i8042.c: a9 <- i8042 (return) [0]
kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [0]
kernel: drivers/input/serio/i8042.c: a4 -> i8042 (parameter) [0]
kernel: drivers/input/serio/i8042.c: 5b <- i8042 (return) [0]
kernel: drivers/input/serio/i8042.c: d3 -> i8042 (command) [1]
kernel: drivers/input/serio/i8042.c: 5a -> i8042 (parameter) [1]
kernel: drivers/input/serio/i8042.c: a5 <- i8042 (return) [1]
kernel: drivers/input/serio/i8042.c: a7 -> i8042 (command) [1]
kernel: drivers/input/serio/i8042.c: 20 -> i8042 (command) [1]
kernel: drivers/input/serio/i8042.c: 56 <- i8042 (return) [1]
kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
kernel: drivers/input/serio/i8042.c: 46 -> i8042 (parameter) [1]
kernel: drivers/input/serio/i8042.c: 60 -> i8042 (command) [1]
kernel: drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [1]
kernel: drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [1]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [1]
kernel: drivers/input/serio/i8042.c: ab <- i8042 (interrupt, kbd, 1) [2]
kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [7]
kernel: drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [7]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: f8 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: f4 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: 02 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [8]
kernel: drivers/input/serio/i8042.c: f0 -> i8042 (kbd-data) [8]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [9]
kernel: drivers/input/serio/i8042.c: 00 -> i8042 (kbd-data) [9]
kernel: drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [9]
kernel: drivers/input/serio/i8042.c: 41 <- i8042 (interrupt, kbd, 1) [13]
kernel: input: AT Set 2 keyboard on isa0060/serio0
kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

--=20
 Fr=E9d=E9ric Gobry       SMARTDATA    	 =20
                      http://www.smartdata.ch/
 PGP: 5B44F4A5        Lausanne - Switzerland
                      +41 21 693 84 98

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/V0TQFjQHpltE9KURAj8NAKCfjHaPHmyqXSzenFHjm7ckz26s2ACdEmUC
ZY2+IQvMwfLQqvmocneK+w8=
=fxCE
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
