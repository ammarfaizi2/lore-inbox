Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269048AbUIRAIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269048AbUIRAIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUIRAIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 20:08:11 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:41869 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269048AbUIRAIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 20:08:07 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Fri, 17 Sep 2004 17:07:57 -0700
User-Agent: KMail/1.7
Cc: andrea@novell.com, stelian@popies.net, hugh@veritas.com,
       bruce@andrew.cmu.edu, linux-kernel@vger.kernel.org
References: <20040917154834.GA3180@crusoe.alcove-fr> <200409171514.38316.ryan@spitfire.gotdns.org> <20040917153526.26cc4084.akpm@osdl.org>
In-Reply-To: <20040917153526.26cc4084.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1799397.km9fFVmYiS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409171708.00641.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1799397.km9fFVmYiS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 September 2004 15:35, Andrew Morton wrote:
> Ryan Cumming <ryan@spitfire.gotdns.org> wrote:
> > How does this look?
> >
> >  ...
> > +static inline unsigned long __attribute_pure__ roundup_pow_of_two(int =
x)
> > +{
> > + return (1UL << fls(x));
> > +}
>
> Any reason for making the argument an integer, rather than unsigned long?

I originally had it as unsigned long, but I changed it to match what fls()=
=20
takes. Would it be better as an unsigned long despite that?

=2DRyan

--nextPart1799397.km9fFVmYiS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBS3xgW4yVCW5p+qYRAiKSAKChjuluVhM//qMdVnwnGSMlYU4l3ACdHU+b
Ynok08K4G7D0WXNCkwAwEcU=
=iqpJ
-----END PGP SIGNATURE-----

--nextPart1799397.km9fFVmYiS--
