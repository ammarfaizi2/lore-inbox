Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWBELSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWBELSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 06:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWBELSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 06:18:12 -0500
Received: from nsm.pl ([195.34.211.229]:20744 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1750741AbWBELSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 06:18:11 -0500
Date: Sun, 5 Feb 2006 12:17:52 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] How to tune kernel to swap more often (video ram swap)
Message-ID: <20060205111752.GA4636@irc.pl>
Mail-Followup-To: Eric Piel <Eric.Piel@tremplin-utc.net>,
	linux-kernel@vger.kernel.org
References: <b92f4fd10602050204g41f70f70p@mail.gmail.com> <43E5DD0A.3030009@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <43E5DD0A.3030009@tremplin-utc.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 05, 2006 at 12:10:02PM +0100, Eric Piel wrote:
> 05.02.2006 11:04, Pawe=B3 Zadr=B1g wrote/a =E9crit:
> >Yo...
> >
> >In normal case, using harddisk as a swap space i should ask how to cut
> >down swapping, or make swapping when idle, etc... My case is a little
> >bit diffrent... I have a 256MB video card, while 240MB of it is used
> >as a swap space. And the question is: how to tune kernel to swap more
> >often. I known swapped memory must be copied back to ram before beeing
> >used, so i'm looking for a reasonable tunning values...
>=20
> Am I correctly understanding that you are using your video card memory=20
> as a place to put swap? This sounds quite cool, how have you done this?=
=20
> Is there a driver which can report the video ram as a block device?

 It's an old trick with MTD devices:
http://hedera.linuxnews.pl/_news/2002/09/03/_long/1445.html

--=20
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFD5d7gThhlKowQALQRAq+YAKCBLxlOhx+HX3ULh5/CacYBFQqi3wCfRHge
S8XZsLv2QCCTVQ5nDTB35xc=
=sdRQ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
