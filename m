Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTEYSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263673AbTEYSs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:48:29 -0400
Received: from h80ad2667.async.vt.edu ([128.173.38.103]:912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263558AbTEYSs2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:48:28 -0400
Message-Id: <200305251901.h4PJ1LoH022514@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben Collins <bcollins@debian.org>,
       Edgar Toernig <froese@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE 
In-Reply-To: Your message of "Sun, 25 May 2003 21:05:09 +0200."
             <20030525210509.09429aaa.l.s.r@web.de> 
From: Valdis.Kletnieks@vt.edu
References: <20030525112150.3994df9b.l.s.r@web.de> <3ED0FC58.D1F04381@gmx.de>
            <20030525210509.09429aaa.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1401674720P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 25 May 2003 15:01:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1401674720P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Sun, 25 May 2003 21:05:09 +0200, =3D?ISO-8859-1?Q?Ren=3DE9?=3D Scharfe=
 said:

> +size_t strlcpy(char *dest, const char *src, size_t bufsize)
> +{
> +	size_t len =3D strlen(src);
> +	size_t ret =3D len;
> +
> +	if (bufsize > 0)
> +		return ret;

Umm... Rene?  Either you or I need more caffeine, this looks b0rked to me=
?

--==_Exmh_-1401674720P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0RMAcC3lWbTT17ARAmqKAKDNlgBbOaQlK/Mw56T4Y6D3jSpoAACfSaFb
g6k97cLtZ9Ba9fAkXHwwJNg=
=ClDc
-----END PGP SIGNATURE-----

--==_Exmh_-1401674720P--
