Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUKIAAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUKIAAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUKIAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:00:54 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:53642 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261309AbUKIAAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:00:43 -0500
Message-Id: <200411090000.iA900Obi004485@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: linux-os@analogic.com
Cc: Colin Leroy <colin.lkml@colino.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: insmod module-loading errors, Linux-2.6.9 
In-Reply-To: Your message of "Mon, 08 Nov 2004 12:52:18 EST."
             <Pine.LNX.4.61.0411081242240.5779@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0411081007530.3682@chaos.analogic.com> <20041108175638.2b3da7b3.colin.lkml@colino.net>
            <Pine.LNX.4.61.0411081242240.5779@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1297004504P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Nov 2004 19:00:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1297004504P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Nov 2004 12:52:18 EST, linux-os said:

> There are certainly work-arounds for problems that shouldn't
> exist at all. So, every time I do something to a kernel, I
> have to change whatever the EXTRAVERSION field is?  Then, when
> a customer demands that the kernel version be exactly the
> same that was shipped with Fedora or whatever, I'm screwed.

If you didn't have the foresight to keep that kernel version around,
there isn't much we can do to help you.  Yes, this may mean you have
a big bunch of /usr/src/linux-2.6.* directories.

Note that you can *still* get screwed unless you keep the same
compiler toolchain around...

> They simply should not have removed the "-f" option of
> insmod. It's just that simple. This option allowed transient
> (possible) incompatibilities so that one could be productive
> and not spend a whole day reinstalling from a distribution
> CD because the new modules wouldn't work because somebody
> decided that their special VERMAGIC_STRING was so ")@*&#$%)"
> important that they preempted my work. Don't get me started....

Yes, instead you can spend a whole day reinstalling from a
distribution CD, and then restoring user files from backup,
because the new module you just 'insmod -f' had a different
number of parameters to some kernel call, and as a result your
stack got smashed and took the root filesystem with it....

--==_Exmh_-1297004504P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBkAiXcC3lWbTT17ARAjaOAJ0TbVgZn+VhlocuMpX+2aj4qveMLgCggle8
lfwPIhsYiTLuZsXncEJlrkg=
=cphS
-----END PGP SIGNATURE-----

--==_Exmh_-1297004504P--
