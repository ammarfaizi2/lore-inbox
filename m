Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbTF3Q5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTF3Q5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 12:57:41 -0400
Received: from debian4.unizh.ch ([130.60.73.144]:47825 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265468AbTF3Q4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 12:56:14 -0400
Date: Mon, 30 Jun 2003 19:10:33 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: restarting a kernel thread
Message-ID: <20030630171033.GA27703@diamond.madduck.net>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.20-grsec1.9.9g+freeswan1.99+preempt20030413-diamond i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i am doing some USB development these days and just managed to crash
khubd:

  kernel:  <6>note: khubd[9] exited with preempt_count 1

the system seems happy still, USB is not working anymore, though.

I have USB support built into the kernel, and a custom driver
written as a module.

Restarting would fix the problem and get USB back into operation,
but I am wondering if there is a way to restart the khubd kernel
thread manually. Is there?

I am soon going to switch to UML for this kind of development...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid PGP subkeys? use subkeys.pgp.net as keyserver!
=20
stay the patient course.
of little worth is your ire.
the network is down.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/AG8JIgvIgzMMSnURAgYwAJ49NXXtg4rGZR1KnQnoWLDlE7VnGQCgg6dt
jGj2M5d0OrcCJI+1vq9z+YU=
=F62/
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
