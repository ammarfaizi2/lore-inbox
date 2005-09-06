Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVIFSx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVIFSx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVIFSx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:53:26 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:461 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750797AbVIFSxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:53:25 -0400
Message-Id: <200509061853.j86IrI3T016264@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Bret Towe <magnade@gmail.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug 
In-Reply-To: Your message of "Tue, 06 Sep 2005 14:30:08 EDT."
             <20050906183008.GG10632@fieldses.org> 
From: Valdis.Kletnieks@vt.edu
References: <dda83e78050904124454fc675a@mail.gmail.com> <dda83e78050904135113b95c4a@mail.gmail.com> <20050904215219.GA9812@fieldses.org> <dda83e780509042008294fbe26@mail.gmail.com> <20050905031825.GA22209@fieldses.org> <dda83e78050905134420f06fbf@mail.gmail.com> <9a87484905090513481118e67b@mail.gmail.com> <dda83e7805090520407aefb4d1@mail.gmail.com> <20050906181327.GE10632@fieldses.org> <Pine.LNX.4.50.0509061119380.19596-100000@shark.he.net>
            <20050906183008.GG10632@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126032798_2971P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Sep 2005 14:53:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126032798_2971P
Content-Type: text/plain; charset=us-ascii

On Tue, 06 Sep 2005 14:30:08 EDT, "J. Bruce Fields" said:
> On Tue, Sep 06, 2005 at 11:21:09AM -0700, Randy.Dunlap wrote:
> > On Tue, 6 Sep 2005, J. Bruce Fields wrote:
> > 
> > > On Mon, Sep 05, 2005 at 08:40:53PM -0700, Bret Towe wrote:
> > > > Pid: 14169, comm: xmms Tainted: G   M  2.6.13
> > >
> > > Hm, can someone explain what that means?  A proprietary module was
> > > loaded then unloaded, maybe?
> > 
> > 'M' means Machine Check, which sets the Tainted flag.
> > So the processor thought that there was some kind of problem.
> 
> Does this NMI watchdog event ("NMI Watchdog detected LOCKUP on CPU0CPU
> 0") set that flag?

Not directly - but if the MCE wedged a processor, that could cause the NMI
to fire complaining about a lockup.  You should have a MCE logged someplace.

--==_Exmh_1126032798_2971P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDHeWdcC3lWbTT17ARAuaCAKCl16qRA5JPk8KFZFP/HVHJiG2M/QCgq5J9
t/bq+85AlbaV2bJTc+kdft4=
=iI0z
-----END PGP SIGNATURE-----

--==_Exmh_1126032798_2971P--
