Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266558AbUG2HzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUG2HzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 03:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267191AbUG2HzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 03:55:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9695 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266558AbUG2HzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 03:55:16 -0400
Date: Thu, 29 Jul 2004 09:54:29 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Chris Caputo <ccaputo@alt.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
Message-ID: <20040729075429.GA15700@devserv.devel.redhat.com>
References: <20040729002535.GA5145@logos.cnet> <Pine.LNX.4.44.0407282325460.30510-100000@nacho.alt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407282325460.30510-100000@nacho.alt.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 28, 2004 at 11:27:41PM -0700, Chris Caputo wrote:
> On Wed, 28 Jul 2004, Marcelo Tosatti wrote:
> > Changing the affinity writes new values to the IOAPIC registers, I can't see
> > how that could interfere with the atomicity of a spinlock operation. I dont
> > understand why you think irqbalance could affect anything.
> 
> Because when I stop running irqbalance the crashes no longer happen.

what is the irq distribution when you do that?
Can you run irqbalance for a bit to make sure there's a static distribution
of irq's and then disable it and see if it survives ?

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBCK01xULwo51rQBIRAiATAKCYFz29MmIgcc4JbL6WuegQ5JrCzgCgqeP+
vguwGF1sYuQw9lbMNL9xrKE=
=Rcqz
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
