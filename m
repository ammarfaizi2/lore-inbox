Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUFHGDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUFHGDs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUFHGDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:03:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55757 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264843AbUFHGDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:03:47 -0400
Date: Tue, 8 Jun 2004 08:01:30 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Russell Leighton <russ@elegant-software.com>
Cc: davidm@hpl.hp.com, Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid() bug in 2.6?]
Message-ID: <20040608060129.GD31155@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <40C32A44.6050101@elegant-software.com> <40C33A84.4060405@elegant-software.com> <1086537490.3041.2.camel@laptop.fenrus.com> <40C3AD9E.9070909@elegant-software.com> <20040607121300.GB9835@devserv.devel.redhat.com> <6uu0xn5vio.fsf@zork.zork.net> <20040607140009.GA21480@infradead.org> <16580.46864.290708.33518@napali.hpl.hp.com> <40C4F40A.8060205@elegant-software.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <40C4F40A.8060205@elegant-software.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 07, 2004 at 07:02:34PM -0400, Russell Leighton wrote:
> >
> So Ia64 does have it..that's good. Does glibc wrap it?
> 
> I agree with the above...could glibc's clone() should have a size added? 
> Then the arch specific stack issues
> could be hidden.

glibc doesn't provide clone other than a raw syscall wrapper, under the
assumption that when you want threads, you'll use it's thread creation call.
Not too unfair imo.

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAxVY5xULwo51rQBIRAl5WAKCDC5EUfNtgVIS6oLZvtbw7nMABEwCeLqZo
1ybUdFMs1/EhwNgZprO4q0Q=
=G9s9
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
