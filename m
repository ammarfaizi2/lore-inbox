Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTJOH6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJOH6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 03:58:00 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:27119 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262443AbTJOH57
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 03:57:59 -0400
Subject: Re: Question on atomic_inc/dec
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Tim Hockin <thockin@hockin.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       sankar <san_madhav@hotmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031014214437.GA30302@hockin.org>
References: <A20D5638D741DD4DBAAB80A95012C0AED78649@orsmsx409.jf.intel.com>
	 <20031014214437.GA30302@hockin.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-20BxfJ+lV9yY9CBs1InC"
Organization: Red Hat, Inc.
Message-Id: <1066204651.5252.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2) 
Date: Wed, 15 Oct 2003 09:57:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-20BxfJ+lV9yY9CBs1InC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-14 at 23:44, Tim Hockin wrote:
> On Tue, Oct 14, 2003 at 02:17:49PM -0700, Perez-Gonzalez, Inaky wrote:
> > It will be in include/asm/atomic.h; however, it is not wise to
> > use directly the kernel stuff unless you are coding kernel stuff.
>=20
> Is there any reason NOT to use the atomic ops in user-space?=20

also the /usr/include/asm/atomic.h versions never were actually atomic!
Those being actually atomic depends on CONFIG_SMP defined, which for
userspace... well you get the picture.


--=-20BxfJ+lV9yY9CBs1InC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/jP3rxULwo51rQBIRAg7JAJ4rRtjA8gnxK5RRyhjXC7JXY+ZSQQCfYZX3
R4Es3bCSdRVmkwzW12hwcv4=
=SS8S
-----END PGP SIGNATURE-----

--=-20BxfJ+lV9yY9CBs1InC--
