Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266646AbRGEHhK>; Thu, 5 Jul 2001 03:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbRGEHhA>; Thu, 5 Jul 2001 03:37:00 -0400
Received: from cs666822-222.austin.rr.com ([66.68.22.222]:14211 "HELO
	hatchling.taral.net") by vger.kernel.org with SMTP
	id <S266648AbRGEHgs>; Thu, 5 Jul 2001 03:36:48 -0400
Date: Thu, 5 Jul 2001 02:36:47 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: tty->name conversion?
Message-ID: <20010705023647.A18014@taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I noticed that ps still relies on device numbers to determine tty, since
/proc/*/stat only exports the device number. Is there any way to get the
device name? I noticed that it is not present in tty_struct anywhere
(proc_pid_stat() uses task->tty->device, which is a kdev_t).

This would be useful to consider if we ever intend to create real
unnumbered character/block devices.

--=20
Taral <taral@taral.net>
(This message is digitally signed. Please encrypt mail if possible.)
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtEGQ8ACgkQ7rh4CE+nYElMegCdHG8kPZ5Vi1ql/uD7/xco9Awt
c3oAn1b8nsFydpsBeAmTskMrYCJYY548
=zA07
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
