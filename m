Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTIVT7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263310AbTIVT7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:59:37 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:39113 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263309AbTIVT7d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:59:33 -0400
Date: Mon, 22 Sep 2003 20:59:20 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Per Andreas Buer <perbu@linpro.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SiI3112: problemes with shared interrupt line?
Message-ID: <20030922195920.GH10409@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Per Andreas Buer <perbu@linpro.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <PERBUMSGID-ul6pthskb16.fsf@ipchains.linpro.no> <1064256539.9008.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <1064256539.9008.13.camel@dhcp23.swansea.linux.org.uk>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2003 at 07:49:00PM +0100, Alan Cox wrote:
> Just about every bug report I have about SI3112 now is on Nforce
> chipsets. At the moment however I don't know what the magic connection
> is.

   I don't know if this comes under the heading of "SiI3112 bugs", but
Adaptec AAR-1210SA still doesn't work for me (and I've seen one other
identical report on LKML in the last fortnight).

   Any attempt to access the drive (Seagate Barracuda V) causes this
to happen:

Sep 22 20:56:00 src@vlad kernel: hda: dma_timer_expiry: dma status == 0x24
Sep 22 20:56:10 src@vlad kernel: hda: DMA interrupt recovery
Sep 22 20:56:10 src@vlad kernel: hda: lost interrupt

   Data does eventually get to/from the drive, but so slowly as to be
unusable.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
      --- In event of Last Trump,  please form an orderly queue ---      
                          and await judgement.                           

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/b1SYssJ7whwzWGARAtrKAJ4i3EzWL1biF92DhcCKZbcGBvOZowCgkovb
DSt/o0Py07IMXwixEby1cKI=
=zqYq
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
