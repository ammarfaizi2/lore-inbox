Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263478AbTCNTmM>; Fri, 14 Mar 2003 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263481AbTCNTmM>; Fri, 14 Mar 2003 14:42:12 -0500
Received: from quake.mweb.co.za ([196.2.45.76]:40084 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id <S263478AbTCNTmK>;
	Fri, 14 Mar 2003 14:42:10 -0500
Date: Fri, 14 Mar 2003 21:53:19 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: mquiros@ugr.es, linux-kernel@vger.kernel.org
Subject: Re: make modules_install fail: depmod *** Unresolved symbols
 (official
Message-Id: <20030314215319.78baf4e6.bonganilinux@mweb.co.za>
In-Reply-To: <1047651405.3503.103.camel@workshop.saharact.lan>
References: <E18tpXR-0007oI-00@rammstein.mweb.co.za>
	<1047651405.3503.103.camel@workshop.saharact.lan>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.72w'r'WJhIqzAr"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.72w'r'WJhIqzAr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2003 16:16:45 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:

> On Fri, 2003-03-14 at 16:03, bonganilinux@mweb.co.za wrote:
> > > 			Granada, 14-3-2002
> > > 
> > > Hello, I downloaded kernel 2.4.20 and compiled it sucessfully a month
> > > ago without any aparent problem. Yesterday I tried to compile it again
> > > in the same computer just changing a couple of small things in the
> > > configuration (agpart and the network card changed from "module" to
> > > "yes").
> > > 
> > > make dep, make bzImage and make modules went apparently well (expect for
> > > a few apparently non-important warnings with bzImage of the type
> > > Warning: indirect call without '*' when compiling pci-pc and apm).
> > > 
> > > But when I try make modules_install, I've got a lot of error messages.
> > > For each module I've got one line like:
> > > 
> > > depmod:  *** Unresolved symbols in
> > > /lib/modules/2.4.20/kernel/arch/i386/kernel/microcode.o
> > > 
> > > followed by a number of lines of the type
> > > 
> > > depmod:     misc_deregister
> > > depmod:     __generic_copy_from_use
> > > depmod:     .....
> > 
> > Download, compile and install Rusty's latest module-init-tools
> > ftp.kernel.org/pub/linux/kernel/people/rusty/modules
> > 
> 
> Errr, he got 2.4.20, not 2.5.48+ ....
> 
> Miguel:  Not a real fix, but try compiling microcode.o into the
>          kernel and not as a module ...
> 
> 

Oops sorry I missed that (I've seen to many depmod errors after a cooker update
and 2.5 compile bad  me :{ )

--=.72w'r'WJhIqzAr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+cjM3+pvEqv8+FEMRAloPAJ9zGLWZV/wh1RBo/5DtuIx0ToIkuQCfe25/
XhET+FUX/kqanwu7CKk5S4A=
=dUG2
-----END PGP SIGNATURE-----

--=.72w'r'WJhIqzAr--
