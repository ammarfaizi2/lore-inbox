Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVJXQc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVJXQc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVJXQc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:32:28 -0400
Received: from kokytos.rz.ifi.lmu.de ([141.84.214.13]:45215 "EHLO
	kokytos.rz.ifi.lmu.de") by vger.kernel.org with ESMTP
	id S1751142AbVJXQc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:32:27 -0400
From: Michael Brade <brade@informatik.uni-muenchen.de>
Organization: =?iso-8859-15?q?Universit=E4t?= =?iso-8859-15?q?_M=FCnchen?=, Institut =?iso-8859-15?q?f=FCr?= Informatik
To: "John Stoffel" <john@stoffel.org>
Subject: Re: ieee1394: sbp2: sbp2util_node_write_no_wait failed
Date: Mon, 24 Oct 2005 18:33:59 +0200
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
References: <200510241451.27320.brade@informatik.uni-muenchen.de> <17244.59851.9303.25151@smtp.charter.net>
In-Reply-To: <17244.59851.9303.25151@smtp.charter.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3528003.mkLA1GuEoV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510241834.03948.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3528003.mkLA1GuEoV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 24 October 2005 16:03, John Stoffel wrote:
> Michael> I get the above message frequently while copying data (around
> Michael> 200000 mail files, 2GB) from my laptop to an external
> Michael> harddisk via ieee1394. The ieee system completely deadlocked
> Michael> with 2.6.13 without the chance to umount or reuse the
> Michael> device. Now I upgraded to 2.6.14-rc5 and I still get the
> Michael> error followed by a 10sec pause or so, but then the copying
> Michael> continues. I will have to check if it copied all data
> Michael> correctly, though.
Ok, update and good news: it did actually copy the files properly, reading =
and=20
checking worked without errors.

> One thing I suggest right off the bat is to make sure that firmware on
> your external enclosure is updated to the latest/greatest.  Alot of
> vendors (esp those using the Prolific chipset) don't get it right
> initially.
Good guess and damn, yes, I've got the Icy Box IB-351-UE which has the=20
prolific chipset, I guess it's the (cursed) PL3507. [The IcyBox FAQ says:=20
IB-350/351/360UE Prolific (PL3507) - Agere (FW8028)]=20

However, I've read that they had problems in 2004 and that all new devices=
=20
(starting from October 2004) have the updated firmware already.=20

I have also found some of your posts from 2004 on lkml about the prolific=20
chipset, actually anything I found is mostly from 2004 :-/

So sorry for the dumb question, but do I check if I've got the newest firmw=
are=20
without windows? I had a look at www.icybox.de but found no firmware for=20
ib-351, only for ib-350 and that one is from Dec 2004.

And even if I've got the newest firmware already, does the prolific stuff w=
ork=20
by now or should I chuck it out the window?

> Other than that, at least it's recovering better now and not locking
> up!
Yes, which makes the thing at least usable now :-) But it still takes forev=
er=20
since it happens every 30-120 seconds. And just now the HD started making=20
*really* strange noises after I let it sit there idle for 10-20 minutes or=
=20
so. The I quickly read some files and it stopped. I'm scared of my data...

Thanks for your help,
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--nextPart3528003.mkLA1GuEoV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDXQz7dK2tAWD5bo0RAuKbAKDnrw/HGG0AGMVXyeXiRUFM/Nj0+wCfUrfg
s2qL+PPKdG/vUTQAjNjcELA=
=CF0b
-----END PGP SIGNATURE-----

--nextPart3528003.mkLA1GuEoV--
