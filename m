Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTLXBKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbTLXBKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:10:43 -0500
Received: from hostmaster.org ([80.110.173.103]:44175 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S263057AbTLXBKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:10:42 -0500
Subject: Re: linux-2.6.0 kernel distribution non-world-readable files
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <37133.219.88.110.193.1072226080.squirrel@mail.med.co.nz>
References: <37133.219.88.110.193.1072226080.squirrel@mail.med.co.nz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QVFetHgR0vVIvWyX4KvO"
Message-Id: <1072228229.1440.56.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 24 Dec 2003 02:10:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QVFetHgR0vVIvWyX4KvO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

When you unpack the tar as an unprivileged user you get ownership of the
files and can compile. root on the other hand should have a restrictive
umask setting so you would need to chmod anyways. However I find myself
typing "chown -R 0.0 .; chmod -R u=3DrwX,go=3DrX ." quite often so I would
appreciate some kind of a (set|fix)perms target.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
       mail pgp-key-request@hostmaster.org

Success is, when there is only one opponent left: yourself

--=-QVFetHgR0vVIvWyX4KvO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAP+jngGD1OYqW/8uJAQLmTgf9H7iq0ZcsyKHHFnOYSj1rbyl3uE0EcNt0
fA8IMnGBFqlAn77Rklh5/qzein9I6dpxe99PS/rGahTD7GOjrCM7VmuCWyiJXfBE
enM152jOYcADKs/Kalb1RY6Ca9Wc/K76f6VeJlDrFDVbj6cgHycodXsDcORAgB9x
vBjlQkhFXg80NoBNhgpbaTqSLzpmHZsxRwjrbhn9DxDDbdNAIRF2IuyicpebLfNR
rDK1eshGhvt9VFtop947epYknaTnRf/d3uhuA9o5x2wrYqPxxcTc9YW6DKr7RiGu
+E13brKZJfZALEV7U0DQCMXATH9isSN3glBBAJST7Z/PJVbDTMJdlw==
=UxoD
-----END PGP SIGNATURE-----

--=-QVFetHgR0vVIvWyX4KvO--

