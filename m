Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934279AbWKXJze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934279AbWKXJze (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 04:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934531AbWKXJze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 04:55:34 -0500
Received: from systemlinux.org ([83.151.29.59]:60607 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S934279AbWKXJzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 04:55:33 -0500
Date: Fri, 24 Nov 2006 10:51:18 +0100
From: Andre Noll <maan@systemlinux.org>
To: Mel Gorman <mel@skynet.ie>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [discuss] 2.6.19-rc6: known regressions (v4)
Message-ID: <20061124095118.GK27761@skl-net.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org> <20061121212424.GQ5200@stusta.de> <200611221142.21212.ak@suse.de> <20061122155233.GA30607@skynet.ie> <20061122174223.GE27761@skl-net.de> <20061123120141.GA20920@skynet.ie> <20061123110930.abc4fd9a.akpm@osdl.org> <20061123215545.GA9551@skynet.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
In-Reply-To: <20061123215545.GA9551@skynet.ie>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:55, Mel Gorman wrote:

> A slightly smarter, but not quite as obviously correct, patch is below if
> you prefer it. It removes the assumption about early_node_map being sorted
> for find_min_pfns and friends by always searching the whole map.  The map
> is then only sorted once when it is required. Andre, I'd appreciate it if
> you could give it a spin to be 100% sure it's ok. It passed a boot-test on
> a few machines here.

Yes, this one also works for me.

Acked-by: Andre Noll <maan@systemlinux.org>
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFZsCVWto1QDEAkw8RAhCrAJ9MaKhB+MD3uFZXgX/dHzuY2J4TwgCcCwGq
bEzJ2zsX/L+gfjekH2OUjw8=
=ESfV
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--
