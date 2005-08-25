Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbVHYXVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbVHYXVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVHYXVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:21:48 -0400
Received: from sipsolutions.net ([66.160.135.76]:25357 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S965005AbVHYXVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:21:48 -0400
Subject: Re: Inotify problem [was Re: 2.6.13-rc6-mm1]
From: Johannes Berg <johannes@sipsolutions.net>
To: george@mvista.com
Cc: John McCutchan <ttb@tentacle.dhs.org>, Robert Love <rml@novell.com>,
       jim.houston@ccur.com, Reuben Farrelly <reuben-lkml@reub.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <430E4FE9.6000607@mvista.com>
References: <fa.h7s290f.i6qp37@ifi.uio.no> <fa.e1uvbs1.l407h7@ifi.uio.no>
	 <430D986E.30209@reub.net>  <1124976814.5039.4.camel@vertex>
	 <1124983117.6810.198.camel@betsy>  <430E13D8.8070005@mvista.com>
	 <1124996687.16219.3.camel@vertex>  <430E4FE9.6000607@mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H8fNN+Y8Bwt4jJw8Qxqx"
Date: Fri, 26 Aug 2005 01:20:43 +0200
Message-Id: <1125012043.6366.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H8fNN+Y8Bwt4jJw8Qxqx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-08-25 at 16:10 -0700, George Anzinger wrote:

> That IS strange.  1024 is on a "level" boundry, but then next level is=20
> 2**15, not 2**11.  I will take a look.

Remember that the level is never filled, so maybe the smallest level
just gets an offset or something? Well, you're the expert I suppose, so
apologies if this didn't make sense. Just crossed my mind :)

johannes

--=-H8fNN+Y8Bwt4jJw8Qxqx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQw5SSaVg1VMiehFYAQIj/xAAlfJQo1vBFr6FRQhBhPgTXSaklbMFOtwG
lo9mqsoQWUCLCXDLtjkzADPwRUv7CnJQttDlSqyTKyyTGSWrE0PYGYpPuZ9NxaiP
68VITQAc7mMJFa8pU9CymldKjyDcmYJE2fclg+MCS0F1ThQcpKvocWxa2yrmtSXL
svJ1/P1y5nMqbbldjErQxtIVLvdgn6rgkotwcoeh6zREE8ividWZixTikqgDMXAP
wcGR9Pewkvl4EwPqQjwNo8TjHCt3JuFYcqy2b1clE0/cRrgLd9C45lza52od3CJ8
LvmFSH5CIy0upP0dOKpbslxEUDDR1mkP8ALateDpwKCJCIcE57HE5QiLeiS0PBiD
lVc88MPVLWOocIXFIWw30L/KQ3wUiTDqyTAexE2LPEKqAwMFdHa0IkPlGm37Miz7
F7d06UYt+OXz7C1JpWIBUeU9kCa3TOb7cfGlXKr1zmkQCvHntrLTNtNKOaumJN6s
uBEwdvQCT2hULewMbtdONCOsY9gYOVU+qIcEO+opfHFXgc38EYg2ChFN9+2GQf0m
Ym/Gb+j+YG/Pn5X30h2dyLjpjPIbJcuaElfBoiR3tpxf0Vek22H0dbT99caXTPTf
hr2+c+gIrw2INhCJjJuN8ceqzFyCyfojBHAlLjnaUIbbWwaHvfBC1MRXI5s25lbm
Bnf3hGzFQ9w=
=LFCJ
-----END PGP SIGNATURE-----

--=-H8fNN+Y8Bwt4jJw8Qxqx--

