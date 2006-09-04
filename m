Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWIDMfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWIDMfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWIDMfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:35:54 -0400
Received: from nsm.pl ([195.34.211.229]:28164 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S964804AbWIDMfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:35:52 -0400
Date: Mon, 4 Sep 2006 14:35:46 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: PATA drivers queued for 2.6.19
Message-ID: <20060904123546.GB23978@irc.pl>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com> <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2006 at 02:07:29PM +0200, Jan Engelhardt wrote:
> >>I just pulled the "pata-drivers" branch of libata-dev.git into the=20
> >>"upstream" branch, which means that Alan's libata PATA driver collectio=
n=20
> >>is now queued for 2.6.19.
> >>
> >>Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for=
=20
> >>many months.  Community-wise, no one posted objections to the PATA=20
> >>driver merge plan, when Alan posted it on LKML and linux-ide.
> >
> >Too friggin' hard to test Alan's stuff for older IDE here, therefore=20
> >ignored so far :(   I have some old hardware that Alan is addressing,=20
> >even an old IBM 260MB PCMCIA HDD.
> >
> >I can't see an easy way to arrange multi-boot with different /etc/fstab=
=20
> >depending if I'm trying /dev/hdaX or /dev/sdaX.  Parallel '/' partitions?
>=20
> Got udev?
>=20
> /dev/disk/by-id/ata-ST3802110A_5LR13RN7-partX could be your friend.

  Almost. It would alternate between "ata-" and "scsi-".

--=20
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia


--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFE/B2i10UJr+75NrkRAmQeAJ459ZMUpXKgL8V+q3wgUhGhVZh7IgCfTSpw
MLouCQpsYse7zK3VP07cwkU=
=xicF
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--

-- 
VGER BF report: U 0.5
