Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUIGGN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUIGGN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUIGGN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:13:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267602AbUIGGNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:13:54 -0400
Subject: Re: sleep and wakeup at microsecond boundary
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: nucleon@nucleodyne.com
Cc: Mike Galbraith <efault@gmx.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1094536010.3436.34.camel@localhost.localdomain>
References: <5.2.1.1.2.20040905085650.00b1e640@pop.gmx.net>
	 <1094536010.3436.34.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M3E8LCB7U3qS+s5x3ZrZ"
Organization: Red Hat UK
Message-Id: <1094537619.2801.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 08:13:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M3E8LCB7U3qS+s5x3ZrZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-07 at 07:46, NucleoDyne Systems, Inc. wrote:
> Hello,
>       Let me explain the requirement a little more in detail.
>=20
> Consider the routine sleep_on_timeout(, timeout) in sched.c:

please don't use this routine. It's severely deprecated.

> On  x86 the jiffies is updated every time PIT raises interrupt and
> do_timer() is called, i.e. once in every 10ms.

it's 1ms nowadays....


--=-M3E8LCB7U3qS+s5x3ZrZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPVGTxULwo51rQBIRAp/tAJ4kzx/Tdz834igpegZW2t5Zpn+IJgCfXw0d
iwO278jc5FkRx6TEHoVSMzg=
=t2O0
-----END PGP SIGNATURE-----

--=-M3E8LCB7U3qS+s5x3ZrZ--

