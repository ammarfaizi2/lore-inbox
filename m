Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269806AbUICTjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269806AbUICTjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269759AbUICTiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:38:51 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64235 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269768AbUICTaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:30:15 -0400
Message-Id: <200409031930.i83JUBpw001359@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The argument for fs assistance in handling archives (was: silent semantic changes with reiser4) 
In-Reply-To: Your message of "Fri, 03 Sep 2004 03:13:35 EDT."
             <20040903071335.GB16619@delft.aura.cs.cmu.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <1094118362.4847.23.camel@localhost.localdomain> <20040902203854.GA4801@janus> <200409022319.i82NJlTN025039@turing-police.cc.vt.edu>
            <20040903071335.GB16619@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_184083834P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Sep 2004 15:30:11 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_184083834P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Sep 2004 03:13:35 EDT, Jan Harkes said:
> On Thu, Sep 02, 2004 at 07:19:47PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 02 Sep 2004 22:38:54 +0200, Frank van Maarseveen said:
> > > 	cd /dev/cdrom
> > > 	ls
> > 
> > And the CD in the drive at the moment is AC/DC "Back in Black".  What
> > should this produce as output?
> 
> Hehe, cdfs already figured that one out. Ofcourse you show the
> individual tracks as .wav files.

That's sidestepping the *real* issue - which is that you need reasonable semantics
even if you don't have cdfs or whatever special gee-wizz-bang driver handy.

Consider an embedded system - it may have iso9660 support, and boot off a CD
like Knoppix, but not have cdfs.  What do you do then?

(For bonus points, figure out the security issues involved in dealing with an intentionall
corrupted image on a CD......)

--==_Exmh_184083834P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBOMZDcC3lWbTT17ARAuoVAJ9SxudBz2N58qKQmHzozJRlZasqewCeMBlQ
Ks+1LYugoGMXth1CQ29PD0o=
=h5J4
-----END PGP SIGNATURE-----

--==_Exmh_184083834P--
