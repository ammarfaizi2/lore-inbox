Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUD1OYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUD1OYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUD1OYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:24:30 -0400
Received: from mx1.actcom.net.il ([192.114.47.13]:44699 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S264819AbUD1OYU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:24:20 -0400
Date: Wed, 28 Apr 2004 17:22:20 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
Message-ID: <20040428142219.GC9820@mulix.org>
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <408F3EE4.1080603@nortelnetworks.com> <opr65ic90vshwjtr@laptop-linux.wpcb.org.au> <20040428121009.GA2844@thunk.org> <yw1x7jw0mfoh.fsf@kth.se> <20040428130402.GB9820@mulix.org> <yw1x3c6omdwb.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <yw1x3c6omdwb.fsf@kth.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 28, 2004 at 03:27:00PM +0200, M=E5ns Rullg=E5rd wrote:
> Muli Ben-Yehuda <mulix@mulix.org> writes:
>=20
> > On Wed, Apr 28, 2004 at 02:48:30PM +0200, M=E5ns Rullg=E5rd wrote:
> >> > Stack overflows in a badly written device driver can overwrite task
> >> > structures and cause apparent filesystem problems which are blamed on
> >> > the hapless filesystem authors instead of where the blame properly
> >> > lies, namely the device driver author.
> >>=20
> >> Wouldn't the problem be just as difficult to pin to a certain module
> >> even if the source code was open?  I prefer open source modules (I
> >> have Alpha machines), but I just can't see this argument work.
> >
> > No. If the code is open, you can read it and find the bug - just by
> > reading it. If the code is closed, your only recourse is to observe
> > the corruption while it happens or read the assembly, which is quite a
> > lot more difficult.=20
>=20
> Something has to hint to as to which code to read.  The usual way to
> find the offending module is to remove modules until the problem goes
> away.  The availability of source code only matters when you have
> found which module actually has the bug. =20

If it's closed, you may think you have found the bug, but you can't
verify. If it's open, you can.=20

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAj74bKRs727/VN8sRAnDUAJsEBE9lNt7LxdbzE3SelEMwV8TAXgCgnF0K
1rhNEHSz/YC4GJ6DhvOlL34=
=Ay57
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
