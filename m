Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263188AbTJPQQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJPQQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:16:37 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:56029 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263188AbTJPQQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:16:35 -0400
Date: Thu, 16 Oct 2003 18:16:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031016161633.GS20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay> <20031014155638.7db76874.cliffw@osdl.org> <20031015124842.GE20846@lug-owl.de> <20031015131015.GR16158@holomorphy.com> <20031015181658.GA9652@iram.es> <20031016051951.GP20846@lug-owl.de> <20031016081611.GA14949@iram.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0Vsbun0CJ9H5mm4"
Content-Disposition: inline
In-Reply-To: <20031016081611.GA14949@iram.es>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o0Vsbun0CJ9H5mm4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-16 10:16:11 +0200, Gabriel Paubert <paubert@iram.es>
wrote in message <20031016081611.GA14949@iram.es>:
> On Thu, Oct 16, 2003 at 07:19:51AM +0200, Jan-Benedict Glaw wrote:
> > On Wed, 2003-10-15 20:16:58 +0200, Gabriel Paubert <paubert@iram.es>
> > wrote in message <20031015181658.GA9652@iram.es>:
> > > On Wed, Oct 15, 2003 at 06:10:15AM -0700, William Lee Irwin III wrote:
> > > > On Tue, 2003-10-14 15:56:38 -0700, cliff white <cliffw@osdl.org>
> > I've rebooted my P-Classic router last night. Maybe I can see (in two
> > weeks or in a month or the like...) why it slows down, even with 32MB
> > RAM...
>=20
> It might be related to the size-4096 memory leak others are reporting=20
> right now. I don't know, but it's not such a far-fetched hypothesis
> either.

size-4096 only decreased (!) by one since reboot. However, size-64 seems
to be sloooowly growing:

jbglaw@gatter:~$ grep size-64 slabinfo_after_reboot /proc/slabinfo |cut -b =
1-60
slabinfo_after_reboot:size-64(DMA)           0      0     64
slabinfo_after_reboot:size-64             2655   2655     64
/proc/slabinfo:size-64(DMA)           0      0     64   59 =20
/proc/slabinfo:size-64             2883   6608     64   59 =20

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--o0Vsbun0CJ9H5mm4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jsRhHb1edYOZ4bsRAlm6AJ9WQb39d7G0Hh47kuwjYQOwPM1r3QCgjRXQ
e2Zze1srqz6RC2t3FMXDRvo=
=174N
-----END PGP SIGNATURE-----

--o0Vsbun0CJ9H5mm4--
