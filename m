Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTEBRGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbTEBRGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:06:01 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:27126 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263015AbTEBRF7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:05:59 -0400
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
	 <Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J0K0t54hiv1UbhVdL4sz"
Organization: Red Hat, Inc.
Message-Id: <1051895901.1593.16.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 02 May 2003 19:18:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-J0K0t54hiv1UbhVdL4sz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Ingo, do you want protection against shell code injection ? Have the
> kernel to assign random stack addresses to processes and they won't be
> able to guess the stack pointer to place the jump. I use a very simple
> trick in my code :

stack randomisation is already present in the kernel, in the form of
cacheline coloring for HT cpus...

--=-J0K0t54hiv1UbhVdL4sz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sqhdxULwo51rQBIRAsPbAJ9pvgP1s5HqO1j9dpzhbUlOwtfgGQCfUkQd
xM8TtDZHhGaKtIB/zOKNE+c=
=vAXL
-----END PGP SIGNATURE-----

--=-J0K0t54hiv1UbhVdL4sz--
