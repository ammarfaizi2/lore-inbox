Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWF0XTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWF0XTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWF0XTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:19:52 -0400
Received: from smeltpunt.science.ru.nl ([131.174.16.145]:18911 "EHLO
	smeltpunt.science.ru.nl") by vger.kernel.org with ESMTP
	id S1422722AbWF0XTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:19:52 -0400
From: Sebastian =?iso-8859-1?q?K=FCgler?= <sebas@kde.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp / suspend2 reliability (was Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion =?iso-8859-1?q?in=09-mm?=)
Date: Wed, 28 Jun 2006 01:18:10 +0200
User-Agent: KMail/1.9.3
Cc: suspend2-devel@lists.suspend2.net,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
References: <200606270147.16501.ncunningham@linuxmail.org> <200606280039.06296.sebas@kde.org> <20060627225105.GC8642@elf.ucw.cz>
In-Reply-To: <20060627225105.GC8642@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7850253.Eq8IzNv5LV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606280118.23270.sebas@kde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7850253.Eq8IzNv5LV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 28 June 2006 00:51, Pavel Machek wrote:
> On Wed 2006-06-28 00:38:59, Sebastian K=FCgler wrote:
> > On Wednesday 28 June 2006 00:22, Pavel Machek wrote:
> > > I do not think suspend2 works on more machines than in-kernel
> > > swsusp. Problems are in drivers, and drivers are shared.
> > >
> > > That means that if you have machine where suspend2 works and swsusp
> > > does not, please tell me. I do not think there are many of them.
> >
> > Maybe not machines, but definitely usage scenarios. I've tried both
> > implementations lately, and swsusp would often -- especially under high
> > memory load -- just return from trying, while suspend2 succeeds in
> > freeing enough memory to be able to suspend _every_ time.
>
> Refrigerator fixes should help with this one. Does it still happen in
> 2.6.17?

Last release I tested was 2.6.17-rc6-git7.

> > Is that something uswsusp is likely to change anytime soon?
>
> Actually this is common code for both swsusp and uswsusp; yes this
> should be fixed.

In the above mentioned release it definitely is not fixed.
=2D-=20
sebas

 http://www.kde.org | http://vizZzion.org |  GPG Key ID: 9119 0EF9=20
=2D - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -=
 -
If you can't stand the heat, get out of the kitchen. - Harry S. Truman


--nextPart7850253.Eq8IzNv5LV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQEVAwUARKG8vmdNh9WRGQ75AQLFogf+NACzCn6BPyesTZPtgXMS8GQv0D3g1GJK
JxMIUvk9mOSk+u7UbsNHxp4tVnYwp9UbVu+ke6+NbTD5E/zT6vVb/VBcVRxts2bJ
lGFahdhSPJm/fzMkRfU7m6fLTPKISsq97K+ry+R9wEYhbP+/dAuBfLNhjrIt7K3i
0Xn2ctKWxU8DnQ3mR63TXno/B3z+6kpj7Nkdy5VyzD5kAVWKf6klJ1JDCxu8XHnj
XfRl+5e5dzxztFf84n+5iR0/4sfpOp0MTD9wLSSGPT7eXMijENjIaNGp8J67rShm
eSNAEQyKOJ9blWxOMf47U8tmzMqIxv6t0qLzN5cmPQ2756TJvQpruw==
=mD7W
-----END PGP SIGNATURE-----

--nextPart7850253.Eq8IzNv5LV--
