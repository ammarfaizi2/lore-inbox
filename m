Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264021AbUDVNMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbUDVNMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbUDVNMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:12:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264021AbUDVNMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:12:24 -0400
Date: Thu, 22 Apr 2004 15:11:36 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040422131135.GA7589@devserv.devel.redhat.com>
References: <OF8486E763.A98E66AA-ONC1256E7E.00452A1A-C1256E7E.0045F93D@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <OF8486E763.A98E66AA-ONC1256E7E.00452A1A-C1256E7E.0045F93D@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 22, 2004 at 02:44:17PM +0200, Martin Schwidefsky wrote:
> 
> 
> 
> 
> > xtime is easy, that's interpolated anyway afaics. Jiffies would either
> just
> > jump some, which code needs to deal with anyway given that preempt can do
> > the same, or would become an approximated thing as well based on the
> other
> > time keeping sources in the system.
> 
> Unluckily no. xtime is not easy because the network stack uses this for
> time stamps at several locations. Living in the past and time stamps for
> network packets don't go together, do they?

I thought this got fixed last week. But as I said it's easy to interpolate.

> By the way I am planning to do a BOFS at the OLS in july where I'd like
> to discuss exactly this kind of questions. Any chance that you'd be there
> too?

quite possible, I haven't booked my flight yet tho 
--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAh8SExULwo51rQBIRAgXAAKCRIWN0xMqEs6MPYz7d3G9d2arj7ACfbzGj
oTlVrzQqVnSjq9sAJTf+ZgE=
=OCfR
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
