Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265158AbTFEUww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTFEUwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:52:00 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:50305 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S265132AbTFEUum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:50:42 -0400
Date: Thu, 5 Jun 2003 22:04:06 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Alan Cox <alan@redhat.com>
Cc: Hugo Mills <hugo-lkml@carfax.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, andre@linux-ide.org
Subject: Re: SiI3112 (Adaptec 1210SA): no devices
Message-ID: <20030605210406.GD1542@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, andre@linux-ide.org
References: <20030605193514.GB1542@carfax.org.uk> <200306052013.h55KDcP12104@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <200306052013.h55KDcP12104@devserv.devel.redhat.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2003 at 04:13:38PM -0400, Alan Cox wrote:
> >    I've just taken delivery of a shiny new Adaptec 1210SA Serial-ATA
> > adapter and a 120Gb Seagate Barracuda native SATA drive. Problem is,
> > the kernel driver doesn't seem to notice this device on boot --
> 
> Its not a PCI identifier I've ever seen before
> 
> > 00:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 0240 (rev 02) (prog-if 01)
> 
> So its some kind of CMD now SIS device, either an SI680 or SI3112 with a 
> weird PCI ID

   The chip is a SiI3112 -- you can just see the start of the SiI logo
under the Adaptec sticker on it...

   The ID appears in drivers/pci/pci.ids.

> Does it have any option to put it into non raid mode in its bios ?

   As far as I can tell, it's in non-raid mode. I can only afford the
one drive. :)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
        --- Great oxymorons of the world, no. 2: Common Sense ---        

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+37BGssJ7whwzWGARAgDCAJ9/+qZCrMdSKd1bNNtd4mAOfF4ctgCfVNJM
ZULUsH7L7zgTM87IKv+Ik20=
=5x4t
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
