Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267201AbSLKQPM>; Wed, 11 Dec 2002 11:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbSLKQPM>; Wed, 11 Dec 2002 11:15:12 -0500
Received: from parmenides.zen.co.uk ([212.23.8.69]:25358 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP
	id <S267201AbSLKQPK>; Wed, 11 Dec 2002 11:15:10 -0500
X-Zen-Trace: 217.155.72.205
Date: Wed, 11 Dec 2002 16:22:55 +0000
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Hu, Boris" <boris.hu@intel.com>,
       "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>,
       "NPTL list (E-mail)" <phil-list@redhat.com>
Subject: Re: problem about CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID ?
Message-ID: <20021211162255.B12861@computer-surgery.co.uk>
References: <957BD1C2BF3CD411B6C500A0C944CA260216C261@pdsmsx32.pd.intel.com> <3DF63A0C.6010708@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DF63A0C.6010708@redhat.com>; from drepper@redhat.com on Tue, Dec 10, 2002 at 11:01:32AM -0800
From: Roger Gammans <roger@computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2002 at 11:01:32AM -0800, Ulrich Drepper wrote:
> Hu, Boris wrote:
>=20
> >  I have searched CLONE_PARENT_SETTID in kernel, it seems only to appear=
 in=20
> > some non-architecture files, such as /include/linux/sched.h and several=
 arch
> [snip]
> the kernel.  Nobody cared for Arm so far so there obviously is no kernel
> support.

Unless Russell has changed his mind recently,[1] use of SWP in userspace co=
de=20
isn't supported.
I suppose this is less of a concern if futex's work on ARM though.

But you'll need some userspace synchronisation primitive to do useful work=
=20
with threads.

TTFN
[1]	And I haven't been following linux-arm recently.
--=20
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)
GPG Key FPR: CFF1 F383 F854 4E6A 918D  5CFF A90D E73B 88DE 0B3E

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE992ZeqQ3nO4jeCz4RAkaUAJ9P1r5837xVDzpFtKnxqXVacv5XNgCggUiL
VF/rxbG14V8m3RJkZUIFGRY=
=YOoA
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
