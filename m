Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946717AbWKJP5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946717AbWKJP5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 10:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946719AbWKJP5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 10:57:53 -0500
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:38332 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S1946717AbWKJP5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 10:57:52 -0500
Date: Fri, 10 Nov 2006 16:57:48 +0100
From: martin f krafft <madduck@madduck.net>
To: linux-kernel@vger.kernel.org
Subject: Re: scary messages: HSM violation during boot of 2.6.18/amd64
Message-ID: <20061110155748.GA6081@piper.madduck.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <455496CA.5040405@wpkg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <455496CA.5040405@wpkg.org>
X-OS: Debian GNU/Linux 4.0 kernel 2.6.17-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Tomasz Chmielewski <mangoo@wpkg.org> [2006.11.10.1612 +0100]:
> I saw similar when using smartctl / smartd with wrong options (without=20
> -d ata; in short, smartd tried to talk "IDE language" to SATA device...).

I am using smartd, and you are right: it triggers those messages
after being started:

  [smartd start]
  kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
  kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violatio=
n)
  kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  kernel: ata2: soft resetting port
  kernel: ata2.00: configured for UDMA/133
  kernel: ata2: EH complete
  [...]
  kernel: ata3: no sense translation for status: 0x50
  kernel: ata3: translated ATA stat/err 0x50/00 to SCSI SK/ASC/ASCQ 0xb/00/=
00
  kernel: ata3: status=3D0x50 { DriveReady SeekComplete }

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"it is only the modern that ever becomes old-fashioned."=20
                                                        -- oscar wilde

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFVKF8IgvIgzMMSnURArxTAKDsmd9bt6x8+GnvMyAuWgYujTfSBACeMY+L
i+mf8MPjDiA9zkZ5nSksxdY=
=75aJ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
