Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267074AbUBMQJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267076AbUBMQJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:09:19 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:40836 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S267074AbUBMQJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:09:16 -0500
Subject: Re: dm core patches
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Joe Thornber <thornber@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <20040213153936.GF15736@reti>
References: <20040210163548.GC27507@reti>
	 <20040211101659.GF3427@marowsky-bree.de> <20040211103541.GW27507@reti>
	 <20040212185145.GY21298@marowsky-bree.de> <20040212201340.GB1898@reti>
	 <20040213151213.GR21298@marowsky-bree.de>  <20040213153936.GF15736@reti>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-g+TamJwFnR2Stq+l2JCf"
Organization: Red Hat, Inc.
Message-Id: <1076688539.4441.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 13 Feb 2004 17:08:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-g+TamJwFnR2Stq+l2JCf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Yes, that is obvious, I had wanted to do failback automatically.  But
> pushing it to userland does allow people to write hardware specific
> tests.  I'll try it and see what people think.

one thing you can do is provide a way for drivers to wake the userspace
tester early. Say by default it polls every minute, but if the fiber
channel driver gets a LIP UP event it (via a central API) makes the
userspace daemon *now*.

--=-g+TamJwFnR2Stq+l2JCf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALPaaxULwo51rQBIRAmVmAKClezNY5Jv0GrZMph1v8Gjfip18wACeOjRz
l1zejkyVnn6Ni0KyMorHohM=
=gfFG
-----END PGP SIGNATURE-----

--=-g+TamJwFnR2Stq+l2JCf--
