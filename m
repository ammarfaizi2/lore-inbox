Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbTGTTqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbTGTTqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:46:08 -0400
Received: from 24-216-225-11.charter.com ([24.216.225.11]:6580 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S267981AbTGTTqC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:46:02 -0400
Date: Sun, 20 Jul 2003 16:01:02 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test1 startup messages?
Message-ID: <20030720200102.GE20163@rdlg.net>
Mail-Followup-To: Ivan Gyurdiev <ivg2@cornell.edu>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030720140035.GC20163@rdlg.net> <3F1AD2AA.9010603@cornell.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <3F1AD2AA.9010603@cornell.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Yes I am using devfs and it's working with the exact same config under
2.4.21 without the errors.


Thus spake Ivan Gyurdiev (ivg2@cornell.edu):

> Robert L. Harris wrote:
> >
> >  I just converted a box to 2.6-test1.  I've installed the=20
> >  module-init-tools
> >per another thread on the list.  Spread throughout the startup messages
> >of the system (Debian Unstable) are messages that read:
> >
> >FATAL: Module /dev/tts not found
> >FATAL: Module /dev/tts not found
> >FATAL: Module /dev/ttsS?? not found
> >FATAL: Module /dev/ttsS?? not found
> >
> >looking at /dev/tty* I have /dev/tty, /dev/tty0-tty63.  There is no
> >/dev/ttyS0 (serial console) or tts*.
> >
>=20
> Are you using devfs?
> I get the same messages with devfs.
> Looking up a /dev file that does not presently exist
> or have a corresponding module results in the above warnings.
> At boot time, on a redhat distro pam_console_apply tries to lookup
> the devices specified in /etc/security/console.perms, which causes a=20
> zillion warnings for me. The question is - are those warnings to correct=
=20
> way to handle a devfs lookup of a nonexisting device. I don't remember=20
> getting warnings under 2.4. Maybe I did, and just didn't notice (but I=20
> doubt it). They're certainly annoying and I don't like them.
>=20
> P.S. Not a kernel developer - just a tester :)
>=20
>=20

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/GvT+8+1vMONE2jsRAroQAJ9Zt4EZ0De2byU9IjOuu6bMO1yfRwCg0MPz
qFupR8qvlzRyWXp6MMiFGpo=
=l1w7
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
