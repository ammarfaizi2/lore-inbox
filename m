Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUI1Too@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUI1Too (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267713AbUI1Too
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:44:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54441 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267749AbUI1ToI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:44:08 -0400
Date: Tue, 28 Sep 2004 21:43:51 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: heap-stack-gap for 2.6
Message-ID: <20040928194351.GC5037@devserv.devel.redhat.com>
References: <20040925162252.GN3309@dualathlon.random> <1096272553.6572.3.camel@laptop.fenrus.com> <20040927130919.GE28865@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20040927130919.GE28865@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 27, 2004 at 03:09:19PM +0200, Andrea Arcangeli wrote:
> > which "those apps" ?
> 
> those apps that wants to allocate as close as possible to the stack.
> They're already using /proc/self/mapped_base, the gap of topdown isn't
> configurable.

/proc/self/mmaped_base doesn't exist...

 
> Also topdown may screwup some MAP_FIXED usage below the 1G mark, no?

no

map_fixed is map_fixed... if you give a hint the kernel will try that of
course.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWb72xULwo51rQBIRAoCcAJ9R7eZE8gk6uxYJkQXT0JbZRLO/mACfb6lg
nVWyM3RhpJmmQmHx/PvBC8U=
=3yqh
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
