Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbTJGQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262522AbTJGQyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:54:09 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:29331 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262508AbTJGQyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:54:06 -0400
Date: Tue, 7 Oct 2003 17:54:04 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs. udev
Message-ID: <20031007165404.GB29870@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	Andreas Jellinghaus <aj@dungeon.inka.de>,
	linux-kernel@vger.kernel.org
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2003 at 06:06:53PM +0200, Andreas Jellinghaus wrote:
> On Tue, 07 Oct 2003 14:26:07 +0000, Robert L. Harris wrote:
> > I just hope udev can give a look/feel similar to devfs as I have quite a
> > few machines already in production configured for devfs and really like
> > the manageablility.

   Seconded.

> I wonder: do you use the /dev/disc/* links, or the /dev/ide/... and
> /dev/scsi/... constructs? 

   I use /dev/scsi/ and /dev/ide/, because things tend to move around
less than with /dev/discs/. 

> I'm not sure how udev will be able to support both layouts.

   Surely udev needs the ability to make more than one device node or
symlink when a device is plugged in anyway, so I just see this as an
issue of writing the appropriate default configuration files.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
                 --- This year,  I'm giving up Lent. ---                 

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gu+sssJ7whwzWGARAlgBAKCO+z10XHX9VEUVJ+dKTIWJAWwSOgCdFrAP
D+VTTmLHbK4Pqg7yHfBWd2U=
=R6eR
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
