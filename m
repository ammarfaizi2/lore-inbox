Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbWF1WjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbWF1WjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbWF1WjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:39:04 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:19914 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1751637AbWF1WjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:39:03 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
Organization: K Desktop Environment
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?iso-8859-1?q?in=09-mm?=)
Date: Thu, 29 Jun 2006 00:37:57 +0200
User-Agent: KMail/1.9.3
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606290019.17298.sebas@kde.org> <20060628222417.GA27526@elf.ucw.cz>
In-Reply-To: <20060628222417.GA27526@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1238998.hRgyJxoDHD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606290038.01733.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1238998.hRgyJxoDHD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 June 2006 00:24, Pavel Machek wrote:
> > > Okay, can I get some details? Like how much memory does system have,
> > > what stress test causes the failure?
> >
> > The machine has 1GB of RAM, filling it up beyond 500MB, maybe 600MB
> > usually made swsusp a problem. I'd need to close apps then to be able to
> > suspend.
>
> I'm pretty sure I do suspending with most of RAM full. You have
> big-enough swap partition, right?

1 GB, it might not be completely empty though. I probably only hit swsusp=20
limit much earlier than suspend2's (which after 34 suspend/resume cycles an=
d=20
heavy use in between I did not hit yet).=20
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
Mohandas K. Gandhi often changed his mind publicly. An aide once asked him =
how=20
he could so freely contradict this week what he had said just last week. Th=
e=20
great man replied that it was because this week he knew better.


--nextPart1238998.hRgyJxoDHD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKMEyWdNh9WRGQ75AQK/tgf+IkvVGYHvMKLMTi6P45wYh9UjMWQQ+2Uy
7qUO/namYKdda9tCoXPGjVr6AU73uFYG7k1yMzxE6XTsX15pPzRTK0nU70WHnEco
yIihVZmTSD++2saXHGJ/zQSOnFdmhkx0TThDFUxrvmSDIl1UklGKQ/nEUVSmUSvQ
2gF2K3QA3LLLIsvz/0sXgjMYwkAL2uizhIED8bOPO6KpVxShbV05bRsKoUgYpFrI
d/9tI7Pf4/o8xmYoFhgd1NP+0tHC6FjAeBkHNQbSe/4QEjak3XneVhoBwy9VypvJ
iOZ5al1oa2FaDTXhXokGw307DTHlqr7yeWw4SKMyP57l2vw51NabSg==
=EHkA
-----END PGP SIGNATURE-----

--nextPart1238998.hRgyJxoDHD--
