Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUAMWy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUAMWwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:52:12 -0500
Received: from debian4.unizh.ch ([130.60.73.144]:28907 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S265878AbUAMWuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:50:51 -0500
Date: Tue, 13 Jan 2004 23:50:47 +0100
From: martin f krafft <madduck@madduck.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-ID: <20040113225047.GA6891@piper.madduck.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040113215355.GA3882@piper.madduck.net> <20040113143053.1c44b97d.rddunlap@osdl.org> <20040113223739.GA6268@piper.madduck.net> <20040113144141.1d695c3d.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20040113144141.1d695c3d.rddunlap@osdl.org>
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.1-piper i686
X-Mailer: Mutt 1.5.4i (2003-03-19)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Randy.Dunlap <rddunlap@osdl.org> [2004.01.13.2341 +0100]:
> I would guess that you have a high-priority $PATH to old modprobe
> than to the new modprobe...

That would surprise me, Debian handles this quite well:

diamond:~# which modprobe
/sbin/modprobe
diamond:~# modprobe -V
module-init-tools version 3.0-pre5
diamond:~# modprobe.modutils -V
modprobe version 2.4.26
modprobe: QM_MODULES: Function not implemented
diamond:~# uname -r
2.6.1

PS: I would appreciate not being CC'd on list mail.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
the only real advantage to punk music is
that nobody can whistle it.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFABHZHIgvIgzMMSnURAsIHAJ9xPAcit24dDD958kBVcM9X39xIkACgk5N3
AdPbYUwZ9ooSzpIvomUzl8E=
=LMSG
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
