Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbTGTNqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267166AbTGTNqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 09:46:24 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:946 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S267168AbTGTNpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 09:45:35 -0400
Date: Sun, 20 Jul 2003 10:00:35 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6-test1 startup messages?
Message-ID: <20030720140035.GC20163@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I just converted a box to 2.6-test1.  I've installed the module-init-tools
per another thread on the list.  Spread throughout the startup messages
of the system (Debian Unstable) are messages that read:

FATAL: Module /dev/tts not found
FATAL: Module /dev/tts not found
FATAL: Module /dev/ttsS?? not found
FATAL: Module /dev/ttsS?? not found

looking at /dev/tty* I have /dev/tty, /dev/tty0-tty63.  There is no
/dev/ttyS0 (serial console) or tts*.

Have they been renamed or did I miss something in my config?  Can anyone
point me to a thread?  Digging through the archives gave some great
reading material yet nothing that seemed to answer my problem.

Thanks for any pointers,
  I'd still gladly recomend Linux to my friends.
    Robert

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GqCD8+1vMONE2jsRAnP3AJ0b8tEsxJ5tO7Jbt8wz0kHWsrdt1gCfRjXw
I45xU6ECSKrBYwoSgUskZto=
=rIBr
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
