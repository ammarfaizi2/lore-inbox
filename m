Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUEYK1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUEYK1o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 06:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUEYK1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 06:27:44 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:60816 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S264833AbUEYK1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 06:27:42 -0400
Date: Tue, 25 May 2004 12:26:59 +0200
From: Malte =?ISO-8859-1?B?U2NocvZkZXI=?= <MalteSch@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@muc.de>
Subject: Re: Bad X-performance on 2.6.6 & 2.6.7-rc1 on x86-64
Message-Id: <20040525122659.395783f4@highlander.Home.LAN>
In-Reply-To: <m3r7t9d3li.fsf@averell.firstfloor.org>
References: <1ZqbC-5Gl-13@gated-at.bofh.it>
	<m3r7t9d3li.fsf@averell.firstfloor.org>
Reply-To: MalteSch@gmx.de
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__25_May_2004_12_26_59_+0200_7_eN9eeQO+VrbEtf"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__25_May_2004_12_26_59_+0200_7_eN9eeQO+VrbEtf
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

New information :)
I didn't profile it yet but I think I found what caused the problem.
It turned out that I have to disable alsa mmap-support in xine (mplayer wor=
ked w/o problems, it does not offer alsa mmap), so X is not involved at all=
. Do you still need a profile or is this a known thing?
Ah, before I forget, my userspace is 32bit-only, I have a 64-bit chroot I w=
anted to do some testing with.

Greets
--=20
---------------------------------------
Malte Schr=F6der
MalteSch@gmx.de
ICQ# 68121508
---------------------------------------


--Signature=_Tue__25_May_2004_12_26_59_+0200_7_eN9eeQO+VrbEtf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsx924q3E2oMjYtURAoojAKCf/UsclBrNXP9tXPtMDI4xizqilACfeWy2
u5jsJnugpkv6Zi7m4UT8p5c=
=IqUh
-----END PGP SIGNATURE-----

--Signature=_Tue__25_May_2004_12_26_59_+0200_7_eN9eeQO+VrbEtf--
