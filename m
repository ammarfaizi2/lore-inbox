Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTGHMsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTGHMsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:48:36 -0400
Received: from mailc.telia.com ([194.22.190.4]:35038 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S261825AbTGHMs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:48:27 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2 + nvidia (and others)
From: Christian Axelsson <smiler@lanil.mine.nu>
Reply-To: smiler@lanil.mine.nu
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <6A3BC5C5B2D@vcnet.vc.cvut.cz>
References: <6A3BC5C5B2D@vcnet.vc.cvut.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-T6ScaPOqk3yJfF558TWm"
Organization: LANIL
Message-Id: <1057669356.6858.29.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 08 Jul 2003 15:02:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-T6ScaPOqk3yJfF558TWm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-07-08 at 14:37, Petr Vandrovec wrote:
> On  8 Jul 03 at 13:35, Christian Axelsson wrote:
> > On Tue, 2003-07-08 at 13:23, Flameeyes wrote:
> > > On Tue, 2003-07-08 at 13:01, Petr Vandrovec wrote:
> > > > vmware-any-any-update35.tar.gz should work on 2.5.74-mm2 too.
> > > > But it is not tested, I have enough troubles with 2.5.74 without mm=
 patches...
> > > vmnet doesn't compile:
> > >=20
> > > make: Entering directory `/tmp/vmware-config1/vmnet-only'
> > > In file included from userif.c:51:
> > > pgtbl.h: In function `PgtblVa2PageLocked':
> > > pgtbl.h:82: warning: implicit declaration of function `pmd_offset'
> > > pgtbl.h:82: warning: assignment makes pointer from integer without a
> > > cast
> > > make: Leaving directory `/tmp/vmware-config1/vmnet-only'
> >=20
> > I get exactly the same errors. BTW I got these on vanilla 2.5.74 aswell=
.
>=20
> Either copy compat_pgtable.h from vmmon to vmnet, or grab
> vmware-any-any-update36. I forgot to update vmnet's copy of this file.

Still getting same errors. However if I copy pgtbl.h from vmmon it
compiles. vmmon uses pmd_offset_map instead of pmd_offset

--=20
Christian Axelsson
smiler@lanil.mine.nu

--=-T6ScaPOqk3yJfF558TWm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/CsDryqbmAWw8VdkRAsgFAKCOYd/iwuZm01BvRppKLJJsbrxXaQCfeaWd
cQ1ctAaj07A9JlDIwUpfv/8=
=6A4V
-----END PGP SIGNATURE-----

--=-T6ScaPOqk3yJfF558TWm--

