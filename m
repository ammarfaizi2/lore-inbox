Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUCLTs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUCLTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:48:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262473AbUCLTrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:47:15 -0500
Date: Fri, 12 Mar 2004 20:45:58 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: unknown symbols cauased byremove-more-KERNEL_SYSCALLS.patch
Message-ID: <20040312194558.GB1039@devserv.devel.redhat.com>
References: <20040310233140.3ce99610.akpm@osdl.org> <200403121014.40889.arnd@arndb.de> <20040312012942.5fd30052.akpm@osdl.org> <200403121035.02977.arnd@arndb.de> <20040312014809.4f2b280e.akpm@osdl.org> <1079086310.4445.1.camel@laptop.fenrus.com> <20040312194236.GO14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20040312194236.GO14833@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Mar 12, 2004 at 08:42:36PM +0100, Adrian Bunk wrote:
> On Fri, Mar 12, 2004 at 11:11:50AM +0100, Arjan van de Ven wrote:
> > On Fri, 2004-03-12 at 10:48, Andrew Morton wrote:
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > But then the removal of KERNEL_SYSCALLS becomes hostage to those drivers,
> > > and nobody is working on them.   It'll never happen.
> > 
> > CONFIG_BROKEN ??
> 
> These are working drivers, and it's a stable kernel series...

for some value of working... 
I mean, I'm not convinced the code is actually secure
(what if the fd they use is shared via a thread and userland is mucking
about with that fd to do funky stuff ???) 
--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAUhN1xULwo51rQBIRAnGDAKCbxUsRWpgeg2FWwEejJSrbc5DVIwCghSHn
Okd29u09ortOw/pNJuOfXt4=
=y00p
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
