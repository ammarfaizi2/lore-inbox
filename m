Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUIJHix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUIJHix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUIJHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:38:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60868 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263664AbUIJHf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:35:28 -0400
Date: Fri, 10 Sep 2004 09:35:07 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910073507.GF11140@devserv.devel.redhat.com>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <20040910064519.GA4232@taniwha.stupidest.org> <20040910065213.GA11140@devserv.devel.redhat.com> <20040910071530.GB4480@taniwha.stupidest.org> <20040910072121.GE11140@devserv.devel.redhat.com> <20040910072328.GB4606@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <20040910072328.GB4606@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 10, 2004 at 12:23:28AM -0700, Chris Wedgwood wrote:
> On Fri, Sep 10, 2004 at 09:21:21AM +0200, Arjan van de Ven wrote:
> 
> > it used to be 8K unified for user context and softirq context and
> > hardirq context. Basically that got "split up" into 4k for user and
> > 4k each for the irq contexts.
> 
> you didn't answer my second question and that's not really an answer
> of why 4K is the 'right' value

because in 2.4 user context already only had 4Kb.  That makes it a basically
unchanged value.
(yes 2.4 had a 8k total but aobut 1.6k went to the task struct, and
somewhere about 2 and 3 Kb are used by irqs leaving a bit under 4Kb for user
context)

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQVkqxULwo51rQBIRAmNTAKCITAvUxME9dhSEdtaM7FxsMT2/VACdFBQA
jDAWmWro/iLq2l7jD/fO/t4=
=jxeZ
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
