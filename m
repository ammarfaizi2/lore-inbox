Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUG3QyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUG3QyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267743AbUG3QyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:54:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17545 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267737AbUG3Qwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:52:35 -0400
Date: Fri, 30 Jul 2004 18:51:53 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: symlinks follow 8 or 5?
Message-ID: <20040730165151.GA11967@devserv.devel.redhat.com>
References: <1091079278.1999.5.camel@localhost.localdomain> <slrn-0.9.7.4-22364-14114-200407301259-tc@hexane.ssi.swin.edu.au> <1091171770.2794.4.camel@laptop.fenrus.com> <410A7A86.6030206@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <410A7A86.6030206@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 30, 2004 at 09:42:46AM -0700, Ulrich Drepper wrote:
> Arjan van de Ven wrote:
> 
> > you haven't been paying attention.... the current 2.6 kernels have a
> > patch series that is fixing this for most filesystems already 
> 
> Which reminds me: how can we safely determine whether this is
> implemented for a local filesystem from userland?  Unless we can do I
> cannot change the value of SYMLOOP_MAX and people will not be able to
> take advantage of the raised limit safely.

well actually it can't be per userland; it's just that we're almost at the
point where all filesystems are switched to the new infrastructure so that
the global constant can be bumped to 8 again...

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBCnymxULwo51rQBIRAvo8AJ9U0EPn5Mr4BESeiev8nm68z94wFgCfSxUg
l6ypsVcMniSntc+KhcMvZoQ=
=5XPy
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
