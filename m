Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTJYMBj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 08:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTJYMBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 08:01:39 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:17670 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S262577AbTJYMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 08:01:37 -0400
Date: Sat, 25 Oct 2003 12:55:59 +0200
From: Vid Strpic <vms@bofhlet.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
Message-ID: <20031025105559.GD1143@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
References: <20031024103225.GC1046@home.bofhlet.net> <20031024185953.GA9265@win.tue.nl> <87ismdoc2s.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <87ismdoc2s.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test8
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2003 at 07:18:03PM +0900, OGAWA Hirofumi wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> > On Fri, Oct 24, 2003 at 12:32:26PM +0200, Vid Strpic wrote:
> > > Yesterday, I just wanted to download some pics from a Smartmedia
> > > card from my camera.  I put the card into the reader (USB Mass
> > > Storage Flash Card Reader, Manufacturer: EZ, Serial Number:
> > > 9876543210ABCDEF, driver is usb-storage and working well now, I
> > > had problems earlier), but the kernel doesn't recognize FAT
> > > filesystem on the card...
> > > Oct 23 17:19:01 moria kernel: FAT: invalid first entry of FAT
> > > (0xff8 !=3D 0x0)
> > How was this card formatted?
> It looks like it doesn't conform to Microsoft's or SmartMedia's
> specifications.
> Yes. It will be important to know how it was formated.=20

Well, I really don't know if it was formatted when I bought it, 2 years
ago.  What puzzles me, is that 2.4 mounts it normally...

This is the hex dump of begginning (problematic no-name 64Mb card):

0000000: e900 002a 6453 777c 4948 4300 0220 0100  ...*dSw|IHC.. ..
0000010: 0200 0100 00f8 0c00 2000 0800 3700 0000  ........ ...7...
0000020: c9f3 0100 0000 0000 0000 0000 0000 0000  ................
0000030: 0000 0000 0000 4641 5431 3220 2020 0000  ......FAT12   ..
0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................

And this is the SanDisk 32Mb card which mounts normally under 2.6:

0000000: e900 0020 2020 2020 2020 2000 0220 0100  ...        .. ..
0000010: 0200 01dd f9f8 0600 1000 0800 2300 0000  ............#...
0000020: 0000 0000 0000 2900 0000 004e 4f20 4e41  ......)....NO NA
0000030: 4d45 2020 2020 4641 5431 3220 2020 0000  ME    FAT12   ..
0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................


Maybe I should try to reformat the card in the reader?  My camera has
'delete all images' but no 'format card' I'm sorry...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test8 #1 Mon Oct 20 16:19:20 CEST 2003 i686
 12:52:51 up 19:36,  1 user,  load average: 0.14, 0.25, 0.18
Moderna algebra je kad u 4 ujutro vadis korijen iz nepoznate.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mla/q1AzG0/iPGMRAjkoAKCFzrAIUoF8duIvMqdqygGuDjnLOACdHGOI
K7sA/WQPXtiwKhVtL+M1TXM=
=DpQd
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
