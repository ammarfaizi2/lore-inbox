Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTIASxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTIASxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:53:10 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18828 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262878AbTIASxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:53:06 -0400
Date: Mon, 1 Sep 2003 20:53:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4 - PL2303 OOPS - see also 2.4.22: OOPS on disconnect PL2303 adapter
Message-ID: <20030901185304.GF14376@lug-owl.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
References: <200309020139.08248.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Content-Disposition: inline
In-Reply-To: <200309020139.08248.mhf@linuxmail.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-09-02 01:39:08 +0800, Michael Frank <mhf@linuxmail.org>
wrote in message <200309020139.08248.mhf@linuxmail.org>:
> PL2303 is used to connect the serial console on a classic serial port=20
> of a test machine. HW nandshaking is used
> The test machine reboots once a minute and dumps lots of messages

Do you use serial (USB) console to access the box or to capture some
(unrelated) Oops? If you try to to the later, you're most probably off
because USB needs a lot of infrastructure to work (think interrupts!)
which may not be available at Oops time...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/U5WQHb1edYOZ4bsRAjpEAJ9Q+k1jjT7EW9fmvgWj0rnj4a+D2ACfX32C
1Jh/4P2IYPk/w0V2Du37SAc=
=Na1g
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
