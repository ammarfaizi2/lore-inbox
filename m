Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTIDHXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264778AbTIDHXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:23:55 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:41454 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264768AbTIDHXy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:23:54 -0400
Subject: Re: cciss update for 2.4.23-pre2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: mike.miller@hp.com
Cc: axboe@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20030903224353.GA11933@beardog.cca.cpqcorp.net>
References: <20030903224353.GA11933@beardog.cca.cpqcorp.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GuJ34w2Qi/pdjFwb9PtP"
Organization: Red Hat, Inc.
Message-Id: <1062660190.5064.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 09:23:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GuJ34w2Qi/pdjFwb9PtP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-09-04 at 00:43, mike.miller@hp.com wrote:
> This patch was built & tested using 2.4.22 with the 2.4.23-pre2 prepatch =
applied. It is intended for inclusion in the 2.4.23 kernel.
> This patch adds support for more than 8 controllers. It does this by pass=
ing 0 as a major number and allows the OS to assign a dynamically allocated=
 major number when there are more than 8 cciss controllers in a system.
> It's primary purpose is to help support the SA6400 and SA6400 EM. When th=
ese 2 cards are used they are 2 separate controllers in a single PCI/PCI-X =
slot.

how about just getting more official majors instead ?

--=-GuJ34w2Qi/pdjFwb9PtP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VuhexULwo51rQBIRAlZKAKCCO2Bow94BeDpQ6u8jz4lvfeUu1wCgqO2Q
9jDJ0l7Lr/PLisLFbC23qdw=
=XGWD
-----END PGP SIGNATURE-----

--=-GuJ34w2Qi/pdjFwb9PtP--
