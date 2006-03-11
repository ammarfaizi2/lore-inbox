Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWCKMtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWCKMtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWCKMtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:49:17 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:58033 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751433AbWCKMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:49:16 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Subject: Re: Faster resuming of suspend technology.
Date: Sat, 11 Mar 2006 22:46:42 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200603111722.05341.ncunningham@cyclades.com> <200603111217.AA00804@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
In-Reply-To: <200603111217.AA00804@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7992321.3ycRaWJRKI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603112246.47596.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7992321.3ycRaWJRKI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 11 March 2006 22:17, Jun OKAJIMA wrote:
> >My version doesn't have this problem by default, because it saves a full
> > image of memory unless the user explicitly sets a (soft) upper limit on
> > the image size. The image is stored as contiguously as available storage
> > allows, so rereading it quickly isn't so much of an issue (and far less
> > of an issue than discarding the memory before suspending and faulting it
> > back in from all over the place afterwards).
>
> Yes, right. In your way, there is no thrashing. but it slows booting.
> I mean, there is a trade-off between booting and after booted.
> But, what people would want is always both, not either.

I don't understand what you're saying. In particular, I'm not sure why/how =
you=20
think suspend functionality slows booting or what the tradeoff is "between=
=20
booting and after booted".

> Especially, your way has problem if you boot( resume ) not from HDD
> but for example, from NFS server or CD-R or even from Internet.

Resuming from the internet? Scary. Anyway, I hope I'll understand better wh=
at=20
you're getting at after your next reply.

> >That said, work has already been done along the lines that you're
> > describing. You might, for example, look at the OLS papers from last
> > year. There was a paper there describing work on almost exactly what
> > you're describing.
>
> Could I have URL or title of the paper?

http://www.linuxsymposium.org/2005/. I don't recall the title now, sorry, a=
nd=20
can't tell you whether it's in volume 1 or 2 of the proceedings, but I'm su=
re=20
it will stick out like a sore thumb.

Regards,

Nigel

--nextPart7992321.3ycRaWJRKI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEEsa3N0y+n1M3mo0RAoJ4AKCWoUZRpmOv2pniRpRAfor8GmJBLwCcDy4K
WDbQ8jlalW8fN6Uvb4Di15k=
=X9R+
-----END PGP SIGNATURE-----

--nextPart7992321.3ycRaWJRKI--
