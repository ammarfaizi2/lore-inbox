Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267575AbUHJQq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUHJQq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUHJQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:46:52 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:38274 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S267523AbUHJQdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:33:40 -0400
Date: Tue, 10 Aug 2004 18:33:37 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Eric Masson <cool_kid@future-ericsoft.com>
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
Message-ID: <20040810163337.GD1127@lug-owl.de>
Mail-Followup-To: Eric Masson <cool_kid@future-ericsoft.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yudcn1FV7Hsu/q59"
Content-Disposition: inline
In-Reply-To: <4118E822.3000303@future-ericsoft.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yudcn1FV7Hsu/q59
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-10 11:22:10 -0400, Eric Masson <cool_kid@future-ericsoft.co=
m>
wrote in message <4118E822.3000303@future-ericsoft.com>:
> Thanks for the pointer! My user mode program is running. Any idea how to=
=20
> control which console it shows up on?

The best idea for a usermode helper is to first close
stdin/stdout/stderr and re-open it with /dev/null...

If you need to communicate, write into some logfile.

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

--yudcn1FV7Hsu/q59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGPjhHb1edYOZ4bsRAoseAKCBWAPVBp3zz4RUXaygcdZgYXSXSwCbBdUH
HaLYCF7xZLFUcX8AlG3JjQ8=
=btNT
-----END PGP SIGNATURE-----

--yudcn1FV7Hsu/q59--
