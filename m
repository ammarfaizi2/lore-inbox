Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282118AbRKWK3B>; Fri, 23 Nov 2001 05:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282116AbRKWK2v>; Fri, 23 Nov 2001 05:28:51 -0500
Received: from bartender.antefacto.net ([193.120.245.19]:49037 "EHLO
	bartender.internal.antefacto.com") by vger.kernel.org with ESMTP
	id <S282118AbRKWK2k>; Fri, 23 Nov 2001 05:28:40 -0500
Date: Fri, 23 Nov 2001 10:28:28 +0000
From: "John P. Looney" <john@antefacto.com>
To: linux-kernel@vger.kernel.org
Subject: Etiquette of getting a driver into the kernel
Message-ID: <20011123102828.D27980@antefacto.com>
Reply-To: john@antefacto.com
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-OS: Red Hat Linux 7.2/Linux 2.4.131afo
X-URL: http://www.redbrick.dcu.ie/~valen
X-GnuPG-publickey: http://www.redbrick.dcu.ie/~valen/public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 I've a Phison "usb multiple card reader". Nice little device, though I
think the driver isn't the best (block size of 1k when reading & writing
gets 80k/sec, block size of 32k gets 850k/sec).

 The device came with a driver for linux on a floppy, as a patch against
2.4.2. It needed a little beating to get it to compile, and it caused
not-a-few kernel panics. Some kind soul on the net mailed me a newer
version, which does work a lot more reliably. The email address given for
the original author (in the source) doesn't seem to answer requests like
"is there a newer version of this driver", or "Is this driver GPL'd ?".

 Basically, I've a patch for it against 2.4.15, and I'm wondering how I
should go about getting it into the kernel, so others can debug it for me :)

John

--=20
_______________________________________
John Looney             Chief Scientist
a n t e f a c t o     t: +353 1 8586004
www.antefacto.com     f: +353 1 8586014


--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7/iTMYBVPvqzGrWgRAi51AJ94LN9Mi62AGdsSSWdsqFK7RO1g2ACZAcKZ
BNRaBrDkFAcqTDLkO0nZ5C8=
=8c7E
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
