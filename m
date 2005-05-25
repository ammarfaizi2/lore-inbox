Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbVEYKwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbVEYKwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 06:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVEYKwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 06:52:24 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:54212 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262140AbVEYKwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 06:52:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT patch acceptance
Date: Wed, 25 May 2005 20:51:52 +1000
User-Agent: KMail/1.8
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Sven Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       bhuey@lnxw.com, hch@infradead.org, linux-kernel@vger.kernel.org
References: <1116978244.19926.41.camel@dhcp153.mvista.com> <20050524184351.47d1a147. <20050525074633.GA18423@elte.hu>
In-Reply-To: <20050525074633.GA18423@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1842854.eT49bHCjT8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505252051.55544.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1842854.eT49bHCjT8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 25 May 2005 17:46, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > >i agree in theory, but interestingly, people who use the -RT branch do
> > >report a smoother desktop experience. While it might also be a
> > >psychological effect, under -RT an interactive X process has the same
> > >kind of latency properties as if all of the mouse pointer input and
> > >rendering was done in the kernel (like some other desktop OSs do).
> > >
> > >so in terms of mouse pointer 'smoothness', it might very well be
> > >possible for humans to detect a couple of msec delays visually - even
> > >though they are unable to notice those delays directly. (Isnt there so=
me
> > >existing research on this?)
> >
> > I'm guessing not, just because the monitor probably hasn't even
> > refreshed at that point ;) But...
>
> this reminds me, people very much notice the difference between an LCD
> that has 20 msec refresh rates vs. ones that have 10 msec refresh rates.
>
> i'd say the direct perception limit should be somewhere around 10 msec,
> but there can be indirect effects that add up. (e.g. while we might not
> be able to detect so small delays directly, the human eye can see
> _distance_ anomalies that are caused by small delays. E.g. the feeling
> of how 'smoothly' the mouse moves might be more accurate than direct
> delay perception. But i'm really out on a limb here as this is so hard
> to measure directly.)

Quite a lot outside the computing world has been done on human perception a=
nd=20
the limit of perception on what would be scheduling jitter is approximately=
=20
7ms if I recall correctly.

Cheers,
Con

--nextPart1842854.eT49bHCjT8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBClFjLZUg7+tp6mRURAhuHAJ0ZEVHj6l+9HOXUnuv8iEgYhxtd3QCfftK2
2URtgkMfcCxRSXzeFmJfRDQ=
=opUj
-----END PGP SIGNATURE-----

--nextPart1842854.eT49bHCjT8--
