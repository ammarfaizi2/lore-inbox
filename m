Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289119AbSAVBOa>; Mon, 21 Jan 2002 20:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289120AbSAVBOU>; Mon, 21 Jan 2002 20:14:20 -0500
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:58706
	"EHLO darklands.zimres.net") by vger.kernel.org with ESMTP
	id <S289119AbSAVBOK>; Mon, 21 Jan 2002 20:14:10 -0500
Date: Mon, 21 Jan 2002 15:52:46 -0800
From: Thomas Zimmerman <thomas@zimres.net>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020121235246.GA2974@zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
In-Reply-To: <20020121021355.GA60801@compsoc.man.ac.uk> <386.1011580260@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <386.1011580260@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux lightlands 2.4.18-pre3 
X-Operating-Status: 14:58:05 up  3:08,  2 users,  load average: 0.44, 0.47, 0.24
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21-Jan 01:31, Keith Owens wrote:
> On Mon, 21 Jan 2002 02:13:55 +0000,=20
> John Levon <movement@marcelothewonderpenguin.com> wrote:
> >On Mon, Jan 21, 2002 at 12:53:28PM +1100, Keith Owens wrote:
> >> Guess why these entries are in /proc/ksyms?
> >>=20
> >> c48a2300 __insmod_3c589_cs_S.bss_L4	[3c589_cs]
> >
> >and quite often the user has unloaded / loaded modules in the meantime
> >and the oops is useless.
>=20
> /var/log/ksymoops.  I added the code and documented it nicely, man
> insmod or ksymoops.  It's not my fault if nobody reads the docs!
>=20
> >It would be nice if klogd's oops detection just passed everything to ksy=
moops
> >untouched, and stored everything somewhere using -m
>=20
> It would be better if klogd got out of the way completely.  Everything
> is stored, just created /var/log/ksymoops.

Isn't part of the problem with klogd mangling is that is sort of works?
Change the format so that klogd doesn't touch it and that gets _wrong_ Oops
reports out of the way. [you do great work, now make someone else do some
too!]=20

Just my $0.02, from a thankful user.

Thomas
--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8TKnNUHPW3p9PurIRAhDuAJ0c5mhE+dSFqfS3zn/e5LLVMqAZ8gCfcgpR
MX0XhNzKvYjjwByZeBogZqg=
=CFWN
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
