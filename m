Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSEFAFy>; Sun, 5 May 2002 20:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313914AbSEFAFx>; Sun, 5 May 2002 20:05:53 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:38219
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313907AbSEFAFw>; Sun, 5 May 2002 20:05:52 -0400
Date: Sun, 5 May 2002 16:51:02 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020505235101.GA5060@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200205051149.g45BnGX13620@Port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.33.0205051027460.8663-100000@shell1.aracnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux darklands 2.4.19-pre7-aa2-gr
X-Operating-Status: 02:50:22 up 18:15,  4 users,  load average: 0.11, 0.14, 0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05-May 11:10, M. Edward (Ed) Borasky wrote:
> On Sun, 5 May 2002, Denis Vlasenko wrote:
>=20
[snip]=20
> As you can probably guess, this sort of thing is one of the issues that
> my "COUGAR" proposal corrects. I leave design issues to the designers,
> but one thing I insist on is that there *be* requirements --
> *documented* requirements -- and a *documented* and debated design
> *before* hacking the code into the kernel and making implementation
> decisions.

=2E..and here is where you sliped the track. Linux is designed by those
who post patches and lobby for thier use. If something doesn't work for
you post *patches* that fix it. Complaints that you don't have time to
work around current code gets you nothing.=20

As far as I can see, the reason that staticis now live in=20
/proc/partitions is that there was code _submitted_ (the sar patches)=20
to collect the staticis. If you have a better patch I, for one, would=20
love to see it. I don't think IO statistics shareing /proc/partitons=20
is great *design* but it was thought it would break the least tools=20
out there.=20
>=20
> Of course, since I would be the designer of at least part of "COUGAR", I
> would be making some of those decisions. Unfortunately, I have limited
> time to work on "COUGAR" until maybe late July, so if someone wants to
> pick up some of the balls and run with them, I'm willing to unload them.
> (Apologies if my metaphor jars those of you who live where football is
> played without the use of hands :).
>=20
> This is a process I highly recommend for performance-determining parts
> of Linux, like memory management and the scheduler. I know the memory
> management and scheduler gurus -- Rik, Andrea, Ingo and others -- *have*
> designs in their heads, *have* requirements that they're working to -- I
> just think we should be sharing and debating *those* on the list instead
> of just code and benchmark results.

Everyone loves the debate, but if no code is ever show all we get out of
it _is_ the debate. How many times has this happened on this subject
(widely taken as the /proc/* debate)? I've seen lots of hot air, but
little code.

Just my take,
Thomas Zimmerman

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81cVlUHPW3p9PurIRAm3xAJ4/1IxvrkES+QTYrvnNPn9DOIEp+QCfRWYa
/WVTJdfD3Q87gSL5pVUA0mI=
=Uz/R
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
