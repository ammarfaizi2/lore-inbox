Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUDAQC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDAQC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:02:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262935AbUDAQCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:02:25 -0500
Date: Thu, 1 Apr 2004 18:01:32 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040401160132.GB13294@devserv.devel.redhat.com>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
In-Reply-To: <20040401155420.GB25502@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2004 at 04:54:20PM +0100, Jamie Lokier wrote:
> Albert Cahalan wrote:
> > If you rely on sysconf(_SC_CLK_TCK) to work, then
> > your software will support:
> > 
> > * all systems with a 2.6.xx kernel
> > * all systems with a 2.4.xx kernel and recent glibc
> > * all i386 systems running with the default HZ
> > 
> > That's quite a bit I suppose. Maybe you have no
> > interest in supporting a 1200 HZ Alpha with an old
> > kernel or glibc. Maybe you don't care about somebody
> > running a 2.2.xx kernel with modified HZ.
> 
> I'm still unclear.  Does sysconf(_SC_CLK_TCK), when it is reliable,
> return HZ or USER_HZ?

USER_HZ; the value all the userspace interfaces are in.
HZ doesn't mean nothing, esp when we go to a tickless kernel...

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAbDzcxULwo51rQBIRAu5WAKCgA/O3SB30gWD8ONCFXlRkWmIn7gCginIK
VpqIJxn8IR2NgdmxtejtDLY=
=QzFx
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
