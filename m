Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318649AbSHAHVM>; Thu, 1 Aug 2002 03:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHAHVM>; Thu, 1 Aug 2002 03:21:12 -0400
Received: from [213.69.232.58] ([213.69.232.58]:15112 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318649AbSHAHVK>;
	Thu, 1 Aug 2002 03:21:10 -0400
Date: Wed, 31 Jul 2002 23:24:26 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: linux.nics@intel.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: network driver informations [general NIC, Wireless and e100]
Message-ID: <20020731212426.GA3342@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I recently tried the e100 driver and was happy that it reports
if there is a connection and speed and so on.

But should these informations not be reported through /proc-fs ?
I think this would make it easier for programs to monitor connection
status. We could even have a small red/green light in the KDE panel
to display connection status for different cards.

The point in fact is, looking into dmesg for connection status is definitly
wrong IMHO. It's neither a clean access nor easy to watch for applications.

So what do you think about /proc/net/<DEVNAME> support for status ?

As far as I can see this is partly implemented in /proc/net/wireless
or in /proc/net/dev.
Adding another column in the latter would do the job, too.

Anyways, just an idea.

Hope to hear your critics,

Nico


--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SFWKtnlUggLJsX0RAsk8AJ45LAFB8OcmBflYxVnm0Y77fAe9LwCdFJ3q
XBefQwz0Ax3SFQkX3Pt7usw=
=oW9g
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
