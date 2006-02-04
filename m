Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945967AbWBDJ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945967AbWBDJ5s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 04:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945993AbWBDJ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 04:57:48 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:17544 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1945967AbWBDJ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 04:57:47 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Sat, 4 Feb 2006 19:54:18 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041120.59830.nigel@suspend2.net> <20060204090112.GJ3291@elf.ucw.cz>
In-Reply-To: <20060204090112.GJ3291@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10778138.PrVhlJYjQD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602041954.22484.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10778138.PrVhlJYjQD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 04 February 2006 19:01, Pavel Machek wrote:
> On So 04-02-06 11:20:54, Nigel Cunningham wrote:
> > Hi Pavel.
> >
> > On Friday 03 February 2006 21:44, Pavel Machek wrote:
> > > [Pavel is willing to take patches, as his cooperation with Rafael
> > > shows, but is scared by both big patches and series of 10 small
> > > patches he does not understand. He likes patches removing code.]
> >
> > Assuming you're refering to the patches that started this thread, what
> > don't you understand? I'm more than happy to explain.
>
> For "suspend2: modules support", it is pretty clear that I do not need
> or want that complexity. But for "refrigerator improvements", I did

=2E.. and yet you're perfectly happy to add the complexity of sticking half=
=20
the code in userspace. I don't think I'll ever dare to try to understand=20
you, Pavel :)

> not understand which parts are neccessary because of suspend2
> vs. swsusp differences, and if there is simpler way towards the same
> goal. (And thanks for a stress hint...)

I think virtually everything is relevant to you. A couple of possible=20
exceptions might be (1) freezing bdevs, because you don't care so much=20
about making xfs really sync and really stop it's activity and (2) the=20
ability to thaw kernel space without thawing userspace. I want this for=20
eating memory, to avoid deadlocking against kjournald etc. I haven't=20
checked carefully as to why you don't need it in vanilla.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart10778138.PrVhlJYjQD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD5HnON0y+n1M3mo0RAlmSAJ9T3VqjyTqHQMxnTRqVwEF8SiWtUQCg77R5
XQHyodcQ+UpkGUK46KG+eO4=
=LUXd
-----END PGP SIGNATURE-----

--nextPart10778138.PrVhlJYjQD--
