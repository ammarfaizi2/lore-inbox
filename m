Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTL1JMD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 04:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTL1JMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 04:12:03 -0500
Received: from populous.netsplit.com ([62.49.129.34]:678 "EHLO
	mailgate.netsplit.com") by vger.kernel.org with ESMTP
	id S264953AbTL1JMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 04:12:00 -0500
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
From: Scott James Remnant <scott@netsplit.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
In-Reply-To: <20031223221341.GF15946@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com>
	 <20031222092329.GA30235@kroah.com>
	 <1072090725.1225.19.camel@descent.netsplit.com>
	 <20031222204024.GF3195@kroah.com>
	 <1072164547.1225.25.camel@descent.netsplit.com>
	 <20031223221341.GF15946@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xdRL0aq7UbkUwGiDTyxz"
Message-Id: <1072602718.1044.2.camel@descent.netsplit.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 28 Dec 2003 09:11:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xdRL0aq7UbkUwGiDTyxz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-23 at 22:13, Greg KH wrote:

> On Tue, Dec 23, 2003 at 07:29:07AM +0000, Scott James Remnant wrote:
> > On Mon, 2003-12-22 at 20:40, Greg KH wrote:
> >=20
> > > On Mon, Dec 22, 2003 at 10:58:45AM +0000, Scott James Remnant wrote:
> > > > One question though, it only ever seems to create a device for the
> > > > actual usb-storage disk and not the partition.  Is there some magic=
 to
> > > > create the partition device instead?
> > >=20
> > > Do you have a partition show up in /sys/block?  If not, then udev wil=
l
> > > not create it.  It works here for my usb-storage devices that have
> > > partitions on them.
> > >=20
> > Yes, /dev/block/sdb/sdb1 certainly does appear, as does /udev/sdb1 --
> > the LABEL rule only seems to match "sdb" though.
>=20
> That's odd, what is the rule?  They should both match.
>=20
Had omitted the %n in the NAME, so only the disk was showing up.=20
udev-011 fixes the original problem too, thanks.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?


--=-xdRL0aq7UbkUwGiDTyxz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7p5dIexP3IStZ2wRArZuAJ40fcV2DafdVyIk7zJlcVIGgI+HcQCguDdB
DI1ztrhGMYIoz+WY8IbEttk=
=XoEa
-----END PGP SIGNATURE-----

--=-xdRL0aq7UbkUwGiDTyxz--

