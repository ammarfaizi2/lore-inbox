Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUFXJGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUFXJGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXJGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:06:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263850AbUFXJGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:06:31 -0400
Date: Thu, 24 Jun 2004 11:06:05 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624090605.GA11805@devserv.devel.redhat.com>
References: <20040624070936.GB30057@devserv.devel.redhat.com> <20040624020022.0601d4ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20040624020022.0601d4ae.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 02:00:22AM -0700, Andrew Morton wrote:
> >  and/or architectures.... is this worth doing?
> 
> I guess it depends on the resulting code size and quality.  Some extra
> conversions would be needed for that.

ok I'll see if I can get some detailed info on that

> 
> For the implementation it would be nice to have the old-style
> implementations in one header and the new-style ones in a separate header. 
> That would create a bit of an all-or-nothing situation, but that should be
> OK?

Perhaps. It's not impossible that say gcc 3.5 will add a few more builtins
even that then allow more functions to be converted, otoh that shouldn't be
impossible to cope with. I'll have a look to see how it pans out.

Greetings,
   Arjan van de Ven

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2pl8xULwo51rQBIRAs3GAJ9mL9+aWguCARFxcrNG/b4HjH/uYQCgigh1
utdskuq5EhrCkKH8Y3+GfNw=
=za9k
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
