Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422666AbWGJPxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWGJPxk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWGJPxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:53:40 -0400
Received: from admingilde.org ([213.95.32.146]:11147 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1422666AbWGJPxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:53:39 -0400
Date: Mon, 10 Jul 2006 17:53:37 +0200
From: Martin Waitz <tali@admingilde.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] -Wshadow: Fix warnings in mconf
Message-ID: <20060710155337.GB9617@admingilde.org>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200607101312.38149.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <200607101312.38149.jesper.juhl@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jul 10, 2006 at 01:12:37PM +0200, Jesper Juhl wrote:
> --- linux-2.6.18-rc1-orig/scripts/kconfig/mconf.c	2006-06-18 03:49:35.000=
000000 +0200
> +++ linux-2.6.18-rc1/scripts/kconfig/mconf.c	2006-07-09 19:48:05.00000000=
0 +0200
> @@ -276,7 +276,7 @@ static void conf_save(void);
>  static void show_textbox(const char *title, const char *text, int r, int=
 c);
>  static void show_helptext(const char *title, const char *text);
>  static void show_help(struct menu *menu);
> -static void show_file(const char *filename, const char *title, int r, in=
t c);
> +static void show_file(const char *fname, const char *title, int r, int c=
);
> =20
>  static void cprint_init(void);
>  static int cprint1(const char *fmt, ...);

perhaps its more clear if you change the global variable instead?
perhaps to config_filename?

--=20
Martin Waitz

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEsngBj/Eaxd/oD7IRAu3pAJ9wyMR+q9tx2FG/+8anXc2jZwVNNQCfUJyB
EeeSt6bIGn0tZmkTUnAmqaU=
=lWaI
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
