Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUC2V3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbUC2V3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:29:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262862AbUC2V25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:28:57 -0500
Date: Mon, 29 Mar 2004 23:28:34 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Lev Lvovsky <lists1@sonous.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040329212832.GB26854@devserv.devel.redhat.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <1080594005.3570.12.camel@laptop.fenrus.com> <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com> <1080595343.3570.15.camel@laptop.fenrus.com> <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Mon, Mar 29, 2004 at 01:26:00PM -0800, Lev Lvovsky wrote:
> On Mar 29, 2004, at 1:22 PM, Arjan van de Ven wrote:
> 
> >On Mon, 2004-03-29 at 23:09, Lev Lvovsky wrote:
> >>We have the source of the drivers, but they are specific to the 2.2.x
> >>kernels.  I am not a kernel hacker, and this would be way beyond my
> >>area of expertise.
> >>
> >>And sadly, this doesn't answer the initial question.
> >
> >then to answer your question; at compile time you tell glibc what
> >minimum kernel version it can assume, and based on that glibc will
> >enable/disable certain features. So it depends on what your distro
> >supplied there if it'll work or not. if you tell glibc that at minimum
> >you do 2.4.1 for example, then no a 2.2 kernel won't work. I think most
> >distros do this (or an even later version) since a few years now.
> 
> perfect - where does this variable get set?  sorry for what now seems 
> like OT glibc stuff.

it's passed to glibc ./configure at build time; if you have an rpm based
distro you'll see it in the specfile of the src.rpm

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAaJUAxULwo51rQBIRApoDAJ0RssU3B4wy7jNZm5XLrNo3Qh+rPwCgktoK
YVukpT14wMpTBDlRUE+2i5U=
=UYXe
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
