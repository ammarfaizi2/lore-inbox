Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTDTS6W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263678AbTDTS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:58:22 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:36336 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263676AbTDTS6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:58:21 -0400
Subject: Re: irq balancing; kernel vs. userspace
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EA2E8CC.4080201@cox.net>
References: <Pine.LNX.4.44.0304192002580.9909-100000@penguin.transmeta.com>
	 <6uwuhpl2u5.fsf@zork.zork.net> <1050863476.1412.11.camel@laptop.fenrus.com>
	 <3EA2E8CC.4080201@cox.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UGstC86DaoswbT59ch+0"
Organization: Red Hat, Inc.
Message-Id: <1050865818.1412.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 20 Apr 2003 21:10:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-UGstC86DaoswbT59ch+0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-04-20 at 20:37, Kevin P. Fleming wrote:

> I thought the same thing reading his original message, then I looked=20
> closer. He booted using "noirqbalance", did not start the userspace=20
> balancer, and yet his IRQs are still being balanced.

if you don't do a thing, pIII cpu based machines will balance by
themselves while pIV cpu based machines will redirect everything to CPU
0.=20

--=-UGstC86DaoswbT59ch+0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+ovCaxULwo51rQBIRAmnUAJ0W36XVQ7aR3vvqGA2GGIZpegaYFACfZiI8
beaqXYKNnur9C+ijv5UWkrE=
=2JDJ
-----END PGP SIGNATURE-----

--=-UGstC86DaoswbT59ch+0--
