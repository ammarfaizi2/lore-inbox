Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTATVad>; Mon, 20 Jan 2003 16:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbTATVad>; Mon, 20 Jan 2003 16:30:33 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:50161 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266987AbTATVaa>; Mon, 20 Jan 2003 16:30:30 -0500
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Olaf Titz <olaf@bigred.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E18ai8O-00032u-00@bigred.inka.de>
References: <25160.1042809144@passion.cambridge.redhat.com>
	 <Pine.LNX.4.33L2.0301171857230.25073-100000@vipe.technion.ac.il>
	 <E18a1aZ-0006mL-00@bigred.inka.de>
	 <1042930522.15782.12.camel@laptop.fenrus.com>
	 <E18ai8O-00032u-00@bigred.inka.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k2sH371WSi8cpmge6cs6"
Organization: Red Hat, Inc.
Message-Id: <1043098758.27074.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 20 Jan 2003 22:39:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k2sH371WSi8cpmge6cs6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> And what's exactly wrong with the other 99% solution of putting it in
> /usr/src/linux-`uname -r` ? This has exactly the same advantages but
> doesn't mix up between development and runtime environment; /usr/src
> is clearly where source belongs and /lib/modules is an install target.

back then the argument (not mine btw) was that /usr on a lot of machines
is RO (I think debian has an option for that) so that sysadmins there
compile stuff in /root. /lib/modules however IS standardized and needs
to be writable to install a new kernel so making a symlink to the real
place there isn't too bad. In addition it already is the only directory
with per kernel files.. adding a second one was judged not needed. It
has to be somewhere. /lib/modules/ or /usr/src.. who cares. Linus made
the final call and everybody complies with it since then, just because
it doesn't matter THAT much. It just needs to be SOMEWHERE standard and
/lib/modules suffices so far it seems.

--=-k2sH371WSi8cpmge6cs6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+LGyGxULwo51rQBIRAiWvAJ9DrBdDgiMsoU6LNyIc0wpZa/RU7gCdHhFF
9hQXkfDz/d6QJmVxH+LI6ws=
=h2xi
-----END PGP SIGNATURE-----

--=-k2sH371WSi8cpmge6cs6--
