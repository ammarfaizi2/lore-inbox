Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbTJQLux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 07:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJQLux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 07:50:53 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:11228 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263404AbTJQLut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 07:50:49 -0400
Date: Fri, 17 Oct 2003 13:50:47 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031017115047.GE20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310141813320.1776-100000@gaia.cela.pl> <200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk> <20031015124314.GD20846@lug-owl.de> <3F8D46D7.1020105@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bcYi5jFlpxeIYd0E"
Content-Disposition: inline
In-Reply-To: <3F8D46D7.1020105@cyberone.com.au>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bcYi5jFlpxeIYd0E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-15 23:08:39 +1000, Nick Piggin <piggin@cyberone.com.au>
wrote in message <3F8D46D7.1020105@cyberone.com.au>:
> Jan-Benedict Glaw wrote:
> >On Tue, 2003-10-14 18:33:49 +0100, John Bradford <john@grabjohn.com>
> >wrote in message=20
> ><200310141733.h9EHXnYg002262@81-2-122-30.bradfords.org.uk>:

> >Achtually, with HZ at around 100 (or oven 70..80), an old i386 or i486
> >will *start* just fine, at least at 8MB. However, over some days /
> >weeks, the machine gets slower and slower (my testdrive: my 90MHz
> >P-Classic with 16MB). Even with that "much" RAM, I get hit by whatever
> >slows down the machine. I *think* that it's the MM subsystem, but I'm
> >really not skilled enough with it to blame it:)
> >
>=20
> Thats interesting. Its probably a memory leak I guess. Make sure to rule =
out
> memory leaks in userspace applications, then get /proc/meminfo,=20
> /proc/slabinfo
> on the box after it is getting slow, and also, after the box is newly=20
> booted.

Well, the box is still fine useable, but it's only rebooted some days
ago. However, I see size-64 (non-DMA) is going sloooowly up... What do I
do with the box? minicom (it's kind of a console server:), NATting, IPv6
gw. No X11, normally no local access at all.

On my Athlon (dual), I've already reached 319780 allocations in size-64,
but it seems to be currently stable, though...

I do _not_ see a leak in he size-4k region.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--bcYi5jFlpxeIYd0E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/j9eXHb1edYOZ4bsRAgHQAJ9YFgoPBKB4ioDa2lijT65b0GoUoACgjLBu
WtKWYedrJ98OcrhX7GOSchM=
=ZUMQ
-----END PGP SIGNATURE-----

--bcYi5jFlpxeIYd0E--
