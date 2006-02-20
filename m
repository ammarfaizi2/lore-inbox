Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWBTLns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWBTLns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWBTLns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:43:48 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:19886 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932547AbWBTLnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:43:47 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 21:04:22 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220094728.GD19293@kobayashi-maru.wspse.de> <20060220105617.GF16042@elf.ucw.cz>
In-Reply-To: <20060220105617.GF16042@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3394122.oQKnK5vIX9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602202104.26730.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3394122.oQKnK5vIX9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 20:56, Pavel Machek wrote:
> On Po 20-02-06 10:47:28, Matthias Hensler wrote:
> > On Mon, Feb 20, 2006 at 01:53:33AM +0100, Pavel Machek wrote:
> > > Only feature I can't do is "save whole pagecache"... and 14000 lines
> > > of code for _that_ is a bit too much. I could probably patch my kernel
> > > to dump pagecache to userspace, but I do not think it is worth the
> > > effort.
> >
> > I do not think that Suspend 2 needs 14000 lines for that, the core is
> > much smaller. But besides, _not_ saving the pagecache is a really _bad_
> > idea. I expect to have my system back after resume, in the same state I
> > had left it prior to suspend. I really do not like it how it is done by
> > Windows, it is just ugly to have a slowly responding system after
> > resume, because all caches and buffers are gone.
>
> That's okay, swsusp already saves configurable ammount of pagecache.

Really? How is it configured?

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3394122.oQKnK5vIX9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+aI6N0y+n1M3mo0RAusQAJ9DDx4FKt9NunDlTdKsPlUk8A4WVgCgjTmJ
+mb1P96BZe5hIXf+QvdkKKM=
=/K0u
-----END PGP SIGNATURE-----

--nextPart3394122.oQKnK5vIX9--
