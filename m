Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUGFSzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUGFSzv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUGFSzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:55:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:28357 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264261AbUGFSzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:55:49 -0400
Date: Tue, 6 Jul 2004 20:55:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040706185547.GM18841@lug-owl.de>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <200407061251.18702.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hF9BROpwVWvPzXeD"
Content-Disposition: inline
In-Reply-To: <200407061251.18702.dtor_core@ameritech.net>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hF9BROpwVWvPzXeD
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-07-06 12:51:16 -0500, Dmitry Torokhov <dtor_core@ameritech.net>
wrote in message <200407061251.18702.dtor_core@ameritech.net>:
> --- 1.43/drivers/Makefile	2004-06-28 23:00:49 -05:00
> +++ edited/drivers/Makefile	2004-07-06 12:46:54 -05:00
> @@ -15,6 +15,9 @@
>  # char/ comes before serial/ etc so that the VT console is the boot-time
>  # default.
>  obj-y				+=3D char/
> +# we also need input/serio early so seio bus is initialized by the time
                                       ^^^^
Typo:)

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--hF9BROpwVWvPzXeD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA6vWzHb1edYOZ4bsRAisLAJ9AfZgsJpJDeEvWyZi2T1wfLcnWMgCdHhRp
tX8y3YH2l+tdMIhUU9Elw80=
=ImCu
-----END PGP SIGNATURE-----

--hF9BROpwVWvPzXeD--
