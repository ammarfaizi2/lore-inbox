Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbUCTJ5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 04:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbUCTJ5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 04:57:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36331 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263292AbUCTJ5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 04:57:11 -0500
Date: Sat, 20 Mar 2004 10:56:28 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       peterw@aurema.com, ak@muc.de, Richard.Curnow@superh.com
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040320095627.GC2803@devserv.devel.redhat.com>
References: <1079453698.2255.661.camel@cube>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <1079453698.2255.661.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 16, 2004 at 11:14:59AM -0500, Albert Cahalan wrote:
> > there is one. Nothing uses it
> > (sysconf() provides this info)
> 
> If you have a recent glibc on a recent kernel, it might.
> You could also get a -1 or a supposed ABI value that
> has nothing to do with the kernel currently running.
> The most reliable way is to first look around on the
> stack in search of ELF notes, and then fall back to
> some horribly gross hacks as needed.

eh sysconf() is the nice way to get to the ELF notes instead of having to
grovel yourself.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAXBVLxULwo51rQBIRApNDAJ9l36sfze3W24oiXTDuJZD8C5Ue9QCgj0Tp
3unneq65dv/RjEsp4oNQ35M=
=HSrf
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
