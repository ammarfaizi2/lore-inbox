Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbULRMYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbULRMYS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 07:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbULRMYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 07:24:18 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:48572 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262868AbULRMYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 07:24:13 -0500
Subject: Re: ip=dhcp problem...
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Charles-Henri Collin <charlie.collin@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41C41E2D.3010306@free.fr>
References: <41C40326.3070303@free.fr>
	 <1103371154.12078.61.camel@tux.rsn.bth.se>  <41C41E2D.3010306@free.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wgkyI8THWrO/+5OHMNlo"
Message-Id: <1103372650.12078.65.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 18 Dec 2004 13:24:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wgkyI8THWrO/+5OHMNlo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-12-18 at 13:10, Charles-Henri Collin wrote:

> >The fix is to make sure you have a nameserver in your /etc/resolv.conf
> >The kernel has no idea how to resolve names into addresses. That's a
> >userspace thing. I'm not sure if you can extract the dhcp info from the
> >kernel after the boot, otherwise you'll just have to run a userspace
> >dhcp client, I use dhclient.
> >
> > =20
> >
> i should put a /etc/resolv.conf.... but i dont want, for "dark reasons" ;=
)
> if i have a /etc/resolv.conf, what's the point in querying the dhcp=20
> server for a nameserver???
> i thought this would set linux a nameserver in case no /etc/resolv.conf=20
> was find.
> btw, i can't dhclient has i'm nfs-rooting. doing this breaks my=20
> connection with the nfs server and i lose / !!!!!
> i'm working on it.
> thanks anyway

I use FAI (http://www.informatik.uni-koeln.de/fai/) to install servers
here. They use ip=3Ddhcp in order to have nfs-root, then they run dhclient
in order to get dns and to maintain the lease correctly (not sure the
kernel does this for you). I don't loose contact with the nfs server,
works just fine.

--=20
/Martin

--=-wgkyI8THWrO/+5OHMNlo
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBxCFqWm2vlfa207ERAtcuAJ9+QZT/jEcYUOCg4Mnq+h/PyeEOEwCdELk8
W2TxTG5ruRe+G4iqU059u+8=
=5F7c
-----END PGP SIGNATURE-----

--=-wgkyI8THWrO/+5OHMNlo--
