Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268854AbRG0Ns4>; Fri, 27 Jul 2001 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRG0Nsq>; Fri, 27 Jul 2001 09:48:46 -0400
Received: from 50.nsc.at ([195.58.178.50]:53243 "EHLO progenius.fraser.at")
	by vger.kernel.org with ESMTP id <S268854AbRG0Nsh>;
	Fri, 27 Jul 2001 09:48:37 -0400
Date: Fri, 27 Jul 2001 16:22:54 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Graphical overview
Message-ID: <20010727162254.B507@freakzone.net>
Mail-Followup-To: gordon, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <200107271337.f6RDbVN22777@syntags.de>
User-Agent: Mutt/1.3.18i
X-Url: <http://www.freakzone.net/>
X-PGP-ID: 588B7D9C
From: Gordon Fraser <gordon@freakzone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Frank Fiene <ffiene@veka.com> [010727 15:37] wrote:
> lgp version 2.4.0a works fine but the latest 2.5.1 does not. Compile=20
> error is
> data2ps.o: In function `d2p_draw_line':
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:180: undefined reference to=20
> `cos'
> /home/ffiene/docs/lgp-2.5.1/data2ps.c:181: undefined reference to=20
> `sin'
>=20
> The files data2ps.c in both versions have not man different lines of=20
> code, so i didn't find the error.

Try adding -lm to the CFLAGS in the Makefile, this should do the trick.

Gordon

--=20
+---------------------------------------------------------------------+
| Gordon Fraser            |  * dpkg ponders: 'C++' should have been  |
| gordon@freakzone.net     |  called 'D'                              |
| ICQ: 12413204            |  	-- #Debian                            |
| http://www.freakzone.net |                                          |
+---------------------------------------------------------------------+

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YXk+FgAj91iLfZwRAub6AJ4+0dUVxgXiRBtDCiurqk1wj769iACcD2HJ
ADaM2fiJ1ob76fkaQ+SMIiY=
=lBpa
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
