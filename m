Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTLaAK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 19:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbTLaAK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 19:10:29 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:6048 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S264392AbTLaAK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 19:10:27 -0500
Date: Wed, 31 Dec 2003 00:10:20 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adaptec 1210sa
Message-ID: <20031231001020.GC19895@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org
References: <200312220305.29955.marchand@kde.org> <3FF20B7A.1090108@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <3FF20B7A.1090108@pobox.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2003 at 06:34:18PM -0500, Jeff Garzik wrote:
> Mickael Marchand wrote:
> >it needs  some redesign to only apply to aar1210 (as standard sil3112 does 
> >not need it) and I guess some testing before inclusion.
> >
> >the idea suggested by Justin was to clear bits 6 and 7 at 0x8a of pci 
> >configuration space. (which I hope did fine :)
> 
> Does the aar1210 have a different PCI id?  That would make it easy to 
> distinguish, and thus easy to selectively apply your patch only to 
> Adaptec chipsets that need it.

   It's not directly relevant, given the rest of this thread, but the
AAR-1210SA does have a different PCI ID to the standard SiI3112.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
   --- Anyone who claims their cryptographic protocol is secure is ---   
         either a genius or a fool.  Given the genius/fool ratio         
                 for our species,  the odds aren't good.                 

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8hPsssJ7whwzWGARAn02AJwJVAH0O6r0b8dmI+2vz6CXl4EDzACeNm9u
xnYjxUETLbhTQOqkLsMQ3+U=
=t2uT
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
