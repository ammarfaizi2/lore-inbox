Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbTFEVKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 17:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTFEVJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 17:09:00 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:130 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265140AbTFEVB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 17:01:58 -0400
Date: Thu, 5 Jun 2003 22:15:26 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andre@linux-ide.org, alan@redhat.com
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Message-ID: <20030605211526.GE1542@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, andre@linux-ide.org, alan@redhat.com
References: <20030605193514.GB1542@carfax.org.uk> <3EDFAC88.4040609@rackable.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <3EDFAC88.4040609@rackable.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2003 at 01:48:08PM -0700, Samuel Flory wrote:
> Hugo Mills wrote:
> 
> >  I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> >adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> >the kernel driver doesn't seem to notice this device on boot --
> >nothing at all appears relating to this device in the boot messages.
> >Can you help me?
> >
> >  (The card is configured in its on-board BIOS with a single disk as
> >JBOD).
> 
>  The card is a serial ata controller with what adaptec refers to as 
> "hostraid".  (Meaning the raid is done in the driver.)  There are binary 
> drivers for it on adptec's site, but no open source drivers.  The binary 
> drivers are fairly good, but they are binary drivers.  (Which brings the 
> headaches that binary drivers entail.)

   I'm only after the JBOD function of the card, not the RAID bits. I
just couldn't find _any_ other SiI3112 SATA card on the market in this
country. I don't run Red Hat or SuSE, and particularly not their
kernels -- (I normally run Alan's kernels). Does this mean that I've
bought a pig in a poke?

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
        --- Great oxymorons of the world, no. 2: Common Sense ---        

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+37LtssJ7whwzWGARAt2WAJ0TzuRtNzjJ775VeB6KXCje+F+idgCgk0Re
Jc1BtAHCM4n7ffL3Fd56p9Q=
=oL5z
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
