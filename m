Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314200AbSDVNyj>; Mon, 22 Apr 2002 09:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314202AbSDVNyi>; Mon, 22 Apr 2002 09:54:38 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:49414 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S314200AbSDVNye>;
	Mon, 22 Apr 2002 09:54:34 -0400
Date: Mon, 22 Apr 2002 15:54:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Trouble rebooting Tyan Thunder K7 (S2462UNG)
Message-ID: <20020422135428.GA13749@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <scc3ce39.035@mail-01.med.umich.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-04-22 09:23:11 -0400, Nicholas Berry <nikberry@med.umich.edu>
wrote in message <scc3ce39.035@mail-01.med.umich.edu>:
> I've had the original problem with a Tyan Tiger MP board. Linux can't
> reboot it, Windoze 2000 can, but in my case the font is screwed up. I
> agree with Steve, it's a BIOS problem - the BIOS on my board is a POS.

Here are my 2 cent:

	- The BIOS screws up (at least) ATI Radeon cards (their fonts)
	- The newest versions (at least 2.09 and 2.10) require to press
	  F1 if you use non-MP Athlons
	- The newest BIOS version (2.10) does __not__ mention a second
	  CPU in the MP table if you use non-MP Athlons. This means that
	  basically the board unconditionally boots up with only __one__
	  CPU, even if you press F1 to accept a non-supported mode.
	- I've added an additional SCSI card. The box didn't come up
	  because this additional card was bootable. I had to remove the
	  boot ROM of that card.

My conclusions:

	- Basically, the board is *very* nice. Two Athlons, two U/160
	  SCSI channels, lots of ECC-protected RAM.
	- BIOS is quite bad. It feels like being unready and is quite
	  unfriendly to not officially supported (non-MP) dual Athlons.
	  Despite that, there are problems with lots of other hardware
	  (ATI Radeon cards, additional bootable SCSI cards, ...).

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjzEFhQACgkQHb1edYOZ4buSsQCdH1hc+UEvZG/OOAn9bzVGcWoy
KGkAn2Mm1YpytMFYUXA/eBp1XtD96WMV
=+6In
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
