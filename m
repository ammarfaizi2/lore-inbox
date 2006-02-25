Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWBYAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWBYAZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWBYAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:25:39 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:17354 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964822AbWBYAZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:25:38 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 25 Feb 2006 10:22:34 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602250911.54850.ncunningham@cyclades.com> <20060224235321.GA1930@elf.ucw.cz>
In-Reply-To: <20060224235321.GA1930@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4409633.xDxhJMVj7r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602251022.43453.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4409633.xDxhJMVj7r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Saturday 25 February 2006 09:53, Pavel Machek wrote:
> Hi!
>
> > > > 2) shrink_all_memory() should be fixed. It should not really return
> > > > if there are more pages freeable.
> > >
> > > Well, that would be a long-run solution.  However, until it's fixed we
> > > can use a workaround IMHO. ;-)
> >
> > Isn't trying to free as much memory as you can the wrong solution anyway?
> > I mean, that only means that the poor system has more pages to fault back
> > in at resume time, before the user can even begin to think about doing
> > anything useful. You might be able to say "Every machine that suspend2
> > works on, swsusp works on", but the later will be a pretty sad definition
> > of works!
>
> We are trying to catch a bug here. suspend2 or not, it is a bug and it
> should be fixed (or at least understood).
>
> [Also please try to tone down your messages. Your suspend2 may be more
> user-friendly, you do not want to start that flamewar again, do you?
> Saying "don't bother fixing that" is not nice thing to do.]

What's the bug?

Regards,

Nigel

--nextPart4409633.xDxhJMVj7r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/6NTN0y+n1M3mo0RAkI5AKDuNbcnbUZSHzW14pzJWoZOg7DwCgCgv9Kq
j2SSspx5OCtb1zprkS7WiG8=
=7QPa
-----END PGP SIGNATURE-----

--nextPart4409633.xDxhJMVj7r--
