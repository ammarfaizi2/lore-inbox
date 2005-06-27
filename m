Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVF0Ovd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVF0Ovd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVF0OuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:50:07 -0400
Received: from nysv.org ([213.157.66.145]:12172 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262164AbVF0M4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:56:08 -0400
Date: Mon, 27 Jun 2005 15:55:55 +0300
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Reiser <reiser@namesys.com>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050627125555.GE11013@nysv.org>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl> <42BB31E9.50805@slaphack.com> <1119570225.18655.75.camel@localhost.localdomain> <42BB5E1A.70903@namesys.com> <1119609680.17066.81.camel@localhost.localdomain> <20050627091808.GC11013@nysv.org> <42BFCAE7.6070708@yahoo.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMTfqzsZeEKgETVO"
Content-Disposition: inline
In-Reply-To: <42BFCAE7.6070708@yahoo.com.au>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TMTfqzsZeEKgETVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2005 at 07:46:15PM +1000, Nick Piggin wrote:
>
>The scheduler is being improved for better behaviour on complex
>topologies like multi core + NUMA and multi level NUMA systems.
>If Con's work had gone in first, then conversely these improvements
>would have had to wait.

Or be merged in later.

The problem is, why do the interfaces have to live so much that
examples like this come to my ears (or eyes ;) all the time?

I hate to say this without digging out any URLs, but one friend
of mine says he has a very hard time doing any networking code
because it's too labile. Maybe that's being embettered for something
else too?

Or the other friend who curses that the networking code is just
crap and basically has to rewrite the code to get it working.
Yes, I've tried to get these guys to submit their code, but they
argue back that no one wants to see it.

>>There's also my all-time favorite, http://lkml.org/lkml/2005/3/14/4
>
>What's wrong with that? The slowdown is due to the workload
>becoming disk bound. The reasons are still not entirely clear,
>but I don't think it is a recent (ie. 2.6) regression (or even
>a regression at all IIRC).

It's not that easy.

So let's say the scheduler slowdown is a temporary situation to
adapt it to multicore+NUMA.
I assume that's what you mean, by having the kernels on par
with 2.6.10 and the above paragraph.

Why on earth did the slowdown ever get merged and we have to wait
for it to be on par with some older version?

Maybe the multicore+NUMA guys don't think it's a regression, hell,
it may be better for them at the cost of the embedded (or desktop
or whoever) guys.

Still my initial reaction is "if a patch slows things down, revert
it. If it didn't do anything, keep reverting until you have the
original situation."
It's also my reaction after the initial one :)

Sure, 2.4 and others did also have issues, so you couldn't automatically
assume each and every new kernel would be better than the last,
but it seems nowadays it's also hard to predict even the trend.

But to be fair, Linux is not a disaster yet and you guys are doing
good work, despite things looking very shaky at times and
my temper being more and more easily flared nowadays at signs
of trouble :)

>I think if you are resorting to bringing up all time favourite
>blunders when trying to justify Reiser4 being included, then
>that is a sign right there that something is fundamentally wrong
>(if not with the code, then with your line of thought0

Myeah, I know, this is not helping the Reiser4 cause _as_such_.

What I'm saying is, Reiser4 could be merged as it looks like a
lot of other stuff is merged too, which may not be very
tested.

Reiser4 at least is tested.

We can skip the parts that appear to suck.

>And note my email has nothing to do with any *real* argument for
>or against R4.

I think this could be further split into an argument about
the development model :P

Having a separate dev tree would keep the majority happy,
as things are "good enough for most people" and after all
has been evened out in the dev tree, a new stable tree can
be launched.

This particular new file system should not be too drastic a
thing to merge into a stable kernel, without the instability-
inducing factors, and I think in the old model, all this would
have been fleshed out in the dev tree automagically.

Please do correct me if I'm wrong :)

Thanks!

--=20
mjt


--TMTfqzsZeEKgETVO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCv/dbIqNMpVm8OhwRAlaUAJ4hscxhPYTQPVMMae6znUpjn+mZ/QCfema0
VXRq3jMHxypG1S7LE44JiWY=
=e4+u
-----END PGP SIGNATURE-----

--TMTfqzsZeEKgETVO--
