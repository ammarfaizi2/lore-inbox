Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWB1Ano@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWB1Ano (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWB1Ann
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:43:43 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:3730 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751520AbWB1Ann (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:43:43 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Tue, 28 Feb 2006 10:40:38 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <200602222112.09567.mail@earthworm.de> <200602272348.37288.mail@earthworm.de>
In-Reply-To: <200602272348.37288.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2996100.gXiE0eJXLC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602281040.44957.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2996100.gXiE0eJXLC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Tuesday 28 February 2006 08:48, Hesse, Christian wrote:
> On Wednesday 22 February 2006 21:12, Hesse, Christian wrote:
> > On Wednesday 22 February 2006 11:10, Hesse, Christian wrote:
> > > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > > Hello everybody,
> > > > > > >
> > > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in
> > > > > > > status D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3.
> > > > > > > Any hints what could be the problem? It worked perfectly with
> > > > > > > 2.6.15.x and suspend2 2.2.
> > > > > >
> > > > > > a) Look in the logs for any oopses, other nasties
> > > > >
> > > > > Nothing.
> > > > >
> > > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo'
> > > > > > then find the trace for `hald' in `foo', send it to this list.
> > > > >
> > > > > Ok, here it is:
> > > > >
> > > > > [ trace snipped ]
> > > > >
> > > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > > >
> > > > Hopefully suspend2 isn't involved.  People would feel more
> > > > comfortable if you could test a vanilla mainline tree..
> > > >
> > > > Could the ACPI team please take a look at fixing this regression?
> > >
> > > I did two cycles with mainline suspend now and did not hit the
> > > problem... I will keep an eye on it.
> >
> > It is independent from suspend version, hald hangs with mainline suspend
> > as well.
>
> I think this is a big regression since 2.5.15. Is anybody working on it? I
> did not get a reply for nearly a week now...
> If anybody needs more information let me know.

I would suggest bugging the acpi guys :)

Regards,

Nigel

--nextPart2996100.gXiE0eJXLC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEA5wMN0y+n1M3mo0RAhDWAKC0xFVNjfcScw9Apcig8CndmoIgwwCfaNEe
Hn87Ptchm/HcpCrioEM4W9w=
=ZjlT
-----END PGP SIGNATURE-----

--nextPart2996100.gXiE0eJXLC--
