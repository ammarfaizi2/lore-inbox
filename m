Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWBTLqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWBTLqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 06:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWBTLqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 06:46:39 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:26286 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964878AbWBTLqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 06:46:34 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 20:37:27 +1000
User-Agent: KMail/1.9.1
Cc: Matthias Hensler <matthias@wspse.de>, Pavel Machek <pavel@suse.cz>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140429758.3429.1.camel@mindpipe>
In-Reply-To: <1140429758.3429.1.camel@mindpipe>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2390906.JGPJCR8oJz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602202037.31707.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2390906.JGPJCR8oJz
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 20 February 2006 20:02, Lee Revell wrote:
> On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > > It is slightly slower,
> >
> > Sorry, but that is just unacceptable.
>
> Um... suspend2 puts extra tests into really hot paths like fork(), which
> is equally unacceptable to many people.

It doesn't.

=46ork is only a 'really hot path' if you have a fork bomb running. The=20
scheduler is a really hot path (which Suspend2 patches don't touch, by the=
=20
way).

The change in the page allocation routine follows a comment saying "This is=
=20
the last chance, in general, before the goto nopage." It adds one further=20
test to the four already done at that point.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2390906.JGPJCR8oJz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD+ZvrN0y+n1M3mo0RAlDEAKCXBWIQsoCLUZna+FbkORWbfQ41QgCg5fj7
Iu+QKO2c8KWiGL8EkalBdoI=
=A4nQ
-----END PGP SIGNATURE-----

--nextPart2390906.JGPJCR8oJz--
