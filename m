Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbVJ1VUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbVJ1VUa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbVJ1VUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:20:30 -0400
Received: from lug-owl.de ([195.71.106.12]:43483 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751809AbVJ1VUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:20:30 -0400
Date: Fri, 28 Oct 2005 23:20:28 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: Chuck Lever <cel@netapp.com>, Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Link error in ./net/sunrcp/
Message-ID: <20051028212028.GQ27184@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Chuck Lever <cel@netapp.com>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I get this link error:

net/built-in.o: In function `xs_bindresvport':xprtsock.c:(.text+0x46970): u=
ndefined reference to `xprt_min_resvport'
:xprtsock.c:(.text+0x46978): undefined reference to `xprt_max_resvport'
net/built-in.o: In function `xs_setup_udp': undefined reference to `xprt_ud=
p_slot_table_entries'
net/built-in.o: In function `xs_setup_tcp': undefined reference to `xprt_tc=
p_slot_table_entries'
make: *** [.tmp_vmlinux1] Error 1

in case of CONFIG_SYSCTL not being enabled. This is on the VAX port,
but I guess it'll show up on any target...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDYpYcHb1edYOZ4bsRApiVAJoDyyfGb+CjyaWCzO9IQt+kIHT/5ACfYdfi
5FN6Cz84bzde+Ab+WvtHOAo=
=5Jul
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
