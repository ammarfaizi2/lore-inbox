Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264978AbTLWH3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 02:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTLWH3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 02:29:10 -0500
Received: from populous.netsplit.com ([62.49.129.34]:13258 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S264978AbTLWH3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 02:29:07 -0500
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
From: Scott James Remnant <scott@netsplit.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031222204024.GF3195@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com>
	 <20031222092329.GA30235@kroah.com>
	 <1072090725.1225.19.camel@descent.netsplit.com>
	 <20031222204024.GF3195@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aNlS45xBzGShLX2wP76F"
Message-Id: <1072164547.1225.25.camel@descent.netsplit.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 07:29:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aNlS45xBzGShLX2wP76F
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-22 at 20:40, Greg KH wrote:

> On Mon, Dec 22, 2003 at 10:58:45AM +0000, Scott James Remnant wrote:
> > One question though, it only ever seems to create a device for the
> > actual usb-storage disk and not the partition.  Is there some magic to
> > create the partition device instead?
>=20
> Do you have a partition show up in /sys/block?  If not, then udev will
> not create it.  It works here for my usb-storage devices that have
> partitions on them.
>=20
Yes, /dev/block/sdb/sdb1 certainly does appear, as does /udev/sdb1 --
the LABEL rule only seems to match "sdb" though.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?


--=-aNlS45xBzGShLX2wP76F
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5+7DIexP3IStZ2wRAnbXAJ9MVj1QAaUQkZLoiwsaiwpcUL1lrACfWjrM
dSIg+gOIsKIQN2uAzJa86lg=
=P8yT
-----END PGP SIGNATURE-----

--=-aNlS45xBzGShLX2wP76F--

