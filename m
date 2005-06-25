Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFYSmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFYSmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVFYSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:42:34 -0400
Received: from [128.173.37.102] ([128.173.37.102]:38810 "EHLO
	h80ad2566.async.vt.edu") by vger.kernel.org with ESMTP
	id S261241AbVFYSmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:42:08 -0400
Message-Id: <200506251840.j5PIelGv012506@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Hackers Guide to git (v3) 
In-Reply-To: Your message of "Sat, 25 Jun 2005 01:13:46 EDT."
             <42BCE80A.2010802@pobox.com> 
From: Valdis.Kletnieks@vt.edu
References: <42BCE80A.2010802@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119724846_5998P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Jun 2005 14:40:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119724846_5998P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Jun 2005 01:13:46 EDT, Jeff Garzik said:

> Kernel Hackers' Guide to git
> 
> 
> 1) installing git

A nice document.  Unfortunately, my brain is tiny, and there's some
usage questions you don't cover, and I can't seem to figure out myself...

Let's say I've cloned Linus's git tree, and now I want to build a kernel
that has Linus's stuff, the 'audit' tree that's (last I checked) located at
kernel.org/pub/scm/linux/kernel/git/dwmw2/audit-2.6, and another tree (foobar-2.6).

1) How do I do this merge?

2) How do I handle if an audit-2.6 and foobar-2.6 patch conflict -
   a) for right now...
   b) so it gets it right the *next* time I pull both and there's a collision
      (possibly between the next foobar-2.6 changeset and my modification of
      the previous changeset's results to clean the conflict)

Another (possibly even more important to me at the moment) usage question:

I have a non-git 2.6.12-mm1 tree. Given a Linus git tree and an audit-2.6 git
tree, how do I create a tree that contains "2.6.12-mm1 plus additional
audit-2.6 changes since Andrew cut -mm1"?  (I'm chasing a bug that was
supposedly fixed in userspace audit-0.9.10, but is still borked for me in
0.9.13 - I'm suspecting the bugfix is dependent on a divergence between the
Fedora kernel (basically 2.6.12-git5 for this discussion) and -mm1...)


--==_Exmh_1119724846_5998P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCvaUucC3lWbTT17ARAjfgAJ9RWdP7x/uFWAN4RKQFJaWAXs69uQCfacqM
bO+tFK+RAJT327MTSo8EvZo=
=zMWg
-----END PGP SIGNATURE-----

--==_Exmh_1119724846_5998P--
