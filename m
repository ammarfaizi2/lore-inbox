Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUIJHVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUIJHVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIJHVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:21:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63931 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264531AbUIJHVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:21:32 -0400
Date: Fri, 10 Sep 2004 09:21:21 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910072121.GE11140@devserv.devel.redhat.com>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <20040910064519.GA4232@taniwha.stupidest.org> <20040910065213.GA11140@devserv.devel.redhat.com> <20040910071530.GB4480@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <20040910071530.GB4480@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2004 at 12:15:30AM -0700, Chris Wedgwood wrote:
> > 
> > 8K stacks  ->  dual 4k/8k option -> 4k stacks
> 
> URL?
> 
> 
> also, why 4K and not 8K or 2K?  

it used to be 8K unified for user context and softirq context and hardirq
context. Basically that got "split up" into 4k for user and 4k each for the
irq contexts.


--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQVXwxULwo51rQBIRAn0RAJ9xkLiOqD7Qmd3VIooQvah181Jd6ACfZ1ok
TMVMSZgwQrM19K/LZfyoC1I=
=jP5p
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
