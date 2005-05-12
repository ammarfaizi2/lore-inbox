Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVELTjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVELTjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 15:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVELTje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 15:39:34 -0400
Received: from lug-owl.de ([195.71.106.12]:37068 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261522AbVELTjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 15:39:18 -0400
Date: Thu, 12 May 2005 21:39:17 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Enhanced Keyboard Driver
Message-ID: <20050512193917.GC8176@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050512192254.43538.qmail@web53101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofekNuVaYCKmvJ0U"
Content-Disposition: inline
In-Reply-To: <20050512192254.43538.qmail@web53101.mail.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ofekNuVaYCKmvJ0U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-05-12 12:22:54 -0700, Alan Bryan <icemanind@yahoo.com> wrote:
> Would it be feasable to modify the current keyboard
> driver in such a way that it would log the last 1000
> keystrokes pushed (possibly log it somewhere in /proc
> or something)? When I say keystrokes, I mean
> everything...even the ctrl and alt and shift bit keys

That's simple if you do it in a hackish way, but maybe a bit different
to what you think. You'd extend the struct atkbd to contain a 1000 entry
array and in rolling index. Then stuff your current keypress into the
array and you're done.

You'd need to hack in the proc interface, though.

> Something like this would greatly simplify the program
> I am attempting to make.

What do you actually want to do?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--ofekNuVaYCKmvJ0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCg7DlHb1edYOZ4bsRAqZrAJ961n9gscEAaHwtz6ImiUu+zKCZsQCggzBE
3yslCPuVLGC1BA/1mFO5Mb0=
=hP6E
-----END PGP SIGNATURE-----

--ofekNuVaYCKmvJ0U--
