Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVISJBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVISJBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVISJBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:01:08 -0400
Received: from h80ad253d.async.vt.edu ([128.173.37.61]:51343 "EHLO
	h80ad253d.async.vt.edu") by vger.kernel.org with ESMTP
	id S932388AbVISJBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:01:07 -0400
Message-Id: <200509190900.j8J90lXx001654@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: "\"Martin v. =?ISO-8859-1?Q?L=F6wis=22?=" <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts 
In-Reply-To: Your message of "Mon, 19 Sep 2005 10:26:22 +0200."
             <1127118382.1080.19.camel@tara.firmix.at> 
From: Valdis.Kletnieks@vt.edu
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it> <432E448D.2080402@v.loewis.de>
            <1127118382.1080.19.camel@tara.firmix.at>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127120446_2682P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Sep 2005 05:00:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127120446_2682P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Sep 2005 10:26:22 +0200, Bernd Petrovitsch said:

> We will see how it develops. Actually the marker could be used to detec=
t
> endianness of the file if I read below URL correctly ....

Text files have endianness????

> ----  snip  ----
> Q: How I should deal with BOMs?
> =5B...=5D
> 3. Some byte oriented protocols expect ASCII characters at the beginnin=
g
> of a file. If UTF-8 is used with these protocols, use of the BOM as
> encoding form signature should be avoided.
> ----  snip  ----
> Voila. Avoid the BOM in your scripts and be done.

At which point the proposed kernel patch becomes pointless.. ;)


--==_Exmh_1127120446_2682P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDLn4+cC3lWbTT17ARAipDAKC8beFmI9fu56qfDWpkS94Y9Ep76QCfczV3
Q33F+r8zh2Ic7QVOwtNu2SY=
=xHuh
-----END PGP SIGNATURE-----

--==_Exmh_1127120446_2682P--
