Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUCAOjD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 09:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUCAOjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 09:39:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39816 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261300AbUCAOis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 09:38:48 -0500
Date: Mon, 1 Mar 2004 15:38:42 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Michael Frank <mhf@linuxmail.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Micha Feigin <michf@post.tau.ac.il>,
       Software suspend <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] Re: Dropping CONFIG_PM_DISK?
Message-ID: <20040301143841.GA21305@devserv.devel.redhat.com>
References: <yw1x4qt93i6y.fsf@kth.se> <opr348q7yi4evsfm@smtp.pacific.net.th> <20040229213302.GA23719@luna.mooo.com> <opr35wvvrw4evsfm@smtp.pacific.net.th> <1078139361.21578.65.camel@gaston> <opr36ljbsu4evsfm@smtp.pacific.net.th> <1078141191.28288.83.camel@gaston> <opr36ojxik4evsfm@smtp.pacific.net.th> <1078148843.4443.2.camel@laptop.fenrus.com> <opr36tehrr4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <opr36tehrr4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2004 at 10:33:43PM +0800, Michael Frank wrote:
> On Mon, 01 Mar 2004 14:47:23 +0100, Arjan van de Ven <arjanv@redhat.com> 
> wrote:
> 
> >
> >>Then one could just drop in a driver from 2.4 and use it.
> >>
> >>People having time to make new "pretty" drivers could
> >>also use this facility for cross checking.
> >
> >I'm sorry but this is a load of bull ;)
> 
> Thank you, I do fully concur with you from an ideal scientific perspective
> where resources are not constrained. Applying the same perspective I might
> like to craft lots of drivers in assembler or even reinvent whatever...,
> but I do not live an ideal world.

I do not live an ideal world, However I do live in a practical world of
having to put distribution kernels together. 
> 
> >New kernel revisions come with a new API. If we keep the old one around
> >forever that achieves two things
> >1) The kernel bloats up
> 
> By a few %, only when old API is used, the benefits far outweighs the cost.

Ehm no. You entirely forget the cost where the new API and old API need to
work together, which is a significant complexity explosion. When linux grows
a new API that touches so many drivers, there's a good reason for that, eg
the API improves something or makes something possible.
Making powermanagement work is hard, even with 1 API to worry about. With 2
interfering API's it becomes outright impossible and untrackable. 
That's not a scientific perspective, that's a practical perspective where
the scientific theory maybe says you can have 2 parallel api's that never
interact ;)

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAQ0roxULwo51rQBIRAn1OAJ9wIHIWyi/jThQxVJHDV9XUZ/e2uwCggtA/
RFHYSjd1a161luo+uer4qs4=
=EMET
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
