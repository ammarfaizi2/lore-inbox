Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTHVOzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTHVOzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:55:02 -0400
Received: from mx02.qsc.de ([213.148.130.14]:46225 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S263295AbTHVOy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:54:57 -0400
Date: Fri, 22 Aug 2003 16:56:23 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O18int
Message-ID: <20030822145622.GA716@gmx.de>
References: <200308222231.25059.kernel@kolivas.org> <20030822134136.GA711@gmx.de> <200308222351.16691.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <200308222351.16691.kernel@kolivas.org>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test2-O10 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2003 at 11:51:16PM +1000, Con Kolivas wrote:
> On Friday 22 August 2003 23:41, Wiktor Wodecki wrote:
> > On Fri, Aug 22, 2003 at 10:31:20PM +1000, Con Kolivas wrote:
> > Content-Description: clearsigned data
> >
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Here is a small patchlet.
> > >
> > > It is possible tasks were getting more sleep_avg credit on requeuing =
than
> > > they could burn off while running so I've removed the on runqueue bon=
us
> > > to requeuing task.
> > >
> > > Note this applies onto O16.3 or 2.6.0-test3-mm3 as O17 was dropped.
> > >
> > > This patch is also available here along with a patch against 2.6.0-te=
st3:
> > > http://kernel.kolivas.org/2.5
> > >
> > > Con
> >
> > this patch still makes my xmms skip on light io load (untar kernel
> > source, open lkml mailbox folder) while opening mozilla. Even after
> > mozilla is there xmms is still skipping. Processes take ages to spawn.
> > And no, I'm not in swap. A 'su -'is taking 10 seconds to procceed.
> > Same applies when rm -Rf'ing a kernel tree.
> > Here is some more data for the curious:
>=20
> > note the load of 11. I can even get it to 30 while doing 3 tar xf
> > bla.tar simultanously.
>=20
> Complete mystery.
> >
> > I'm going to fetch some fish in the next two weeks in poland, so I will
> > not be able to do any more testing from sunday on. Happy coding (while I
> > stick to O10 *g*)
>=20
> Thanks for comments. ]
>=20
> There it is again; the reference to darn O10. Hrm. One question before yo=
ur=20
> holiday; your O10 kernel is it the same kernel tree or a different/newere=
=20
> one? I'm looking to blame something else here I know but I need to know; =
this=20
> just doesn't hold with any testing here.

well, I run O10 on top of test2, since I didn't need any patches from
test3 I didn't rediff it.

--=20
Regards,

Wiktor Wodecki

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Ri8W6SNaNRgsl4MRAsdAAJ4kFQsfVN24esWmEQHYVZfBYt9RnACgndRn
xB82E5XJA2hwDiCyTxMBdNg=
=9C2z
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
