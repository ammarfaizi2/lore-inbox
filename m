Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGEUJ1>; Fri, 5 Jul 2002 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317551AbSGEUJ0>; Fri, 5 Jul 2002 16:09:26 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50438 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317550AbSGEUJZ>; Fri, 5 Jul 2002 16:09:25 -0400
Date: Fri, 5 Jul 2002 22:11:55 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Desktar disk problem?
Message-ID: <20020705201155.GF28569@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0207051524480.9092-100000@cibs9.sns.it> <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0207051606050.32493-100000@moje.ich.vabo.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 05 Jul 2002, Tomas Konir wrote:

> hi i have similar problem.
> No dead disks, but after two days testing tcq patches (on 2.4). I=20
> got the two ATA errors (smartctl said).=20

*shrug* FreeBSD should have eaten some of those drives as well, it has
been offering hw.ata.tags=3D"1" to enable DMA QUEUED for a while now.

And yes, my deathstar DTLA307045 still works without a single broken
block, but never used TCQ beyond booting 2.5.17 once (no LVM -> not
useful for me).

Another DTLA307045 died some days ago, it has never seen TCQ.

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Jf2LFmbjPHp/pcMRAmivAJ9hwIG+EFB0FZ00hoO0X4lemCmXHACfYyUh
fg98ycPIsvnt1LWB234xpkY=
=/QPS
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
