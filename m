Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWIOSZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWIOSZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWIOSZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:25:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6832 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932124AbWIOSZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:25:02 -0400
Date: Fri, 15 Sep 2006 14:24:28 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: karim@opersys.com, Roman Zippel <zippel@linux-m68k.org>,
       Tim Bird <tim.bird@am.sony.com>, Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915182428.GI4577@redhat.com>
References: <Pine.LNX.4.64.0609151339190.6761@scrub.home> <1158323938.29932.23.camel@localhost.localdomain> <Pine.LNX.4.64.0609151425180.6761@scrub.home> <1158327696.29932.29.camel@localhost.localdomain> <Pine.LNX.4.64.0609151523050.6761@scrub.home> <1158331277.29932.66.camel@localhost.localdomain> <450ABA2A.9060406@opersys.com> <1158332324.29932.82.camel@localhost.localdomain> <y0mmz91f46q.fsf@ton.toronto.redhat.com> <1158345108.29932.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <1158345108.29932.120.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

On Fri, Sep 15, 2006 at 07:31:48PM +0100, Alan Cox wrote:

> Ar Gwe, 2006-09-15 am 13:08 -0400, ysgrifennodd Frank Ch. Eigler:
Yeah, or something. :-)

> > Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> > - where 1000-cycle int3-dispatching overheads too high
>=20
> Why are your despatching overheads 1000 cycles ? (and if its due to int3
> why are you using int 3 8))

Smart teams from IBM and Hitachi have been hammering away at this code
for a year or two now, and yet (roughly) here we are.  There have been
experiments involving plopping branches instead of int3's at probe
locations, but this is self-modifying code involving multiple
instructions, and appears to be tricky on SMP/preempt boxes.

- FChE

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFCu/cVZbdDOm/ZT0RAjCcAJ9YUWyw2EKQj0lPiE/PeIzPYLt2owCcDRO7
bDRstmo9RrHGBkvnyk8x0HU=
=QuLZ
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
