Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbTJMVvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbTJMVvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:51:38 -0400
Received: from gw.hannover.ccc.de ([62.48.71.161]:33676 "HELO
	flapp.schottelius.org") by vger.kernel.org with SMTP
	id S261971AbTJMVve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:51:34 -0400
Date: Mon, 13 Oct 2003 23:48:35 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Cc: underley@underley.eu.org
Subject: [BUG] 2.6.0test7 & test4: tun.o (devfs)
Message-ID: <20031013214835.GA8006@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, underley@underley.eu.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-MSMail-Priority: gibbet nicht.
X-Mailer: cat << EOF | netcat mailhost 110
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux flapp 2.6.0-test7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When loading tun.o in test7 and test4 it does not create /dev/net/tun.
I am not familar with the devfs_create_device() call, so I cannot
currently see what's wrong where. But I think tun.o should create the devic=
e..

Nico

--=20
quote:   there are two time a day you should do nothing: before 12 and afte=
r 12
         (Nico Schottelius after writin' a very senseless email)
cmd:     echo God bless America | sed 's/.*\(A.*\)$/Why \1?/'
pgp:     new id: 0x8D0E27A4 | ftp.schottelius.org/pub/family/nico/pgp-key.n=
ew
url:     http://nerd-hosting.net - domains for nerds (from a nerd)

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ix2zzGnTqo0OJ6QRAoffAKCglBciiwrOt5lFGulzsLkIpAFm/wCfU9zJ
TUq+4HZSUm1lm/h1Yud/7xQ=
=XJnI
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
