Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269777AbRH0XQF>; Mon, 27 Aug 2001 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269739AbRH0XPv>; Mon, 27 Aug 2001 19:15:51 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:7705 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269770AbRH0XPd>; Mon, 27 Aug 2001 19:15:33 -0400
Date: Tue, 28 Aug 2001 01:15:49 +0200
From: Kurt Garloff <kurt@garloff.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
Message-ID: <20010828011549.J12566@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <kurt@garloff.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSaCG/zfRnOiPJtU"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VSaCG/zfRnOiPJtU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 27, 2001 at 01:25:45PM -0700, Linus Torvalds wrote:
>=20
> Ok, I'm back from Finland, and there's a 2.4.10-pre1 update on kernel.org.
> Changelog appended..
>=20
> The most noticeable one (under the right loads) is probably the one-liner
> by Daniel that avoids some bad behaviour when swapping.

Looks like a good one.
Actually, I got two wishes for 2.4.10:
* It hopefully overcomes all the VM trouble
  (this list is full of reports; some of my observation look like creating
   dirty pages in the page cache at a high rate makes your system crawl.
   An efficient way is use mkfs with Andrea's blkdev-pgcache patch, but
   it's not the only way.)
* It'll hopefully be identical to 2.5.0,
  so people have a kernel to put experimental stuff in instead of 2.4.x
  Good things can always be backported, once proven stable.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--VSaCG/zfRnOiPJtU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7itSlxmLh6hyYd04RAmA9AJ4+rBDZHrJhvuLmWqjxKEMzqwE9KACg2aeL
8KYa7l7ysbB6+C9/68uezLE=
=CslR
-----END PGP SIGNATURE-----

--VSaCG/zfRnOiPJtU--
