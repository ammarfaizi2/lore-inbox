Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbSJaLCI>; Thu, 31 Oct 2002 06:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbSJaLCI>; Thu, 31 Oct 2002 06:02:08 -0500
Received: from codepoet.org ([166.70.99.138]:45260 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S264849AbSJaLCF>;
	Thu, 31 Oct 2002 06:02:05 -0500
Date: Thu, 31 Oct 2002 04:08:30 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031110830.GA28812@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rasmus Andersen <rasmus@jaquet.dk>, Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031092440.B5815@jaquet.dk> <20021031100512.GA27985@codepoet.org> <20021031110834.J5815@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20021031110834.J5815@jaquet.dk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu Oct 31, 2002 at 11:08:34AM +0100, Rasmus Andersen wrote:
> On Thu, Oct 31, 2002 at 03:05:12AM -0700, Erik Andersen wrote:
> > I build all my kernels with -Os and it works just fine for me.
>=20
> Right then, I guess I'll give it an another shot. Do you
> have any numbers in terms of saved space etc. to share?
> Other impressions?

Here are some numbers for you.  Using 2.4.20-pre-10-erik (the
hacked up kernel I happen to be using on my desktop) using gcc
2.95.4 (from Debian testing) and my stock kernel configuration:

bzImage compiled -O2:   1268158
bzImage compiled -Os:   1251431

vmlinux compiled -O2:   3457737
vmlinux compiled -Os:   3437257

/lib/modules/kernel size -O2:  2472629
/lib/modules/kernel size -Os:  2463661

   text    data     bss     dec     hex filename
2354620  316768  258136 2929524  2cb374 vmlinux.O2
2336016  316768  258136 2910920  2c6ac8 vmlinux.Os

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9wQ8tX5tkPjDTkFcRAgVwAJ9VJ1q+O7kzZRtqDGRPgSwz9wgOSACdHdB3
mPl35/JZNPDokHrSxA8UWgk=
=gOFT
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
