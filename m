Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbTJGR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbTJGR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:58:24 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:43923 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S262550AbTJGR6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:58:22 -0400
Date: Tue, 7 Oct 2003 18:58:17 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: devfs vs. udev
Message-ID: <20031007175817.GB1125@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
	Andreas Jellinghaus <aj@dungeon.inka.de>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de> <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net> <pan.2003.10.07.16.06.52.842471@dungeon.inka.de> <20031007165404.GB29870@carfax.org.uk> <20031007174928.GB1956@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20031007174928.GB1956@kroah.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2003 at 10:49:28AM -0700, Greg KH wrote:
> On Tue, Oct 07, 2003 at 05:54:04PM +0100, Hugo Mills wrote:
> > 
> >    Surely udev needs the ability to make more than one device node or
> > symlink when a device is plugged in anyway, so I just see this as an
> > issue of writing the appropriate default configuration files.
> 
> More than one device node per device?  Why would you want that?

   OK, more than one actual node per device (i.e. per major:minor
pair) may not necessarily be required, but in devfs there are, for
example device nodes created in /dev/scsi/host0/bus0/device0/lun0/...
etc, and links to those device nodes created in /dev/discs/disc0/...
It can occasionally be useful to have the two distinct namespaces
available.

> And sure, it's just software, it can be made to do that, if someone
> sends me a patch... :)

   If it doesn't do it when I want it to do that, I'll send you the
patch. :)

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
                 --- This year,  I'm giving up Lent. ---                 

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/gv65ssJ7whwzWGARAvl6AKClXfUoHTaoro9A5o/GuZVo+VxlMwCgpbir
ZHMZXWWWX6NqrKA8jdohOmM=
=BlCl
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
