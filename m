Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUFCGYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUFCGYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFCGYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:24:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13486 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261186AbUFCGYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:24:30 -0400
Date: Thu, 3 Jun 2004 08:24:12 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603062412.GC19637@devserv.devel.redhat.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040602211714.GB29687@devserv.devel.redhat.com> <20040603011253.GD5953@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20040603011253.GD5953@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 02, 2004 at 06:12:53PM -0700, Joel Becker wrote:
> On Wed, Jun 02, 2004 at 11:17:14PM +0200, Arjan van de Ven wrote:
> > On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> > > Just out of interest - how many legacy apps are broken by this? I assume 
> > > it's a non-zero number, but wouldn't mind to be happily surprised.
> > 
> > based on execshield in FC1.. about zero.
> 
> 	Doesn't Sun's JDK break here?

nope.
It broke with 4g/4g because it thought pointers in the upper 1Gb of address
space were errors, but it doesn't break with execshield.

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAvsQLxULwo51rQBIRAo9SAKCQ0g/5FNBRvAPxSVsD6UPrCUiMxgCfSc7w
tpod/8EAjFDGVUHhZQygWHs=
=cSc7
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
