Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWBIWoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWBIWoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWBIWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:44:21 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:713 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750718AbWBIWoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:44:20 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 9 Feb 2006 19:26:32 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091245.34833.nigel@suspend2.net> <20060209092555.GB2940@elf.ucw.cz>
In-Reply-To: <20060209092555.GB2940@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2283945.RahpscytAx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602091926.38666.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2283945.RahpscytAx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 09 February 2006 19:25, Pavel Machek wrote:
> Good morning ;-).
>
> > > At one point you said you'd like to work with us, and earlier in the
> > > threads you stated that porting suspend2 to userland should be easy.
> > >
> > > [I do not think that putting suspend2 into git is useful thing to
> > > do. Of course, it is your option; but it seems to me that people
> > > likely to use suspend2 are not the kind of people that use git.]
> > >
> > > It would be very helpful if you could install uswsusp, then try to
> > > make suspend2 run in userland on top of uswsusp interface. Not
> > > everything will be possible that way, but it most of features should
> > > be doable that way. I'd hate to code yet another splashscreen code,
> > > for example...
> >
> > I've begun briefly to have a look at this.
> >
> > Part of the problem I have, both with doing incremental patches for
> > swsusp and with doing a userspace version, is that some of the
> > fundamentals are redesigned in suspend2. The most important of these is
> > that we store the metadata in bitmaps (for pageflags) and extents (for
> > storage) instead of pbes. Do you have thoughts on how to overcome that
> > issue? Are you willing, for example, to do work on switching swsusp to
> > use a different method of storing its data?
>
> Any changes to userspace are a fair game. OTOH kernel provides linear
> image to be saved to userspace, and what it uses internally should not
> be important to userland parts. (And Rafael did some changes in that
> area to make it more effective, IIRC).

What about providing the possibility of using the 2 pagesets I use at the=20
moment? I'm not suggesting it should be compulsory, but perhaps an ioctl to=
=20
say "I want to save a Suspend2 style image"?

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2283945.RahpscytAx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6wrON0y+n1M3mo0RAl8PAJwLGd1wMOBbZbO85nSYmxhHU3SluQCg3rQG
Beo9hAhiSqmGjAC7OBctdTQ=
=dTcl
-----END PGP SIGNATURE-----

--nextPart2283945.RahpscytAx--
