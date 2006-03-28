Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWC1Kex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWC1Kex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 05:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWC1Kex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 05:34:53 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:15762 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932065AbWC1Kew
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 05:34:52 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060328080257.GA3581@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <20060328080257.GA3581@localhost.localdomain>
Message-Id: <1143542080.11560.27.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 28 Mar 2006 12:34:41 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/03/2006 12:36:53,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/03/2006 12:36:55,
	Serialize complete at 28/03/2006 12:36:55
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5jwH0ZTiI4T56FQxTZab"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5jwH0ZTiI4T56FQxTZab
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 28/03/2006 =C3=A0 10:02, Ravikiran G Thirumalai a =C3=A9crit :
> On Tue, Mar 28, 2006 at 09:15:26AM +0200, Laurent Vivier wrote:
> > Le mar 28/03/2006 =C3=A0 00:58, Ravikiran G Thirumalai a =C3=A9crit :
> > > On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> > > > Mingming Cao <cmm@us.ibm.com> wrote:
> >=20
> > As 64bit per cpu counter is used only by ext3 and needed only on 64bit
>=20
> No, per-cpu counters are generic, and used for nr_files counter in vfs, a=
nd
> struct  proto.memory_allocated in net (on current -mm).=20

In fact, I'm wondering if it is really a problem, as on 64bit arch
sizeof(long) =3D sizeof(long long) =3D 8 ...

Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-5jwH0ZTiI4T56FQxTZab
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEKRFA9Kffa9pFVzwRAr0RAKCkcIMCkGkMN0D7Sajpfd4kS/dseACcCF4R
sUWUPVBT+6QlUHUQlogZ32I=
=+A4S
-----END PGP SIGNATURE-----

--=-5jwH0ZTiI4T56FQxTZab--

