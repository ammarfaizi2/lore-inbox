Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRG3UXh>; Mon, 30 Jul 2001 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267784AbRG3UX1>; Mon, 30 Jul 2001 16:23:27 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:45894 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S267771AbRG3UXS>; Mon, 30 Jul 2001 16:23:18 -0400
Date: Mon, 30 Jul 2001 22:21:33 +0200
From: Kurt Garloff <garloff@suse.de>
To: "James A. Treacy" <treacy@home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Random (hard) lockups
Message-ID: <20010730222133.D26097@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"James A. Treacy" <treacy@home.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20010729143401.A527@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20010729143401.A527@debian.org>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 29, 2001 at 02:34:01PM -0400, James A. Treacy wrote:
> The machine is a 1GHz Athlon (266) on an MSI K7T Turbo with 256M ram,

A 1.2GHz Athlon with the very same motherboard and the same amount of RAM
seems to be stable with 2.4.7 and PPro or K6 optimizations and crashes
during the init procedure if the kernel is optimized for K7.

It seems that the board is sensitive to high memory bandwidth operations.
This may be due to bad electrical design of the board or the chipset or due
to bad chipset settings. (See thread VIA KT133A / athlon / MMX)

It may be a good idea to play with BIOS settings or slow the machine down a
bit.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZcHNxmLh6hyYd04RAumVAKDF9tAVsP7tFJHxR69kcC2aARpCNgCfSkEC
RYyiYVs8izjgBwYBeW0YYMc=
=lgEv
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
