Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTJPFTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 01:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTJPFTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 01:19:55 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:25232 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S262730AbTJPFTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 01:19:53 -0400
Date: Thu, 16 Oct 2003 07:19:51 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031016051951.GP20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com> <20031015181658.GA9652@iram.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V807UU2SgBo1k3+M"
Content-Disposition: inline
In-Reply-To: <20031015181658.GA9652@iram.es>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V807UU2SgBo1k3+M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-15 20:16:58 +0200, Gabriel Paubert <paubert@iram.es>
wrote in message <20031015181658.GA9652@iram.es>:
> On Wed, Oct 15, 2003 at 06:10:15AM -0700, William Lee Irwin III wrote:
> > On Tue, 2003-10-14 15:56:38 -0700, cliff white <cliffw@osdl.org>
> > Can you quantify the performance impact of cmov emulation (or whatever
> > it is)? I have a vague notion it could be hard given the daunting task
> > of switching userspace around to verify it.
> The other problem of the 386 is that it has a fundamental MMU flaw:
> no write protection on kernel mode accesses to user space, which makes=20
> put_user() intrinsically racy on a 386 and way more bloated when it is
> inlined (access_ok has to call a function which searches the VMA tree).

However, this problem exists since the very first hour. Linux once
really ran quite well on those machines...

I've rebooted my P-Classic router last night. Maybe I can see (in two
weeks or in a month or the like...) why it slows down, even with 32MB
RAM...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--V807UU2SgBo1k3+M
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jip3Hb1edYOZ4bsRAq0bAKCC7qdYU8HDX/3srDgnQPweBWZDtwCfXwm8
fNWiZn4AN8iHO5Nd7On/9ls=
=om0F
-----END PGP SIGNATURE-----

--V807UU2SgBo1k3+M--
