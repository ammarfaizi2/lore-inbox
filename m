Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbTKNPPc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 10:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTKNPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 10:15:32 -0500
Received: from coruscant.franken.de ([193.174.159.226]:16313 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S262608AbTKNPP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 10:15:29 -0500
Date: Fri, 14 Nov 2003 16:10:04 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [2.6] Nonsense-messages from iptables + co.
Message-ID: <20031114151004.GE2395@obroa-skai.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20031114132054.GA646@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <20031114132054.GA646@merlin.emma.line.org>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Pungenday, the 26th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2003 at 02:20:54PM +0100, Matthias Andree wrote:
> Who the heck added these unhelpful
>=20
> "ipt_hook: happy cracking."
>=20
> messages to iptables/mangling/connection tracking code? There are three
> instances.

I guess it was Rusty.  The idea message is a funny way of telling you
that you are sending incomplete ip headers.  Something that is not
likely to occur unless you are trying to send corrupt packets via raw ip
sockets...

> If the kernel has got something to say, it should be clear what the
> kernel means, say, maximum <whatever> rate exceeded or something, not
> such junk like this.

There are people who do actually have fun developing linux code.  And
Rusty has a peculiar sense of humor... for further reference see the
comments like 'furniture shopping' throughout the netfilter/iptables
source code.  I sometimes wish I had the same humor like he has.

Yes, I know.  Stuff like this is not exactly useful in error messages.
I'd say it's one of the few remainders of the 2.3.x early development
time.  Like the "Rusty's brain broke" messages that have recently been
removed/replaced.

btw: *nix has a long history of funny error messages, like 'printer on
fire' or others.

> This is IMHO a MUST-FIX before 2.6.0.

It is even in 2.4.x, where it could have been fixed throughout the last
couple of years.  Nobody else has yet complained.

> Matthias Andree

--=20
- Harald Welte <laforge@gnumonks.org>               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Programming is like sex: One mistake and you have to support it your lifeti=
me

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tPBLXaXGVTD0i/8RAp9AAJ9tTrz2L+rfeXQT3QWC9grEKKtWowCfYMcw
/5qkkIyHiolD7r3M1ZuRkEk=
=dXv9
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
