Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSLAHuc>; Sun, 1 Dec 2002 02:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSLAHuc>; Sun, 1 Dec 2002 02:50:32 -0500
Received: from 28-121-ADSL.red.retevision.es ([80.224.121.28]:24771 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S261523AbSLAHub>; Sun, 1 Dec 2002 02:50:31 -0500
Date: Sun, 1 Dec 2002 08:57:56 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Steffen Moser <lists@steffen-moser.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Exaggerated swap usage
Message-ID: <20021201075756.GB2483@jerry.marcet.dyndns.org>
References: <20021130140518.GB1735@steffen-moser.de> <Pine.LNX.4.44L.0211301621200.15981-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0211301621200.15981-100000@imladris.surriel.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.5.47-ac6 i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Rik van Riel <riel@conectiva.com.br> [021130 19:25]:

>> I've experienced a similar problem with "linux-2.4.20-rc2-ac3",
>> "linux-2.4.20-rc4-ac1" and "linux-2.4.20-ac1". At first I also
>> thought it's a swap problem, but this seems to be a wrong con-
>> clusion, too.

>Known problem, rmap14 doesn't do pageout IO soon enough. This
>is good if the inactive pages are clean (cache) but stalls the
>system if the data needs to be written to disk.

>This should be fixed in rmap15.

Is rmap15 included in 2.4.20-rc4-ac1?
That's the last ac I used and was paging out too much, so that the
system became slow unnecessarily.


--=20
Javier Marcet <jmarcet@pobox.com>

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3pwQQACgkQx/ptJkB7frxJ4ACdFOF2Js9ogQSd8oyXXi0fwxHQ
f5cAmwWYJ/XvaPSASMgB2YpSa5gtSFtC
=BvVP
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--
