Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272415AbTGaG3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 02:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272424AbTGaG3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 02:29:40 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2013 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S272415AbTGaG3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 02:29:37 -0400
Date: Thu, 31 Jul 2003 08:29:36 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731062936.GN1873@lug-owl.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <20030730202822.GG1873@lug-owl.de> <20030730215032.GA18892@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8aUgEFSDYDA6u3T0"
Content-Disposition: inline
In-Reply-To: <20030730215032.GA18892@vana.vc.cvut.cz>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8aUgEFSDYDA6u3T0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-07-30 23:50:32 +0200, Petr Vandrovec <vandrove@vc.cvut.cz>
wrote in message <20030730215032.GA18892@vana.vc.cvut.cz>:
> On Wed, Jul 30, 2003 at 10:28:22PM +0200, Jan-Benedict Glaw wrote:
> > On Wed, 2003-07-30 20:45:29 +0200, Adrian Bunk <bunk@fs.tum.de>

> And yes, it speeds some workloads a lot. Best to look at code,
> with these instructions you can do couple of operations without
> doing IPC to synchronize with other threads.

Which ones? I am always told "it's faster, then", but nobody really
proofed that. Take some multithreadded apps. How often do they *really*
lock/unlock mutexes, and in which ratio does that compare to their
"normal" computing needs?

If an application's main job is locking/unlocking mutexes, then the
author should possibly think about that. If it's main task is to do the
computational stuff, then I've got no (real) problem with this extra
Linux^Wtax, esp. on those faster boxes...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--8aUgEFSDYDA6u3T0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/KLdQHb1edYOZ4bsRAuS1AJYk140llZ42Zfq6Y/I6GslQBiqZAJ9BbeLN
3aRBr4/y6cerXbarCK5ohQ==
=aVWy
-----END PGP SIGNATURE-----

--8aUgEFSDYDA6u3T0--
