Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUIJF60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUIJF60 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268116AbUIJF60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:58:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26250 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266344AbUIJF6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:58:13 -0400
Date: Fri, 10 Sep 2004 07:57:42 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Scott Wood <scott@timesys.com>, William Lee Irwin III <wli@holomorphy.com>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040910055742.GA2710@devserv.devel.redhat.com>
References: <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com> <20040909175441.GA25686@devserv.devel.redhat.com> <20040909211038.E6434@flint.arm.linux.org.uk> <20040909205153.GA1014@yoda.timesys> <20040909220004.F6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20040909220004.F6434@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Sep 09, 2004 at 10:00:04PM +0100, Russell King wrote:
> you'll realise how inadequate the "generic" IRQ code is for ARM.
> 
> Note that IRQ handling on ARM is a multi-level affair where we have
> multiple levels of interrupt controllers which need to be traversed
> in software.

I still propose the plan of action that is to consolidate first all
architectures that CAN share the x86 one, and THEN look at making that more
generic. The reason is simple; right now there are 20-ish copies; after the
initial consolidation there will be 4 or 5. Far easier to work on.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBQUJVxULwo51rQBIRAtf0AJ9fcDPIgW3QhdoA10kY9hfa55+UVACgkuDv
/Jmy0BNLYlq4CGCQsw0jHE4=
=LhwM
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
