Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267599AbUHTSzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267599AbUHTSzC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUHTSwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:52:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23518 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267599AbUHTSuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:50:02 -0400
Date: Fri, 20 Aug 2004 20:49:33 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vherva@viasys.com, petr@vandrovec.name, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820184932.GA11789@devserv.devel.redhat.com>
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20040820114518.49a65b69.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 20, 2004 at 11:45:18AM -0700, Andrew Morton wrote:
> >  > I just put get_user_pages-handle-VM_IO.patch back and reverted
> >  > dev-mem-restriction-patch.patch - I'll report back when it has compiled. 
> > 
> >  Ok, 2.6.8.1-mm2 minus dev-mem-restriction-patch.patch fixes the "cannot
> >  allocate memory" problem. 
> 
> Thanks for working that out.
> 
> Strange.  I'd have assumed that the Fedora kernels include that patch.

we do. Maybe you have an older (rare) vmware version ???

question is wtf vmware is doing with that memory.. it's outside the bios
area after all.... petr?




--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBJke8xULwo51rQBIRAo3/AKCDJQVhovh6VUwjJbPULeHKvjiFqACdGj3i
TTe9giaPyE+ZO6dF9hjE/T4=
=E5TX
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
