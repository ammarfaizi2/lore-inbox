Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWDJQAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWDJQAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 12:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWDJQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 12:00:55 -0400
Received: from lug-owl.de ([195.71.106.12]:28075 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750978AbWDJQAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 12:00:54 -0400
Date: Mon, 10 Apr 2006 18:00:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sumit Narayan <talk2sumit@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
Subject: Re: deleting partition does not effect superblock?
Message-ID: <20060410160052.GO13324@lug-owl.de>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Sumit Narayan <talk2sumit@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, ext3-users@redhat.com
References: <1458d9610604052337p2cafa6c8j78fc6da8c5f8be1a@mail.gmail.com> <20060406065832.GK13324@lug-owl.de> <Pine.LNX.4.61.0604101725130.922@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xsFQtFdnkC8cTCzR"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604101725130.922@yvahk01.tjqt.qr>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xsFQtFdnkC8cTCzR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-04-10 17:28:18 +0200, Jan Engelhardt <jengelh@linux01.gwdg.de>=
 wrote:
> >deleted) or otherwise modified. So it's perfectly okay to delete such
> >a container (eg. remove start and end from the partition table) and
> >recreate it at some time later (by adding those values back to the
> >partition table.)  As long as the new container starts at the same
> >location, a filesystem driver will be able to find the old
> >information. If you start a block later, it won't find it's
> >superblocks.
> >
> If using a filesystem with replicated superblocks (ext*, xfs), then ...?
> [Includes expecting weird breakage.]

I'll possibly test if this works in another life...

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

--xsFQtFdnkC8cTCzR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEOoE0Hb1edYOZ4bsRAlxVAJ9FdGu1YRCjbE0iUzxn5tYGUwY9iQCeL62C
w9zqN1Pu+tAW+go6n/7++uo=
=DmYz
-----END PGP SIGNATURE-----

--xsFQtFdnkC8cTCzR--
