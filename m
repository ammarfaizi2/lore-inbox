Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270194AbTGPH7L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 03:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270196AbTGPH7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 03:59:11 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:25612 "EHLO
	hera.eugeneteo.net") by vger.kernel.org with ESMTP id S270194AbTGPH7H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 03:59:07 -0400
Date: Wed, 16 Jul 2003 16:13:50 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre6 + alsa 0.9.5 + i810 not work
Message-ID: <20030716081350.GA8976@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F150561.5040903@opentle.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <3F150561.5040903@opentle.org>
X-Operating-System: Linux 2.2.20
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Intel 810 + AC97 Audio, version 0.24, 11:19:13 Jul 16 2003
> i810_rng: RNG not detected

Looks like the same specs as I have for Fujitsu E-7010.

Have you tried choosing (Y), instead of compiling it as modules?

// Intel ICH (i8xx), SiS 7012, NVidia nForce Audio or AMD 768/811x
CONFIG_SOUND_ICH=3Dy=20

> :: My labtop ::
> Toshiba 2410
> Gentoo linux
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio=
=20
> Controller (rev 02)

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio
(rev 02)
Subsystem: Citicorp TTI: Unknown device 1177
Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=3Dmedium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Interrupt: pin B routed to IRQ 11
Region 0: I/O ports at 1000
Region 1: I/O ports at 1880

positive. It is the same one.

Cheers,
Eugene
--=20
Eugene TEO @ Linux Users Group, Singapore <eugeneteo@lugs.org.sg>
GPG FP: D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5=20
main(i){putchar(182623909>>(i-1)*5&31|!!(i<7)<<6)&&main(++i);}


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/FQk+cyGjihSg3eURAi5pAJwN3IbVPbNukgEienv4Grfgx9KW9gCfRl4w
8clAOd7sNC83ToeIm1+OGnc=
=aC/0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
