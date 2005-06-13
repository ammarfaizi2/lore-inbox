Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVFMQGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVFMQGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVFMQGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:06:30 -0400
Received: from lug-owl.de ([195.71.106.12]:60351 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261664AbVFMQEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:04:50 -0400
Date: Mon, 13 Jun 2005 18:04:49 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Pausing a task
Message-ID: <20050613160449.GJ3008@lug-owl.de>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506131142120.17826@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506131142120.17826@chaos.analogic.com>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-13 11:50:34 -0400, Richard B. Johnson <linux-os@analogic.co=
m> wrote:
>=20
> How can I (as root) pause or suspend a process?
> On VAX/VMS one could do `set process=3Dsuspend`. This
> would allow the system manager to check on a possibly
> rogue user.
>=20
> Let's say that "Hacker Jack" just got fired because
> he was disrupting a project. One needs to find any of
> his processes where he might be deleting a project
> tree. Pausing, rather than killing the tasks would
> allow evidence to be gathered. Basically, I need
> to set the task(s) priorities to something that
> will take them out of the run-queue altogether.

~# pkill -SIGSTOP -U richard

< examine the situation, attach gdb/strace/ltrace/whatever >

If you just want to let'em continue:

~# pkill -SIGCONG -U richard

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

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCra6hHb1edYOZ4bsRAnUHAJ4x9/3EWCLmf4gGOepYXSYeo8zwHwCeILnb
aVFYq6OHwoevfoOmwcidzCU=
=0m2m
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
