Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbTKEMPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTKEMPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 07:15:21 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:899 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262850AbTKEMPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 07:15:20 -0500
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200311051300.47039.bzolnier@elka.pw.edu.pl>
References: <200311041718.hA4HIBmv027100@hera.kernel.org>
	 <20031105084004.GY1477@suse.de>
	 <200311051300.47039.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4c45k76Ch635NxpaOZA5"
Organization: Red Hat, Inc.
Message-Id: <1068034491.5332.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 Nov 2003 13:14:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4c45k76Ch635NxpaOZA5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Yeah, it is ugly.  Using rq->cmd is also ugly as it hides the problem in
> ide-tape.c, but if you prefer this way I can clean it up.  I just wanted
> minimal changes to ide-tape.c to make it working.

isn't the right answer "use ide-scsi and scsi-tape" for IDE based tape
drives ?

--=-4c45k76Ch635NxpaOZA5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/qOm6xULwo51rQBIRApj/AJwOEak/VqF3+9iMOiKlaLT99PosiwCgpqlH
cezJ+0f9Zb0X7zU2ifBM+3g=
=9bqx
-----END PGP SIGNATURE-----

--=-4c45k76Ch635NxpaOZA5--
