Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVEIOVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVEIOVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVEIOVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:21:19 -0400
Received: from zak.futurequest.net ([69.5.6.152]:36012 "HELO
	zak.futurequest.net") by vger.kernel.org with SMTP id S261388AbVEIOUx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:20:53 -0400
Date: Mon, 9 May 2005 08:20:50 -0600
From: Bruce Guenter <bruceg@em.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: How to diagnose a kernel memory leak
Message-ID: <20050509142050.GA16663@em.ca>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050509035823.GA13715@em.ca> <Pine.LNX.4.61.0505090002580.572@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505090002580.572@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2005 at 12:05:03AM -0600, Zwane Mwaikambo wrote:
> Try looking at slabtop(1) output after a few days.

Well, this is interesting and all, and reiser_inode_cache is taking up a
lot of memory, but according to the /proc/meminfo I had posted, slab is
only using about 60MB.  It doesn't appear to be the cause of any leaks.
--=20
Bruce Guenter <bruceg@em.ca> http://em.ca/~bruceg/ http://untroubled.org/
OpenPGP key: 699980E8 / D0B7 C8DD 365D A395 29DA  2E2A E96F B2DC 6999 80E8

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCf3HC6W+y3GmZgOgRAvTEAKCCHXTFbsbehEN/2o/iya/b955lMQCgikga
0Pyi8XfdvynYVFL5mgzgBmA=
=NUKe
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
