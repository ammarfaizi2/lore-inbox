Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269992AbUJHQhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269992AbUJHQhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 12:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270006AbUJHQhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 12:37:08 -0400
Received: from lug-owl.de ([195.71.106.12]:10727 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S269992AbUJHQhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 12:37:02 -0400
Date: Fri, 8 Oct 2004 18:37:01 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008163701.GV5033@lug-owl.de>
Mail-Followup-To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
	Brice.Goglin@ens-lyon.org, linux-kernel@vger.kernel.org
References: <20041008130442.GE5551@lkcl.net> <41669DE0.9050005@didntduck.org> <20041008151837.GI5551@lkcl.net> <4166AFD0.2020905@ens-lyon.fr> <20041008162025.GL5551@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5EhqeiticJwWsSCK"
Content-Disposition: inline
In-Reply-To: <20041008162025.GL5551@lkcl.net>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5EhqeiticJwWsSCK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-10-08 17:20:25 +0100, Luke Kenneth Casson Leighton <lkcl@lkcl.=
net>
wrote in message <20041008162025.GL5551@lkcl.net>:
> On Fri, Oct 08, 2004 at 05:18:40PM +0200, Brice Goglin wrote:

> > mm_segment_t old_fs;
> > old_fs =3D get_fs();
> > set_fs(KERNEL_DS);
> > <do you stuff here>
> > set_fs(old_fs);
> =20
>  that's it!  that's what i was looking for.  thank you.

Most probably, this is not what you were looking for. You just don't
know that yet (-:

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--5EhqeiticJwWsSCK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBZsItHb1edYOZ4bsRAgnNAJsFN4S5dNrnVMr83H0muHQ2VsTvfgCfeJcT
KEUxY8bYT63TG+BHAjJVZfU=
=JcwQ
-----END PGP SIGNATURE-----

--5EhqeiticJwWsSCK--
