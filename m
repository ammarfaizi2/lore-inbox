Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbTJSSDH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTJSSDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:03:07 -0400
Received: from h80ad26a8.async.vt.edu ([128.173.38.168]:46218 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261996AbTJSSDE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:03:04 -0400
Message-Id: <200310191800.h9JI0hN5000712@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation 
In-Reply-To: Your message of "Sun, 19 Oct 2003 18:57:05 +0200."
             <Pine.LNX.4.44.0310191853220.19283-100000@gaia.cela.pl> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310191853220.19283-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1415767902P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 19 Oct 2003 14:00:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1415767902P
Content-Type: text/plain; charset=us-ascii

On Sun, 19 Oct 2003 18:57:05 +0200, Maciej Zenczykowski said:

> and zebra is an app - but they are still mainly kernel oriented.  The 
> first 3 depend only on kernel speed and the next 2 depend mostly on kernel 
> speed.  I'd say you just proved how important kernel optimilization is for 
> routers.

And we had a flame-fest a while ago about poll/epoll/etc and how optimizing
that is important for some applications., and discussions of how CPU scheduling
affects desktop applications, and how different I/O schedulers matter to
databases, and....

My point was that the kernel is there for the application's benefit (otherwise
we could have just said 'echo "main() { for(;;){}}" > linux.c' and been done
with it), and just because the iptables or route command say "do this" and
return, and the kernel is still "doing this" weeks later, doesn't change the
fact that it's happening at the application's request (although you *are*
correct that the tuning and optimization concerns are different).


--==_Exmh_1415767902P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ktFLcC3lWbTT17ARAhgsAJ0c3APqgdhWLI4y/oMjXUx0mJCNYwCgy7Ld
WpoV+zGHKGKkFQlRVovphDk=
=4CSf
-----END PGP SIGNATURE-----

--==_Exmh_1415767902P--
