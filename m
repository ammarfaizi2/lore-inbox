Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272011AbTGYLDF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 07:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTGYLDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 07:03:05 -0400
Received: from mx02.qsc.de ([213.148.130.14]:20684 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S272011AbTGYLDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 07:03:01 -0400
Date: Fri, 25 Jul 2003 13:18:02 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: rgooch@atnf.csiro.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030725111802.GB666@gmx.de>
References: <20030725110830.GA666@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20030725110830.GA666@gmx.de>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm2-O8 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

argh

On Fri, Jul 25, 2003 at 01:08:31PM +0200, Wiktor Wodecki wrote:
> Hello,
>=20
> I'm currently running at 2.6.0-test1-mm2-O8 and I wanted to give devfs a
> shot. I recompiled the kernel with the following settings:
> CONFIG_DEVFS_FS=3Dy
> CONFIG_DEVFS_MOUNT=3Dy

please note, that my initial testing was done with CONFIG_DEVFS_MOUNT
*not* set.=20

> # CONFIG_DEVFS_DEBUG is not set
>=20
> As I read through the documentation (btw, devfs=3Dnomount is mentioned in
> configure help but not in Documentation/filesystems/devfs/boot-options)
> I got the understanding that this shouldn't make any difference to the
> system right? After booting with this kernel there were lots of proper
> devfs devices in my dmesg (host0/ide0... scsi0/...) however, the system
> didn't came up (couldn't mount rootfs). It didn't even work when I
> enabled CONFIG_DEVFS_MOUNT.
>=20
> I'm not sure whether this is a bug in mount/nomount of devfs or if it's
> somewhere my fault/setup (root on raid1, various lvm2 devices on raid1/0
> devices)
>=20
> Any help would be greatly appreciated.
>=20
> --=20
> Regards,
>=20
> Wiktor Wodecki



--=20
Regards,

Wiktor Wodecki

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/IRHq6SNaNRgsl4MRAkChAJdBEuvFozoM82DahevNw3xhAD4EAJ95VEqY
4sP+76nYOVMArHtGnrNKpw==
=OHut
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
