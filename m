Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbUC2Vhc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbUC2Vhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:37:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263145AbUC2VhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:37:13 -0500
Date: Mon, 29 Mar 2004 23:36:50 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Lev Lvovsky <lists1@sonous.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040329213650.GC26854@devserv.devel.redhat.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <1080594005.3570.12.camel@laptop.fenrus.com> <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com> <1080595343.3570.15.camel@laptop.fenrus.com> <ACFAE876-81C7-11D8-A0A8-000A959DCC8C@sonous.com> <20040329212832.GB26854@devserv.devel.redhat.com> <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <D8E351AF-81C8-11D8-A0A8-000A959DCC8C@sonous.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 29, 2004 at 01:34:23PM -0800, Lev Lvovsky wrote:
> 
> On Mar 29, 2004, at 1:28 PM, Arjan van de Ven wrote:
> >>perfect - where does this variable get set?  sorry for what now seems
> >>like OT glibc stuff.
> >
> >it's passed to glibc ./configure at build time; if you have an rpm 
> >based
> >distro you'll see it in the specfile of the src.rpm
> 
> ok, so this presents a bit of a problem in that case (assuming I'm 
> understanding you) - I'm working backwards in this respect, as I'm 
> using the "new" version of glibc, and an older version of the kernel 
> than the one that glibc was told to remain compatible with - the 
> important question, is does this order of operations (possibly) break 
> things, or does the fact that I compiled the kernel on this new version 
> of glibc remove any issues.

glibc will just plain refuse to operate (correctly). glibc makes assumptions
about not needing workarounds for older kernels if you tell it it can assume
a newer kernel...

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAaJbxxULwo51rQBIRAsu9AJ9UVunm6E6TKF5oLjXetx3x4Pi4rQCfeM4r
aYuEiv+6/TFozsTYuNxf+Ks=
=qB4G
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
