Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUDFQpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbUDFQp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:45:29 -0400
Received: from gemini.rz.uni-ulm.de ([134.60.246.16]:46981 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP id S263903AbUDFQk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:40:58 -0400
Date: Tue, 6 Apr 2004 18:32:27 +0200
From: Juergen Salk <juergen.salk@gmx.de>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strip whitespace from EXTRAVERSION?
Message-ID: <20040406163227.GE16564@oest181.str.klinik.uni-ulm.de>
References: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de> <jeu0zx5cdm.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <jeu0zx5cdm.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
X-DCC-RollaNet-Metrics: gemini 1040; Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andreas Schwab <schwab@suse.de> [040406 17:56]:

> > +EXTRAVERSION :=3D $(shell echo $(EXTRAVERSION) | sed -e 's/[ 	]//g')
                 ^  ^

> EXTRAVERSION :=3D $(strip $(EXTRAVERSION))

Ok. I think this still leaves embedded whitespace (which may also
cause some trouble), but this is much harder to to overlook, if
not introduced intentionally, anyway. ;-)

Regards - Juergen

--=20
GPG A997BA7A | 87FC DA31 5F00 C885 0DC3  E28F BD0D 4B33 A997 BA7A

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFActubvQ1LM6mXunoRAiGIAKCnm8IxpWRBdBbOL//i1ecpdincyQCggtsU
7q2tf98I+NEVALqhSqy2OhM=
=F3m0
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
