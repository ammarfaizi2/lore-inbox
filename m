Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUAKJvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbUAKJvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:51:35 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:37248 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265831AbUAKJvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:51:32 -0500
Subject: Re: 2.6.1 and irq balancing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ethan Weinstein <lists@stinkfoot.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <40008745.4070109@stinkfoot.org>
References: <40008745.4070109@stinkfoot.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ykRddk+nrezz3c3df1mS"
Organization: Red Hat, Inc.
Message-Id: <1073814681.4431.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 10:51:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ykRddk+nrezz3c3df1mS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 00:14, Ethan Weinstein wrote:
> Greetings all,
>=20
> I upgraded my server to 2.6.1, and I'm finding I'm saddled with only=20
> interrupting on CPU0 again. 2.6.0 does this as well. This is the=20
> Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled.=20
> /proc/cpuinfo is normal as per HT, displaying 4 cpus.

you should run the userspace irq balance daemon:
http://people.redhat.com/arjanv/irqbalance/

(or part of the kernel-utils package if you run a RH based distro; afaik
SuSE ships it too but I don't know in what package)

--=-ykRddk+nrezz3c3df1mS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAARyZxULwo51rQBIRAsFmAJ9S5RnV5Rul9MXtTEVEuFQhlz/G3ACgoexB
tnyptwxUVFCSxCppLO1zujI=
=3IGP
-----END PGP SIGNATURE-----

--=-ykRddk+nrezz3c3df1mS--
