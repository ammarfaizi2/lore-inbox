Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUFJSJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUFJSJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUFJSJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:09:34 -0400
Received: from ppp54-ax.noc.teithe.gr ([195.251.120.54]:16256 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S261851AbUFJSJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:09:32 -0400
From: Stefanos Harhalakis <v13@priest.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Date: Thu, 10 Jun 2004 21:07:47 +0300
User-Agent: KMail/1.6.52
Cc: Robert White <rwhite@casabyte.com>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Mike McCormack'" <mike@codeweavers.com>, linux-kernel@vger.kernel.org
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAWUyJbbFwtUuY/ZGbgGI8TwEAAAAA@casabyte.com> <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.56.0406091911340.26677@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5NKyAsO9f+4FU9e"
Content-Transfer-Encoding: 7bit
Message-Id: <200406102107.53776.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-02=_5NKyAsO9f+4FU9e
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 09 June 2004 20:14, Jesper Juhl wrote:
> On Tue, 8 Jun 2004, Robert White wrote:
> > I would think that having an easy call to disable the NX modification
> > would be both safe and effective.  That is, adding a syscall (or
> > whatever) that would let you mark your heap and/or stack executable while
> > leaving the new default as NX, is "just as safe" as flagging the
> > executable in the first place.
>
> Just having the abillity to turn protection off opens the door. If it is
> possible to turn it off then a way will be found to do it - either via
> buggy kernel code or otherwhise. Only safe approach is to have it
> enabled by default and not be able to turn it off IMHO.

What about turning it on and don't be able to turn it off again?

> Jesper Juhl <juhl-lkml@dif.dk>
<<V13>>

--Boundary-02=_5NKyAsO9f+4FU9e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAyKN5VEjwdyuhmSoRAqM/AJ0cSIff3VeSwOr9KqeFNU8oPceMeACcDZQ+
uKN642U36N9fG/ENTtbXh9s=
=lpZ/
-----END PGP SIGNATURE-----

--Boundary-02=_5NKyAsO9f+4FU9e--
