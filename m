Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUBHKGG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUBHKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 05:06:06 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:32384 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263166AbUBHKGD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 05:06:03 -0500
Subject: Re: [patch] 2.4's sys_readahead is borked
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Robert Love <rml@ximian.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
References: <1075853962.8022.3.camel@localhost>
	 <Pine.LNX.4.58L.0402041224050.1700@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-obyYQJFoMHlKSpjU9uye"
Organization: Red Hat, Inc.
Message-Id: <1076030734.2620.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 07 Feb 2004 04:14:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-obyYQJFoMHlKSpjU9uye
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-02-04 at 09:30, Marcelo Tosatti wrote:

>=20
> Question: Do you know any user of sys_readahead() ?

Development versions of Fedora will sys_readahead a bunch of stuff
during system boot to avoid disk IO (and seeks) later on. The plan is to
expand this further from the current code (eg readahead stuff while dhcp
is trying to get an address and the disk is idle, etc etc).



--=-obyYQJFoMHlKSpjU9uye
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAIu0OxULwo51rQBIRAunsAKCobVJoux9sty4un7fXMXePhyGbkACfUVgO
Su1DtSUwgCXm/JqBCU9dVf0=
=JZLa
-----END PGP SIGNATURE-----

--=-obyYQJFoMHlKSpjU9uye--
