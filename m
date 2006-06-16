Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWFPXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWFPXLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWFPXLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:11:13 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:26785 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751537AbWFPXLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:11:12 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Date: Sat, 17 Jun 2006 09:12:51 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       p.lundkvist@telia.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       Mark Lord <lkml@rtr.ca>
References: <20060520130326.GA6092@localhost> <20060520171244.4399bc54.akpm@osdl.org> <20060616212410.GA6821@linuxtv.org>
In-Reply-To: <20060616212410.GA6821@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1268734.0ARVvHvgx7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606170912.55334.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1268734.0ARVvHvgx7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Sorry for coming late to the party. I've only just seen this thread, and ha=
ve=20
had reports of it too.

My concern is, shouldn't we be dealing with the cause rather than just one=
=20
symptom (and as Pavel rightly wondered, assuming there aren't more)? I'm no=
t=20
sure that I have a solution, but I think the point is worth raising again.

Do we want something like adding the process's task struct to timer data, a=
nd=20
get the timer code to delay firing timers for frozen processes?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart1268734.0ARVvHvgx7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkzr3N0y+n1M3mo0RAg2OAKDeXstVOe9WvdD7NDtWiJFGx1o8dwCeJf8U
GEQFVqI3ex/BzPb1IKXdMDU=
=1Jy8
-----END PGP SIGNATURE-----

--nextPart1268734.0ARVvHvgx7--
